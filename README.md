# Milez Ahead — customer-facing web pages

Static, dependency-free HTML/JS pages for the **Milez Ahead** VIP transport service
(operating entity: Project Help). Hosted at **book.milezahead.co.za** via Cloudflare
Pages — every push to `main` deploys automatically. No build step.

These pages are the customer + driver touchpoints that hang off the dispatch console
and Supabase edge functions in the **`project-help-drive`** repo (that repo is the
system of record — start there for the full picture).

## Pages

| File | Purpose | Reached by |
|---|---|---|
| `book.html` | Book a trip (signed link) — lands as a trip in the console | WhatsApp booking link (`?s=<signed token>`) |
| `track.html` | Live trip tracking + post-trip receipt, rating & tip | Link sent to the client per trip (`?token=…`) |
| `driver.html` | "Meet your driver" profile card | Link from `track.html` |
| `extras.html` | Add on-the-day extras (luggage, larger vehicle, extra km) | Link sent during a trip |
| `gift.html` | Gift a trip to a friend | Shared by members |
| `profile.html` | Member self-service profile | WhatsApp "My profile" |
| `index.html` | Landing / marketing entry | Direct |

All page access is via **signed/HMAC tokens** minted by the edge functions
(`book-web`, `track`, etc.) — there is no login here and no secret in the client.
The one embedded key is a **Google Maps browser key**, which is referrer-locked to
this domain.

## Local preview

```bash
python3 -m http.server 8000    # then open http://localhost:8000/index.html
```

Map-dependent pages (`track.html`) will show a `RefererNotAllowedMapError` on
localhost — that's expected; the Maps key only authorizes the live domain.

## Deploy

Push to `main`. Cloudflare Pages builds and publishes to `book.milezahead.co.za`
(CNAME in `CNAME`). No CI, no secrets in the repo.
