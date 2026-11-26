from rest_framework import generics, permissions
from .models import FavouriteArticle, FavouriteLawyer
from .serializers import FavouriteArticleSerializer, FavouriteLawyerSerializer


class OwnedFavouriteMixin:
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        return self.model.objects.filter(user=self.request.user).select_related(*self.related)

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)


class FavouriteLawyerListCreateView(OwnedFavouriteMixin, generics.ListCreateAPIView):
    model = FavouriteLawyer
    related = ("lawyer", "lawyer__user")
    serializer_class = FavouriteLawyerSerializer


class FavouriteLawyerDetailView(OwnedFavouriteMixin, generics.DestroyAPIView):
    model = FavouriteLawyer
    related = ("lawyer", "lawyer__user")
    serializer_class = FavouriteLawyerSerializer


class FavouriteArticleListCreateView(OwnedFavouriteMixin, generics.ListCreateAPIView):
    model = FavouriteArticle
    related = ("article", "article__category")
    serializer_class = FavouriteArticleSerializer


class FavouriteArticleDetailView(OwnedFavouriteMixin, generics.DestroyAPIView):
    model = FavouriteArticle
    related = ("article", "article__category")
    serializer_class = FavouriteArticleSerializer
