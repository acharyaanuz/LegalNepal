from rest_framework import generics, permissions, serializers
from rest_framework.exceptions import PermissionDenied
from .models import Consultation
from .serializers import ConsultationSerializer


class ConsultationListCreateView(generics.ListCreateAPIView):
    serializer_class = ConsultationSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        return Consultation.objects.select_related("client", "lawyer").filter(client=user) | Consultation.objects.select_related("client", "lawyer").filter(lawyer=user)

    def perform_create(self, serializer):
        if self.request.user.role != "client":
            raise PermissionDenied("Only client accounts can request consultations.")
        serializer.save(client=self.request.user)


class ConsultationDetailView(generics.RetrieveUpdateAPIView):
    serializer_class = ConsultationSerializer
    permission_classes = [permissions.IsAuthenticated]
    http_method_names = ["get", "patch", "head", "options"]

    def get_queryset(self):
        return Consultation.objects.select_related("client", "lawyer").filter(client=self.request.user) | Consultation.objects.select_related("client", "lawyer").filter(lawyer=self.request.user)

    def get_serializer(self, *args, **kwargs):
        serializer = super().get_serializer(*args, **kwargs)
        if self.request.method in ("PUT", "PATCH"):
            if self.get_object().lawyer_id == self.request.user.id:
                serializer.fields["status"].read_only = False
                serializer.fields["lawyer_notes"].read_only = False
            else:
                serializer.fields["scheduled_at"].read_only = False
        return serializer

    def perform_update(self, serializer):
        obj = self.get_object()
        if obj.lawyer_id == self.request.user.id:
            if serializer.validated_data.get("status") not in {"accepted", "rejected", "completed"}:
                raise serializers.ValidationError({"status": "Lawyers may accept, reject, or complete a request."})
        elif any(key in serializer.validated_data for key in ("status", "lawyer_notes")):
            raise PermissionDenied("Clients cannot change consultation status or lawyer notes.")
        serializer.save()
