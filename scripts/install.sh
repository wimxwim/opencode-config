#!/usr/bin/env bash
# install.sh - install Wafi's opencode config into ~/.config/opencode
# Safe: backs up existing files before copying. Never touches .env files.
set -euo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEST_DIR="${HOME}/.config/opencode"
STAMP="$(date +%Y%m%d-%H%M%S)"

echo "opencode-config installer"
echo "  source: ${SRC_DIR}"
echo "  dest:   ${DEST_DIR}"

if [ ! -f "${SRC_DIR}/opencode.jsonc" ]; then
  echo "ERROR: run this from a full checkout of wimxwim/opencode-config" >&2
  exit 1
fi

mkdir -p "${DEST_DIR}/agent"

# Backup existing files (if any), then copy.
for f in AGENTS.md opencode.jsonc; do
  if [ -f "${DEST_DIR}/${f}" ]; then
    cp "${DEST_DIR}/${f}" "${DEST_DIR}/${f}.bak.${STAMP}"
    echo "  backed up: ${f} -> ${f}.bak.${STAMP}"
  fi
  cp "${SRC_DIR}/${f}" "${DEST_DIR}/${f}"
  echo "  installed: ${f}"
done

for f in "${SRC_DIR}"/agents/*.md; do
  name="$(basename "${f}")"
  if [ -f "${DEST_DIR}/agent/${name}" ]; then
    cp "${DEST_DIR}/agent/${name}" "${DEST_DIR}/agent/${name}.bak.${STAMP}"
  fi
  cp "${f}" "${DEST_DIR}/agent/${name}"
  echo "  installed: agent/${name}"
done

cat <<'EOF'

Done. Next steps:
  1. export NARAROUTER_API_KEY="your-key-here"
     (optional) export SUPABASE_ACCESS_TOKEN="..."
  2. Restart opencode.

Secrets live ONLY in your environment or a local .env file (chmod 600).
Never commit them.
EOF
