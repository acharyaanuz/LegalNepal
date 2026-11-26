from django.conf import settings
from django.core.validators import MinValueValidator, MaxValueValidator
from django.db import models


class LawyerProfile(models.Model):
    user = models.OneToOneField(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="lawyer_profile")
    bar_number = models.CharField(max_length=80, unique=True)
    bio = models.TextField(blank=True)
    specializations = models.JSONField(default=list, blank=True)
    years_experience = models.PositiveSmallIntegerField(default=0)
    office_address = models.CharField(max_length=255, blank=True)
    city = models.CharField(max_length=100, blank=True)
    consultation_fee = models.DecimalField(max_digits=10, decimal_places=2, default=0, validators=[MinValueValidator(0)])
    is_verified = models.BooleanField(default=False)
    rating = models.DecimalField(max_digits=3, decimal_places=2, default=0, validators=[MinValueValidator(0), MaxValueValidator(5)])
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.user.get_full_name() or self.user.email} ({self.bar_number})"
