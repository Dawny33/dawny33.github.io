#!/usr/bin/env bash
# notes2blog launcher — creates a venv on first run, then serves the app.
set -euo pipefail
cd "$(dirname "$0")"

PY="${PYTHON:-python3}"

if [ ! -d .venv ]; then
  echo "→ First run: creating virtualenv…"
  if command -v uv >/dev/null 2>&1; then
    uv venv .venv >/dev/null
    VENV_PY=.venv/bin/python
    echo "→ Installing dependencies (uv)…"
    uv pip install --python "$VENV_PY" -q -r requirements.txt
  else
    "$PY" -m venv .venv
    VENV_PY=.venv/bin/python
    echo "→ Installing dependencies (pip)…"
    "$VENV_PY" -m pip install -q --upgrade pip
    "$VENV_PY" -m pip install -q -r requirements.txt
  fi
fi

if [ ! -f .env ]; then
  cp .env.example .env
  echo
  echo "⚠  Created tools/notes2blog/.env — add your ANTHROPIC_API_KEY to it, then re-run."
  echo
  exit 1
fi

PORT="${PORT:-8765}"
export PORT
echo "→ notes2blog running at http://127.0.0.1:${PORT}"
exec .venv/bin/python -m uvicorn app:app --host 127.0.0.1 --port "$PORT" "$@"
