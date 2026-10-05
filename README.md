# opencode-config

Public mirror of Muhammad Wafi's (wimxwim) opencode setup: 8 agents, global
AGENTS.md memory, and a provider config for the NaraRouter gateway. All
secrets removed; API keys are read from environment variables.

## Who

Muhammad Wafi ("Wafi") - Founder Gotong Royong, agency owner.
Stack: Flutter, Next.js, Supabase, PostgreSQL, Node.js, Go.
Philosophy: Gotong Royong - trust, transparency, community-first.

## What's inside

| Path | Purpose |
| --- | --- |
| `agents/` | 8 agent definitions (build, sidekick, explore, research, design, reviewer, plan, vision) |
| `AGENTS.md` | Global memory/instructions loaded by opencode for every agent |
| `opencode.jsonc` | Provider, model routing, MCP servers, permissions (sanitized) |
| `versions.json` | Pinned opencode version + snapshot date |
| `scripts/install.sh` | Copy config into `~/.config/opencode` |

### Agent roster

- **build** - primary orchestrator; plans, delegates, reviews. Cannot edit files.
- **sidekick** - execution workhorse; writes code, runs commands, ships changes.
- **explore** - fast read-only codebase explorer (grep/glob/read).
- **research** - external research: web search, docs, library comparison.
- **design** - UI/UX and design-system work.
- **reviewer** - code review: correctness, security, edge cases.
- **plan** - structured planning and task breakdown.
- **vision** - image/screenshot analysis for UI work.

## Install

```bash
git clone https://github.com/wimxwim/opencode-config.git
cd opencode-config
./scripts/install.sh
```

The installer backs up any existing config before copying. Then export your
API key (never commit it):

```bash
export NARAROUTER_API_KEY="your-key-here"
```

Optional: `SUPABASE_ACCESS_TOKEN` for the (disabled by default) Supabase MCP.

## Security notes

- `opencode.jsonc` uses `{env:...}` placeholders only - no secrets.
- Telegram chat IDs and personal paths are redacted (`~` / placeholders).
- `.gitignore` blocks `*.env*`, `*.db`, and `log/`.
- CI runs a secret-scan job on every push (see `.github/workflows/ci.yml`).

## Credits

- Built on [opencode](https://opencode.ai) (v1.18.34 snapshot).
- Model gateway: NaraRouter (router.bynara.id).
- MCP servers: DuckDuckGo, Exa, Playwright, Context7.
- Config and agents authored by Muhammad Wafi (wimxwim).

MIT License - see `LICENSE`.
