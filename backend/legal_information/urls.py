from django.urls import path
from .views import ArticleDetailView, ArticleListCreateView, CategoryListCreateView

urlpatterns = [path("categories/", CategoryListCreateView.as_view(), name="category-list"), path("articles/", ArticleListCreateView.as_view(), name="article-list"), path("articles/<slug:slug>/", ArticleDetailView.as_view(), name="article-detail")]
