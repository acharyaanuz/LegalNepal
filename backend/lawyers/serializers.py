from rest_framework import serializers
from .models import LawyerProfile


class LawyerProfileSerializer(serializers.ModelSerializer):
    name = serializers.CharField(source="user.get_full_name", read_only=True)

    class Meta:
        model = LawyerProfile
        fields = ("id", "user", "name", "bar_number", "bio", "specializations", "years_experience", "office_address", "city", "consultation_fee", "is_verified", "rating", "created_at", "updated_at")
        read_only_fields = ("id", "user", "is_verified", "rating", "created_at", "updated_at")
