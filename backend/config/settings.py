"""Base settings for local LegalNepal backend development."""
from pathlib import Path
from datetime import timedelta
from django.core.exceptions import ImproperlyConfigured

from decouple import Csv, config

BASE_DIR = Path(__file__).resolve().parent.parent
SECRET_KEY = config("DJANGO_SECRET_KEY", default="")
DEBUG = config("DJANGO_DEBUG", default=False, cast=bool)
if not SECRET_KEY or SECRET_KEY.startswith("replace-with-"):
    raise ImproperlyConfigured("Set DJANGO_SECRET_KEY to a private random value.")
ALLOWED_HOSTS = config("DJANGO_ALLOWED_HOSTS", default="localhost,127.0.0.1", cast=Csv())
if not DEBUG and ALLOWED_HOSTS == ["localhost", "127.0.0.1"]:
    raise ImproperlyConfigured("Set DJANGO_ALLOWED_HOSTS for the production host.")

INSTALLED_APPS = [
    "django.contrib.admin", "django.contrib.auth", "django.contrib.contenttypes",
    "django.contrib.sessions", "django.contrib.messages", "django.contrib.staticfiles",
    "rest_framework", "corsheaders", "drf_spectacular",
    "accounts.apps.AccountsConfig",
    "lawyers.apps.LawyersConfig",
    "legal_information.apps.LegalInformationConfig",
    "consultations.apps.ConsultationsConfig",
    "favourites.apps.FavouritesConfig",
]
AUTH_USER_MODEL = "accounts.User"
MIDDLEWARE = [
    "django.middleware.security.SecurityMiddleware",
    "django.contrib.sessions.middleware.SessionMiddleware",
    "corsheaders.middleware.CorsMiddleware",
    "django.middleware.common.CommonMiddleware",
    "django.middleware.csrf.CsrfViewMiddleware",
    "django.contrib.auth.middleware.AuthenticationMiddleware",
    "django.contrib.messages.middleware.MessageMiddleware",
    "django.middleware.clickjacking.XFrameOptionsMiddleware",
]
ROOT_URLCONF = "config.urls"
TEMPLATES = [{
    "BACKEND": "django.template.backends.django.DjangoTemplates",
    "DIRS": [], "APP_DIRS": True,
    "OPTIONS": {"context_processors": [
        "django.template.context_processors.request",
        "django.contrib.auth.context_processors.auth",
        "django.contrib.messages.context_processors.messages",
    ]},
}]
WSGI_APPLICATION = "config.wsgi.application"
ASGI_APPLICATION = "config.asgi.application"

DATABASE_URL = config("DATABASE_URL", default="")
if DATABASE_URL.startswith(("postgres://", "postgresql://")):
    from urllib.parse import urlparse

    parsed = urlparse(DATABASE_URL)
    DATABASES = {"default": {
        "ENGINE": "django.db.backends.postgresql",
        "NAME": parsed.path.lstrip("/"), "USER": parsed.username or "",
        "PASSWORD": parsed.password or "", "HOST": parsed.hostname or "localhost",
        "PORT": parsed.port or 5432, "CONN_MAX_AGE": 60,
    }}
else:
    DATABASES = {"default": {
        "ENGINE": "django.db.backends.sqlite3", "NAME": BASE_DIR / "db.sqlite3",
    }}

AUTH_PASSWORD_VALIDATORS = [
    {"NAME": "django.contrib.auth.password_validation.UserAttributeSimilarityValidator"},
    {"NAME": "django.contrib.auth.password_validation.MinimumLengthValidator"},
    {"NAME": "django.contrib.auth.password_validation.CommonPasswordValidator"},
    {"NAME": "django.contrib.auth.password_validation.NumericPasswordValidator"},
]
LANGUAGE_CODE = "en-us"
TIME_ZONE = "Asia/Kathmandu"
USE_I18N = True
USE_TZ = True
STATIC_URL = "static/"
MEDIA_URL = "media/"
MEDIA_ROOT = BASE_DIR / "media"
DEFAULT_AUTO_FIELD = "django.db.models.BigAutoField"

REST_FRAMEWORK = {
    "DEFAULT_SCHEMA_CLASS": "drf_spectacular.openapi.AutoSchema",
    "DEFAULT_AUTHENTICATION_CLASSES": (
        "rest_framework_simplejwt.authentication.JWTAuthentication",
    ),
    "DEFAULT_PERMISSION_CLASSES": (
        "rest_framework.permissions.IsAuthenticatedOrReadOnly",
    ),
    "DEFAULT_PAGINATION_CLASS": "rest_framework.pagination.PageNumberPagination",
    "PAGE_SIZE": 20,
}
SPECTACULAR_SETTINGS = {
    "TITLE": "LegalNepal API",
    "DESCRIPTION": "REST API for the LegalNepal application.",
    "VERSION": "0.1.0",
    "SERVE_INCLUDE_SCHEMA": False,
}
# Keep browser origins explicit. Native Flutter clients do not use browser CORS.
CORS_ALLOWED_ORIGINS = config("CORS_ALLOWED_ORIGINS", default="", cast=Csv())
CORS_ALLOW_ALL_ORIGINS = DEBUG
SECURE_SSL_REDIRECT = config("DJANGO_SECURE_SSL_REDIRECT", default=not DEBUG, cast=bool)
SESSION_COOKIE_SECURE = not DEBUG
CSRF_COOKIE_SECURE = not DEBUG
SECURE_HSTS_SECONDS = 31_536_000 if not DEBUG else 0
SECURE_HSTS_INCLUDE_SUBDOMAINS = not DEBUG
SECURE_HSTS_PRELOAD = not DEBUG
SECURE_CONTENT_TYPE_NOSNIFF = True
X_FRAME_OPTIONS = "DENY"
SIMPLE_JWT = {
    "ACCESS_TOKEN_LIFETIME": timedelta(minutes=15),
    "REFRESH_TOKEN_LIFETIME": timedelta(days=7),
}
