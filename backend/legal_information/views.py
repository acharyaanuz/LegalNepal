from rest_framework import generics, permissions
from rest_framework.exceptions import PermissionDenied
from .models import Article, Category
from .serializers import ArticleSerializer, CategorySerializer


class StaffWriteMixin:
    def get_permissions(self):
        return [permissions.AllowAny()] if self.request.method in permissions.SAFE_METHODS else [permissions.IsAdminUser()]


class CategoryListCreateView(StaffWriteMixin, generics.ListCreateAPIView):
    queryset = Category.objects.all().order_by("name")
    serializer_class = CategorySerializer


class ArticleListCreateView(StaffWriteMixin, generics.ListCreateAPIView):
    serializer_class = ArticleSerializer

    def get_queryset(self):
        qs = Article.objects.select_related("category", "author")
        if not self.request.user.is_staff:
            qs = qs.filter(is_published=True)
        category = self.request.query_params.get("category")
        if category:
            qs = qs.filter(category__slug=category)
        return qs

    def perform_create(self, serializer):
        serializer.save(author=self.request.user)


class ArticleDetailView(StaffWriteMixin, generics.RetrieveUpdateDestroyAPIView):
    queryset = Article.objects.select_related("category", "author")
    serializer_class = ArticleSerializer
    lookup_field = "slug"

    def get_queryset(self):
        qs = super().get_queryset()
        if not self.request.user.is_staff:
            qs = qs.filter(is_published=True)
        return qs
