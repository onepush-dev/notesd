# notesd on Railway

notesd — self-hosted Markdown notes with offline Android/iOS/Mac apps, sync, full-text search, locked notes and passkeys. Deploy on Railway with one click.

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy/tEjfwX)

This repository packages the official [notesd](https://github.com/cassiozen/notesd) image (`ghcr.io/cassiozen/notesd:1.5.1`, MIT) for Railway. It is an independent community packaging, not affiliated with or endorsed by the notesd project.

## What you get

- One service from `ghcr.io/onepush-dev/notesd:1.5.1`: the upstream binary unmodified; the wrapper only runs it as root so it can write to Railway's root-owned volume, and bakes in `NOTESD_OWNER_USERNAME=admin`.
- **No first-visitor race**: the template generates `NOTESD_OWNER_PASSWORD`, so notesd creates the owner account `admin` on its very first start, before anyone can reach the sign-up screen. `POST /api/v1/auth/setup` answers `409 already_set_up`.
- **Persistent data** on a Railway volume at `/data` (SQLite databases per account, images, search index).
- Health checks: `/healthz` (process) and `/readyz` (database), both public and data-free.

## Use it

1. Deploy, then open the service's public URL.
2. Sign in as `admin` with the `NOTESD_OWNER_PASSWORD` value from the service's Variables tab. Change it in Settings if you like (changing the variable later does nothing once the owner exists).
3. Point the notesd Android, iOS or Mac app at the same HTTPS URL to sync offline. Add family or friends from **Settings → Server → People**.

## Variables

| Variable | Default | Purpose |
|---|---|---|
| `NOTESD_OWNER_PASSWORD` | generated (24 chars) | Password for the owner account `admin`, created on first start |
| `NOTESD_OWNER_USERNAME` | `admin` (baked into image) | Username of the owner account; override before the first deploy only |
| `NOTESD_LOG_FORMAT` | `text` | Optional: `json` for structured logs |
| `NOTESD_RESEND_URL` / email settings | – | Optional: set up emailing notes from the app's admin settings |

## Notes

- Back up the `/data` volume (Railway volume backups) — it holds every note.
- Upgrades: bump the image tag; notesd migrates its schema on start.
- notesd's own self-update (`NOTESD_SELF_UPDATE`) does not apply in containers.
