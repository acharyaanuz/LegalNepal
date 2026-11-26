from django.urls import path
from .views import LawyerDetailView, LawyerListCreateView

urlpatterns = [path("", LawyerListCreateView.as_view(), name="lawyer-list"), path("<int:pk>/", LawyerDetailView.as_view(), name="lawyer-detail")]
