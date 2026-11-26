from rest_framework import serializers
from .models import Article, Category


class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = ("id", "name", "slug", "description")
        read_only_fields = ("id", "slug")


class ArticleSerializer(serializers.ModelSerializer):
    category_name = serializers.CharField(source="category.name", read_only=True)
    author_name = serializers.CharField(source="author.get_full_name", read_only=True)

    class Meta:
        model = Article
        fields = ("id", "category", "category_name", "author", "author_name", "title", "slug", "summary", "content", "source_url", "is_published", "created_at", "updated_at")
        read_only_fields = ("id", "author", "slug", "created_at", "updated_at")
