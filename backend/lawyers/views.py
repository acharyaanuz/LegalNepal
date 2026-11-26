from rest_framework import generics, permissions
from .models import LawyerProfile
from .serializers import LawyerProfileSerializer


class LawyerListCreateView(generics.ListCreateAPIView):
    serializer_class = LawyerProfileSerializer

    def get_queryset(self):
        qs = LawyerProfile.objects.select_related("user").all()
        city = self.request.query_params.get("city")
        specialization = self.request.query_params.get("specialization")
        if city:
            qs = qs.filter(city__icontains=city)
        if specialization:
            qs = qs.filter(specializations__contains=[specialization])
        return qs

    def get_permissions(self):
        return [permissions.IsAuthenticated()] if self.request.method == "POST" else [permissions.AllowAny()]

    def perform_create(self, serializer):
        if self.request.user.role != "lawyer":
            from rest_framework.exceptions import PermissionDenied
            raise PermissionDenied("Only lawyer accounts can create a lawyer profile.")
        serializer.save(user=self.request.user)


class LawyerDetailView(generics.RetrieveUpdateDestroyAPIView):
    queryset = LawyerProfile.objects.select_related("user")
    serializer_class = LawyerProfileSerializer
    http_method_names = ["get", "patch", "head", "options"]

    def get_permissions(self):
        return [permissions.AllowAny()] if self.request.method == "GET" else [permissions.IsAuthenticated()]

    def perform_update(self, serializer):
        if serializer.instance.user_id != self.request.user.id and not self.request.user.is_staff:
            from rest_framework.exceptions import PermissionDenied
            raise PermissionDenied("You can only edit your own profile.")
        serializer.save()
