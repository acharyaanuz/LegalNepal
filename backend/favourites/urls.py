from django.urls import path
from .views import (FavouriteArticleDetailView, FavouriteArticleListCreateView,
                    FavouriteLawyerDetailView, FavouriteLawyerListCreateView)

urlpatterns = [
    path("lawyers/", FavouriteLawyerListCreateView.as_view(), name="favourite-lawyer-list"),
    path("lawyers/<int:pk>/", FavouriteLawyerDetailView.as_view(), name="favourite-lawyer-detail"),
    path("articles/", FavouriteArticleListCreateView.as_view(), name="favourite-article-list"),
    path("articles/<int:pk>/", FavouriteArticleDetailView.as_view(), name="favourite-article-detail"),
]
