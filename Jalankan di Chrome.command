#!/bin/sh

PROJECT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

if command -v flutter >/dev/null 2>&1; then
  FLUTTER="$(command -v flutter)"
elif [ -x "$HOME/flutter/bin/flutter" ]; then
  FLUTTER="$HOME/flutter/bin/flutter"
elif [ -x "/Users/user/flutter/bin/flutter" ]; then
  FLUTTER="/Users/user/flutter/bin/flutter"
else
  printf '%s\n' "Flutter tidak ditemukan. Pasang Flutter atau tambahkan ke PATH."
  read -r _
  exit 1
fi

cd "$PROJECT_DIR" || exit 1
exec "$FLUTTER" run -d chrome
