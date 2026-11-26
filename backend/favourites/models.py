from django.conf import settings
from django.db import models
from lawyers.models import LawyerProfile
from legal_information.models import Article


class FavouriteLawyer(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="favourite_lawyers")
    lawyer = models.ForeignKey(LawyerProfile, on_delete=models.CASCADE, related_name="favourited_by")
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ["-created_at"]
        constraints = [models.UniqueConstraint(fields=["user", "lawyer"], name="unique_favourite_lawyer")]


class FavouriteArticle(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="favourite_articles")
    article = models.ForeignKey(Article, on_delete=models.CASCADE, related_name="favourited_by")
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ["-created_at"]
        constraints = [models.UniqueConstraint(fields=["user", "article"], name="unique_favourite_article")]
