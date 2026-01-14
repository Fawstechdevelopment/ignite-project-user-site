# User Guide

## Login and Signup
- Enter a valid email and password (min 6 chars).
- Use “Forgot password” to request OTP; then set a new password.
- Google login is available if your Firebase token is valid.

## Projects
- Home page shows live projects and gallery.
- Click any project card to view details: title, category, price, media, timeline, and related ideas.

## Timeline
- Each project shows a Course Timeline from `default_stages`.
- Use the plus button to expand a stage; “Expand All Stages” toggles all.

## Cart
- Click “Add to cart” on a project to add it.
- Cart shows items, quantities, prices, and total.
- Requires login.

## API Keys and Auth
- The app sends `Authorization: Bearer <token>` when logged in.
- API key is injected via headers (`x-api-key`, `X-Api-Key`, `Api-Key`) and query `api_key`.

## Troubleshooting
- If images do not load, check for stray backticks in URLs.
- If cart shows unauthorized, log in and retry.
