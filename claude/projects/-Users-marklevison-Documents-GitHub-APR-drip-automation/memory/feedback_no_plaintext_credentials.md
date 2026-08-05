---
name: No plaintext credentials
description: User refuses to store username/password in .env files. Use refresh tokens, API keys, or OS keychain instead.
type: feedback
originSessionId: c9bce4a3-0cfc-4cd8-a05e-0c6c052367c4
---
Do not suggest storing username/password in plaintext `.env` files, even for local-only tools.

**Why:** User considers this unacceptable security practice regardless of .gitignore protection. They use 1Password for credential management.

**How to apply:** For API auth, prefer refresh tokens or API keys in `.env`. When tokens expire, provide a CLI command (like `npm run refresh-cakemail`) that prompts interactively for credentials and outputs the token for manual `.env` update. Auto-update `.env` with rotated tokens when possible.
