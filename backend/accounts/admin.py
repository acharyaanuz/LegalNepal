from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import User


@admin.register(User)
class CustomUserAdmin(UserAdmin):
    fieldsets = UserAdmin.fieldsets + (("LegalNepal", {"fields": ("phone", "role")}),)
    add_fieldsets = UserAdmin.add_fieldsets + (("LegalNepal", {"fields": ("email", "phone", "role")}),)
    list_display = ("email", "username", "role", "is_staff")
