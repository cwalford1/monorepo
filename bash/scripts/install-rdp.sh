#!/usr/bin/env bash
# Install a minimal Ubuntu/Debian RDP desktop for the user running this script.
set -euo pipefail

if (( EUID == 0 )); then
    printf 'Run this script as your regular login user; it uses sudo when needed.\n' >&2
    exit 1
fi

if ! command -v apt-get >/dev/null; then
    printf 'This installer requires Ubuntu or Debian with apt-get.\n' >&2
    exit 1
fi

sudo apt-get update
sudo apt-get install -y --no-install-recommends \
    xrdp xorgxrdp xserver-xorg-core \
    openbox xterm x11-common dbus-x11

# Allow xrdp to read the distribution's TLS private key.
sudo adduser xrdp ssl-cert

# xrdp's default startwm.sh runs /etc/X11/Xsession, which reads ~/.xsession.
# Preserve any previous session configuration before selecting Openbox.
session_file="${HOME}/.xsession"
session_command='exec openbox-session'
if [[ -e "$session_file" || -L "$session_file" ]]; then
    if ! cmp -s "$session_file" <(printf '%s\n' "$session_command"); then
        session_backup=$(mktemp "${session_file}.backup.XXXXXXXX")
        cp -p -- "$session_file" "$session_backup"
        printf 'Previous session configuration saved to %s\n' "$session_backup"
    fi
fi
printf '%s\n' "$session_command" > "$session_file"
chmod u+x "$session_file"

sudo systemctl enable --now xrdp
sudo systemctl restart xrdp

cat <<'EOF'

Installation complete.
Connect using Windows Remote Desktop to this server's hostname or IP (TCP 3389).
Choose Xorg and log in with your Linux username and password.
If a firewall blocks the connection, allow TCP 3389 from your Windows machine.

No per-session setup commands are required: xrdp starts Xorg and Openbox.
Right-click the desktop to open a terminal, then run:
    cd ~/swdev/monorepo
    bazel run //projects/draw

Launch graphical applications from the RDP terminal so they inherit DISPLAY.
EOF
