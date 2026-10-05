# MCP Re-enable - Supabase + GitHub

Status awal: `supabase.enabled=false`, `github.enabled=false` (opencode.jsonc:881-899).
Aturan: token hanya via env. Jangan commit token. Serial: satu langkah, verifikasi, lanjut.

## 1. Supabase MCP (local)

```sh
# 1. set token (ganti xxx, jangan paste ke chat/log)
export SUPABASE_ACCESS_TOKEN=sbp_xxx
printenv SUPABASE_ACCESS_TOKEN | cut -c1-6
# 2. test server jalan (harus keluar help/version, bukan 401)
npx -y @supabase/mcp-server-supabase --help | head -20
# 3. flip enabled di opencode.jsonc blok mcp.supabase: false -> true
# 4. reload + verifikasi
opencode mcp list
```

Expected: `supabase` muncul CONNECTED/enabled. Jika 401: token salah/expired, ulangi langkah 1.

## 2. GitHub MCP (remote)

```sh
# 1. buat PAT: github.com > Settings > Developer settings > PAT (classic), scope read-only repo
export GITHUB_TOKEN=ghp_xxx
export GITHUB_PERSONAL_ACCESS_TOKEN=$GITHUB_TOKEN
# 2. test PAT valid (harus 200 + login name)
curl -s -H "Authorization: Bearer $GITHUB_TOKEN" https://api.github.com/user | head -5
# 3. flip enabled di opencode.jsonc blok mcp.github: false -> true
# 4. reload + verifikasi
opencode mcp list
```

Expected: `github` CONNECTED. Jika 401/403: PAT salah, expired, atau scope kurang.

## 3. Verifikasi gabungan

```sh
opencode --version
opencode mcp list
```

Lolos jika: 4 MCP aktif (duckduckgo, exa, playwright, context7) + supabase + github = 6 baris OK.

## 4. Rollback (aman, tanpa sentuh DB)

```sh
# kembalikan false di opencode.jsonc untuk mcp.supabase dan/atau mcp.github, lalu:
opencode mcp list
unset SUPABASE_ACCESS_TOKEN GITHUB_TOKEN GITHUB_PERSONAL_ACCESS_TOKEN
```

Catatan: rollback = flip `enabled: true` -> `false` lagi. Tidak perlu hapus token di dashboard kecuali bocor.
