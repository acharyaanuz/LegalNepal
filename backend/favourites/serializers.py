from rest_framework import serializers
from lawyers.serializers import LawyerProfileSerializer
from legal_information.serializers import ArticleSerializer
from .models import FavouriteArticle, FavouriteLawyer


class FavouriteLawyerSerializer(serializers.ModelSerializer):
    lawyer_details = LawyerProfileSerializer(source="lawyer", read_only=True)

    class Meta:
        model = FavouriteLawyer
        fields = ("id", "lawyer", "lawyer_details", "created_at")
        read_only_fields = ("id", "created_at")


class FavouriteArticleSerializer(serializers.ModelSerializer):
    article_details = ArticleSerializer(source="article", read_only=True)

    class Meta:
        model = FavouriteArticle
        fields = ("id", "article", "article_details", "created_at")
        read_only_fields = ("id", "created_at")
