# AGENTS.md

Configured fork of Ashish Yadav's dwmblocks (suckless-style statusbar). No tests exist; verification = clean build.

## Build / install

- `./rebuild.sh` is the main workflow: deletes `config.h` and `blocks/`, runs `make clean && make`, then `sudo make install` (installs to `/usr/local/bin`). Requires sudo and `pkg-config x11`.
- Plain `make` builds all three binaries; `make dwmblocks` builds just the daemon.
- `config.h` is **generated** from `config.def.h` by the GNUmakefile's sed rule (injects the absolute `blocks/` path into the `PATH()` macro). `blocks/` is a one-time copy of `blocks.def/` made by that same rule.
- `config.h` and `blocks/` are gitignored and wiped by `rebuild.sh` — **never edit them directly**. Edit `config.def.h` and the scripts under `blocks.def/`, then run `./rebuild.sh`.

## Layout

- `dwmblocks` / `dwmblocks.c` — the statusbar daemon. Includes `config.h`.
- `sigdwmblocks` / `xgetrootname` — small C utils in their own subdirs with their own make targets.
- `blocks.def/` — shell scripts (source of truth); paired `*_button.sh` are click handlers.
- `patches/` — dwm patches required for colored/clickable status (statuscmd/statuscolors/systray); not needed to build this repo.
- `daemons/pulse_daemon.sh` — autostart with X session; subscribes to pactl and signals a block on audio events.

## Config semantics (config.def.h `blocks[]`)

- Each block: `pathu` (update script), `pathc` (click script or `NULL`), `interval` (seconds), `signal`.
- `interval == 0` → updated once at startup only; negative → never auto-updated; otherwise every `interval` seconds.
- `signal` maps to realtime signal `SIGRTMIN + signal`, sent via `sigdwmblocks <signal> [<sigval>]`. `sigval` is passed as `argv[1]` to the update script.
- Click handler receives button number as `argv[1]` (1/2/3 = left/middle/right). Clickable blocks need `signal < DELIMITERENDCHAR` (10); max 9 clickable blocks.
- Block output is truncated to `CMDOUTLENGTH` (50) bytes and must be a single line (trailing newline allowed).
- Raw bytes `\x0b`–`\x1f` in a block's output switch the active colorscheme in dwm (statuscolors patch); `\x0b` = first scheme.

## Gotchas

- Blocks' scripts run with `execv`, so they need a shebang and exec bit; they run unconditionally (even when output-width-changing), and the child uses inherited env (e.g. `$TERMINAL`, `DISPLAY`).
- `daemons/pulse_daemon.sh` currently signals block `1`, but `volume.sh` is registered with signal `2` in `config.def.h` — likely stale; the wires between daemon/button scripts and the signals array are easy to break.
- Some scripts are machine-specific: `ram.sh` greps German locale output (`Speicher`), `battery.sh` hardcodes `BAT0`, `cpu_temp.sh` reads `thermal_zone0`.