# SOP Monitoring - Future-proof opencode-config

Tujuan: cegah hang, bloat DB, dan kejutan versi. Semua perintah exact, jalan serial.

## 1. Cek rutin (mingguan, 5 menit)

```sh
opencode --version
opencode mcp list
df -h ~/.local/share/opencode | tail -2
du -sh ~/.local/share/opencode/* 2>/dev/null | sort -rh | head -10
```

Catat: versi opencode, MCP mana DOWN, disk >80% = waspada, folder mana paling besar.

## 2. Cek DB + WAL (jika pakai sqlite lokal opencode)

```sh
ls -lh ~/.local/share/opencode/*.db* 2>/dev/null
sqlite3 ~/.local/share/opencode/opencode.db "PRAGMA page_count; PRAGMA page_size; PRAGMA journal_mode;"
sqlite3 ~/.local/share/opencode/opencode.db "PRAGMA wal_checkpoint(TRUNCATE);"
```

WAL membesar (>100MB) = checkpoint lalu restart TUI. Jangan hapus file -wal/-shm manual saat TUI jalan.

## 3. SOP anti-hang: serial + headless

```sh
# JANGAN: paralel opencode + TUI interaktif saat load berat
# DO: satu perintah, tunggu selesai, baru lanjut
opencode run "task kecil A"
opencode run "task kecil B"
# headless untuk batch/CI (tanpa TUI)
opencode run --help | head -20
```

Tanda hang: spinner >5 menit tanpa output, CPU 100% satu core. Aksi: Ctrl-C sekali, tunggu 30 dtk, baru kill.

## 4. Fallback preset: value-king + hemat-ram

```sh
# value-king: model murah untuk tugas massal
opencode run --model <value-king-model> "bulk task"
# hemat-ram: matikan MCP berat yang tidak dipakai sesi ini
# edit opencode.jsonc: set enabled:false untuk playwright/exa bila tidak perlu, lalu:
opencode mcp list
```

Prinsip: TUI interaktif = model kuat + MCP minimal. Batch = model murah + headless.

## 5. Kapan VACUUM

```sh
sqlite3 ~/.local/share/opencode/opencode.db "VACUUM;"
ls -lh ~/.local/share/opencode/*.db* 2>/dev/null
```

VACUUM jika: DB >500MB, atau habis hapus massal history, atau checkpoint tidak mengecilkan WAL. TUI harus MATI saat VACUUM. Backup dulu: `cp opencode.db opencode.db.bak`.

## 6. Kapan restart TUI

- MCP status flapping (CONNECTED lalu DOWN bergantian).
- Habis flip enabled true/false di opencode.jsonc.
- Habis checkpoint WAL / VACUUM.
- Memory TUI naik terus (>2GB di htop).
- Cara: tutup TUI bersih (`/exit` atau Ctrl-C), `opencode mcp list`, buka TUI lagi.

## 7. Pantau issue #40865 + v2

```sh
# cek rilis terbaru (ganti repo jika salah)
curl -s https://api.github.com/repos/sst/opencode/releases/latest | grep -E '"tag_name"|"published_at"'
opencode --version
```

Jika versi lokal tertinggal >2 minor dari latest: baca release notes v2 sebelum upgrade. Jangan upgrade H-1 deadline. Catat versi stabil terakhir di versions.json.
