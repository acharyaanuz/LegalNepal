from django.urls import path
from .views import LawyerDetailView, LawyerListCreateView, MyLawyerProfileView

urlpatterns = [
    path("", LawyerListCreateView.as_view(), name="lawyer-list"),
    path("me/", MyLawyerProfileView.as_view(), name="my-lawyer-profile"),
    path("<int:pk>/", LawyerDetailView.as_view(), name="lawyer-detail"),
]
