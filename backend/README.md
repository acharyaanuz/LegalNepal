# LegalNepal backend

LegalNepal REST API built with Django REST Framework. SQLite is used by
default; set `DATABASE_URL` to a PostgreSQL URL to opt into PostgreSQL.

## Local setup (PowerShell)

Use the existing workspace virtual environment from the `backend` directory:

```powershell
..\.venv\Scripts\Activate.ps1
python -m pip install -r requirements.txt
Copy-Item .env.example .env
python manage.py migrate
python manage.py runserver 0.0.0.0:8000
```

The custom account model is configured from the first migration. The migrations
add the starter legal categories. Create an administrator with
`python manage.py createsuperuser` to publish reviewed legal articles and verify
lawyer profiles in Django admin at `/admin/`.

Edit `.env` before sharing or deploying. `0.0.0.0` binds the development
server to network interfaces; use it only on a trusted development network.
Production requires HTTPS, a strong secret, `DEBUG=False`, and explicit hosts.

API schema: `/api/schema/`; interactive Swagger UI: `/api/docs/`.

## API

- `POST /api/accounts/register/`, `GET/PATCH /api/accounts/me/`
- `POST /api/auth/token/`, `POST /api/auth/token/refresh/` (JWT)
- `GET/POST /api/lawyers/`, `GET/PATCH /api/lawyers/{id}/`,
  `GET/POST/PATCH /api/lawyers/me/`
- `GET /api/legal/categories/`, `GET /api/legal/articles/`,
  `GET /api/legal/articles/{slug}/`; staff manage categories and articles
- `GET/POST /api/consultations/`, `GET/PATCH /api/consultations/{id}/`
- `GET/POST /api/favourites/lawyers/`, `DELETE /api/favourites/lawyers/{id}/`
- `GET/POST /api/favourites/articles/`, `DELETE /api/favourites/articles/{id}/`

Send authenticated requests with `Authorization: Bearer <access-token>`. Lawyer
search accepts optional `city` and `specialization` query parameters. Article
search accepts an optional category slug in `category`.

## Database

No database URL is needed for SQLite. PostgreSQL is selected when
`DATABASE_URL` begins with `postgres://` or `postgresql://`.

## Flutter connectivity

`localhost` and `127.0.0.1` refer to the device running the app. Android
emulator networking typically reaches the host computer at `10.0.2.2`; a
physical Android phone must use the backend computer's private IPv4 address
(for example `http://192.168.1.20:8000`). On Windows desktop, use
`http://127.0.0.1:8000`. `0.0.0.0` is a server bind address, not a client URL.
Both devices must share Wi-Fi and the host firewall must allow port 8000.
Add the backend computer's private IPv4 address to `DJANGO_ALLOWED_HOSTS` in
`.env` when connecting from another device.
Android may need development-only cleartext HTTP configuration; production
must use HTTPS.

The Flutter app stores its JWT locally and uses it for authenticated API calls.
By default it targets `http://10.0.2.2:8000/api` on Android emulators,
`http://127.0.0.1:8000/api` on Windows and web, and
`http://127.0.0.1:8000/api` on iOS simulators. Override the API root at build
time with `--dart-define=API_BASE_URL=http://192.168.1.20:8000/api` when using
a physical phone; replace the address with the backend computer's private IP.

Use `DEBUG=True` only for local development. For deployment set a private,
random `DJANGO_SECRET_KEY`, `DJANGO_DEBUG=False`, and the exact production
domains in `DJANGO_ALLOWED_HOSTS`; configure HTTPS and a production database.
Production settings enable HTTPS redirects, secure cookies, and HSTS. Legal
articles are intentionally not seeded; an administrator should review their
accuracy and sources before publishing them.

Start Django with `python manage.py runserver 0.0.0.0:8000`, then launch Flutter
from the workspace root. For an Android emulator, run
`flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8000/api`. The Android
development manifest allows cleartext HTTP for local testing; use HTTPS for a
production backend.
