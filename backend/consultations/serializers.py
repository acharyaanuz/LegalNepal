from rest_framework import serializers
from .models import Consultation


class ConsultationSerializer(serializers.ModelSerializer):
    client_name = serializers.CharField(source="client.get_full_name", read_only=True)
    lawyer_name = serializers.CharField(source="lawyer.get_full_name", read_only=True)

    class Meta:
        model = Consultation
        fields = ("id", "client", "client_name", "lawyer", "lawyer_name", "subject", "description", "scheduled_at", "status", "lawyer_notes", "created_at", "updated_at")
        read_only_fields = ("id", "client", "client_name", "lawyer_name", "status", "lawyer_notes", "created_at", "updated_at")

    def validate_lawyer(self, value):
        if value.role != "lawyer" or not hasattr(value, "lawyer_profile"):
            raise serializers.ValidationError("Select an account with a lawyer profile.")
        return value
