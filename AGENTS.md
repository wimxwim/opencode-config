# AGENTS.md - Global Memory HERMES

> Global instructions untuk semua agent di opencode (build/sidekick/explore/research/design/reviewer).

## Identitas
- Owner: Muhammad Wafi (Wafi) - Founder Gotong Royong, Agency Owner
- Stack: Flutter, Next.js, Supabase, PostgreSQL, Node.js, Go
- Filosofi: Gotong Royong - trust, transparency, community-first

## Aturan Umum
- Dokumentasi-first: update docs saat build fitur
- Verifikasi cross-vendor untuk bug kritis
- Jangan hardcode secret di repo - gunakan env
- Jangan push secret ke github

## Telegram HERMES - Aturan WAJIB

> HERMES = memory global agar semua agent paham instruksi telegram.

- Jika user bilang "kirim ke telegram" / "kirim ke telegram saja" / "kirim telegram" -> WAJIB kirim ke Telegram chat <TELEGRAM_CHAT_ID> via bot, gunakan custom tool `send_telegram` dengan env `TELEGRAM_BOT_TOKEN` dan `TELEGRAM_CHAT_ID` (fallback baca file `.env.telegram` jika env kosong).
- JANGAN push ke github untuk pengiriman telegram - hanya via Bot API.
- JANGAN hardcode token di code, docs, atau skill - hanya di `.env.telegram` (chmod 600) + `process.env`.
- Tool `send_telegram` otomatis pilih `sendDocument` untuk PDF dan `sendMessage` untuk teks, dengan guard 50MB dan handling error 401/400.
- Jika tool gagal (401/400/network), laporkan error ke user dan jangan retry dengan token hardcode.

## References
- Env telegram: `~/.config/opencode/.env.telegram` (600, NOT committed)
- Tool: `~/.config/opencode/tools/send_telegram.ts`
- Skill: `~/.config/opencode/skills/telegram-send/SKILL.md`
- Playbook: `~/agensi/playbook/AGENSI_MASTER.md`

## Catatan Keamanan
- File `.env.telegram` tidak boleh di-commit (sudah di .gitignore via `*.env*`).
- Semua agent (build/sidekick/explore/research/design/reviewer) wajib patuh HERMES.
- Jika ragu, tanya user sebelum kirim, jangan asumsi channel lain.
- Log pengiriman cukup "OK: terkirim ke chat <TELEGRAM_CHAT_ID>" tanpa expose token.
- Untuk file >50MB, tolak dan sarankan compress/split sebelum kirim.
- Abaikan PDF/github untuk telegram - hanya Bot API yang dipakai.
- Env telegram wajib chmod 600 dan masuk .gitignore `*.env*`.
- Tool `send_telegram` wajib baca env dulu, fallback file `.env.telegram` jika env kosong.
