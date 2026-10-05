# Changelog

All notable changes to this config snapshot.

## 2026-10-04

- Initial public snapshot of the opencode setup (opencode v1.18.34).
- Added 8 agents: build, sidekick, explore, research, design, reviewer, plan, vision.
- Added sanitized `opencode.jsonc`: NaraRouter provider, 8 agent model routes,
  MCP servers (duckduckgo, exa, playwright, context7; supabase/github disabled),
  permission and watcher rules.
- Sanitization applied: `~` home-path rewrite, API keys as `{env:...}`,
  Telegram chat ID redacted to `<TELEGRAM_CHAT_ID>`.
- Added secret-scan CI workflow, install script, MIT license, .gitignore.
