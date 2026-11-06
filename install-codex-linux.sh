#!/usr/bin/env bash
# Codex 전역 지침 설치 — config/AGENTS.md 를 ~/.codex/AGENTS.md 로.
# 기본 복사 모드. --link = 개발 머신(수정 즉시 반영). config.toml 등 개인 설정은 건드리지 않는다.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"
SRC="$REPO_DIR/config/AGENTS.md"
DST="$CODEX_HOME/AGENTS.md"
MODE="copy"
[ "${1:-}" = "--link" ] && MODE="link"

mkdir -p "$CODEX_HOME"

# 기존 실제 파일이면 1회 백업
if [ -e "$DST" ] && [ ! -L "$DST" ]; then
  cp "$DST" "$DST.pre-codex-config.$(date +%Y%m%d%H%M%S)"
  echo "backup: $DST.pre-codex-config.*"
fi
[ -L "$DST" ] && rm "$DST"

if [ "$MODE" = "link" ]; then
  ln -sfn "$SRC" "$DST"
  echo "link:   $DST -> $SRC"
  echo "완료 (링크 모드). 저장소 수정이 다음 Codex 실행부터 반영됩니다."
else
  [ -e "$DST" ] && rm -f "$DST"
  cp "$SRC" "$DST"
  echo "copy:   $DST"
  echo "완료 (복사 모드). 저장소가 바뀌면 다시 실행하세요."
fi

echo "주의: ~/.codex/config.toml (모델·승인·프로젝트 trust 등 개인 설정) 은 건드리지 않습니다."
