#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HG_SOURCE_URL="${HG_SOURCE_URL:-http://hg.code.sf.net/p/unluac/hgcode}"
GIT_MIRROR_URL="${GIT_MIRROR_URL:-git+ssh://git@github.com/notpeter/unluac.git}"
GIT_BRANCH="${GIT_BRANCH:-main}"
REPO_DIR="${1:-${REPO_DIR:-$SCRIPT_DIR/unluac-hgcode}}"

UV_HG=(uv run --python 3.13 --with 'mercurial<7' --with hg-git hg --config extensions.hggit=)

if [[ ! -d "$REPO_DIR/.hg" ]]; then
  rm -rf "$REPO_DIR"
  "${UV_HG[@]}" clone "$HG_SOURCE_URL" "$REPO_DIR"
fi

"${UV_HG[@]}" -R "$REPO_DIR" pull -u
"${UV_HG[@]}" -R "$REPO_DIR" bookmark -f -r "max(branch(default))" "$GIT_BRANCH"

set +e
"${UV_HG[@]}" -R "$REPO_DIR" push "$GIT_MIRROR_URL" --new-branch
push_rc=$?
set -e

if [[ $push_rc -gt 1 ]]; then
  echo "error: hg push failed with exit code $push_rc" >&2
  exit "$push_rc"
fi
