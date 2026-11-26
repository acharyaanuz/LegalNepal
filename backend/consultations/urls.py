from django.urls import path
from .views import ConsultationDetailView, ConsultationListCreateView

urlpatterns = [path("", ConsultationListCreateView.as_view(), name="consultation-list"), path("<int:pk>/", ConsultationDetailView.as_view(), name="consultation-detail")]
