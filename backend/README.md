# LegalNepal backend

Initial Django REST Framework project setup. SQLite is used by default; set
`DATABASE_URL` to a PostgreSQL URL to opt into PostgreSQL.

## Local setup (PowerShell)

Use the existing workspace virtual environment from the `backend` directory:

```powershell
..\.venv\Scripts\Activate.ps1
python -m pip install -r requirements.txt
Copy-Item .env.example .env
python manage.py runserver 0.0.0.0:8000
```

Run `python manage.py migrate` after Phase 2 creates the custom user model and
its initial migration. Django must use that model from the first database
migration.

Edit `.env` before sharing or deploying. `0.0.0.0` binds the development
server to network interfaces; use it only on a trusted development network.
Production requires HTTPS, a strong secret, `DEBUG=False`, and explicit hosts.

API schema: `/api/schema/`; interactive Swagger UI: `/api/docs/`.

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

The inspected Flutter project is the separate `login_app` project. Its current
screens provide local username/password registration and login plus a home
profile view, backed by `SharedPreferences`; it has no LegalNepal lawyer,
article, consultation, or favourites screens yet. Frontend edits are deferred
to the integration phase.
