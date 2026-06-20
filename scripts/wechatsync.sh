#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENV_FILE="$ROOT_DIR/.env.wechatsync"

if [[ -f "$ENV_FILE" ]]; then
  set -a
  # shellcheck disable=SC1090
  source "$ENV_FILE"
  set +a
fi

CLI="$ROOT_DIR/node_modules/.bin/wechatsync"

if [[ ! -x "$CLI" ]]; then
  echo "Wechatsync CLI 尚未安装，请先在 $ROOT_DIR 运行 npm install。" >&2
  exit 1
fi

if [[ "${1:-}" == "--check" ]]; then
  exec "$CLI" platforms --auth
fi

if [[ $# -lt 1 ]]; then
  echo "用法: npm run sync -- <文章.md> [Wechatsync 参数]" >&2
  echo "示例: npm run sync -- content/posts/PaperInsight.md" >&2
  exit 2
fi

article="$1"
shift

if [[ ! -f "$article" ]]; then
  echo "找不到文章: $article" >&2
  exit 2
fi

has_platforms=false
for arg in "$@"; do
  if [[ "$arg" == "-p" || "$arg" == "--platforms" || "$arg" == --platforms=* ]]; then
    has_platforms=true
    break
  fi
done

if [[ "$has_platforms" == false ]]; then
  if [[ -z "${WECHATSYNC_PLATFORMS:-}" ]]; then
    echo "请在 .env.wechatsync 中设置 WECHATSYNC_PLATFORMS，或传入 --platforms。" >&2
    exit 2
  fi
  set -- --platforms "$WECHATSYNC_PLATFORMS" "$@"
fi

exec "$CLI" sync "$article" "$@"
