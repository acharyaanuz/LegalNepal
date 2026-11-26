from rest_framework import generics, permissions, status
from rest_framework.exceptions import PermissionDenied, ValidationError
from rest_framework.response import Response
from django.db.models import Q, TextField
from django.db.models.functions import Cast
from .models import LawyerProfile
from .serializers import LawyerProfileSerializer


class LawyerListCreateView(generics.ListCreateAPIView):
    serializer_class = LawyerProfileSerializer

    def get_queryset(self):
        qs = LawyerProfile.objects.select_related("user").all()
        if self.request.method == "GET":
            qs = qs.filter(is_verified=True)
        city = self.request.query_params.get("city")
        specialization = self.request.query_params.get("specialization")
        if city:
            qs = qs.filter(city__icontains=city)
        if specialization:
            qs = qs.annotate(specializations_text=Cast("specializations", TextField())).filter(
                specializations_text__icontains=specialization
            )
        search = self.request.query_params.get("search")
        if search:
            qs = qs.filter(
                Q(user__first_name__icontains=search)
                | Q(user__last_name__icontains=search)
                | Q(city__icontains=search)
                | Q(bio__icontains=search)
            )
        return qs

    def get_permissions(self):
        return [permissions.IsAuthenticated()] if self.request.method == "POST" else [permissions.AllowAny()]

    def perform_create(self, serializer):
        if self.request.user.role != "lawyer":
            raise PermissionDenied("Only lawyer accounts can create a lawyer profile.")
        if LawyerProfile.objects.filter(user=self.request.user).exists():
            raise ValidationError("A lawyer profile already exists for this account.")
        serializer.save(user=self.request.user)


class LawyerDetailView(generics.RetrieveUpdateDestroyAPIView):
    queryset = LawyerProfile.objects.select_related("user")
    serializer_class = LawyerProfileSerializer
    http_method_names = ["get", "patch", "head", "options"]

    def get_queryset(self):
        queryset = super().get_queryset()
        if self.request.user.is_authenticated:
            return queryset.filter(Q(is_verified=True) | Q(user=self.request.user))
        return queryset.filter(is_verified=True)

    def get_permissions(self):
        return [permissions.AllowAny()] if self.request.method == "GET" else [permissions.IsAuthenticated()]

    def perform_update(self, serializer):
        if serializer.instance.user_id != self.request.user.id and not self.request.user.is_staff:
            raise PermissionDenied("You can only edit your own profile.")
        serializer.save()


class MyLawyerProfileView(generics.RetrieveUpdateAPIView):
    serializer_class = LawyerProfileSerializer
    permission_classes = [permissions.IsAuthenticated]
    http_method_names = ["get", "post", "patch", "head", "options"]

    def get_object(self):
        if self.request.user.role != "lawyer":
            raise PermissionDenied("Only lawyer accounts have lawyer profiles.")
        try:
            return LawyerProfile.objects.select_related("user").get(user=self.request.user)
        except LawyerProfile.DoesNotExist:
            from rest_framework.exceptions import NotFound
            raise NotFound("Create your lawyer profile to continue.")

    def post(self, request, *args, **kwargs):
        if request.user.role != "lawyer":
            raise PermissionDenied("Only lawyer accounts can create a lawyer profile.")
        if LawyerProfile.objects.filter(user=request.user).exists():
            raise ValidationError("A lawyer profile already exists for this account.")
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save(user=request.user)
        return Response(serializer.data, status=status.HTTP_201_CREATED)
