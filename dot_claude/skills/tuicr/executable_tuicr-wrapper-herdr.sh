#!/usr/bin/env bash
# Open tuicr in a Herdr pane.
#
#   tuicr-wrapper-herdr.sh [options] <repo-dir> [-- tuicr args...]
#
# Options:
#   --direction right|down   split direction (default: right)
#   --ratio <float>          split ratio (default: 0.5)
#   --no-focus               leave focus in the calling pane
#   --wait                   block until tuicr exits, then close the pane
#
# Prints the new pane id between "=== TUICR PANE ===" markers. Non-blocking
# unless --wait is given.
set -euo pipefail

die() { printf 'tuicr-wrapper-herdr: %s\n' "$*" >&2; exit 1; }

command -v herdr >/dev/null 2>&1 || die "herdr not found on PATH"
command -v tuicr >/dev/null 2>&1 || die "tuicr not found on PATH"
command -v jq    >/dev/null 2>&1 || die "jq is required to parse Herdr JSON"

direction=right
ratio=0.5
focus=--focus
wait_for_exit=0
repo=""
tuicr_args=()

while [ $# -gt 0 ]; do
  case "$1" in
    --direction) direction="${2:-}"; shift 2 ;;
    --ratio)     ratio="${2:-}";     shift 2 ;;
    --no-focus)  focus=--no-focus;   shift ;;
    --wait)      wait_for_exit=1;    shift ;;
    --)          shift; tuicr_args=("$@"); break ;;
    -h|--help)   sed -n '2,14p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    -*)          die "unknown option: $1" ;;
    *)
      [ -n "$repo" ] && die "unexpected argument: $1"
      repo="$1"; shift ;;
  esac
done

[ -n "$repo" ] || die "missing repo directory"
[ -d "$repo" ] || die "not a directory: $repo"
repo="$(cd "$repo" && pwd)"

# Marker is assembled at runtime so the echoed command line in the pane can
# never match it — only tuicr's actual exit prints the joined string.
nonce="$$-${RANDOM}"
marker="TUICR-DONE ${nonce}"

split_json="$(herdr pane split --current --direction "$direction" --ratio "$ratio" \
  --cwd "$repo" "$focus")" || die "herdr pane split failed"

pane_id="$(printf '%s' "$split_json" | jq -r '.result.pane.pane_id // empty')"
[ -n "$pane_id" ] || die "could not read pane id from: $split_json"

tuicr_cmd="tuicr"
if [ "${#tuicr_args[@]}" -gt 0 ]; then
  tuicr_cmd="tuicr $(printf '%q ' "${tuicr_args[@]}")"
fi

# shellcheck disable=SC2016
cmd="${tuicr_cmd}; __rc=\$?; printf 'TUICR%sDONE %s rc=%s\n' '-' '${nonce}' \"\$__rc\""

herdr pane run "$pane_id" "$cmd" >/dev/null || {
  herdr pane close "$pane_id" >/dev/null 2>&1 || true
  die "herdr pane run failed"
}

printf '=== TUICR PANE ===\n%s\n=== END TUICR PANE ===\n' "$pane_id"

if [ "$wait_for_exit" -eq 1 ]; then
  herdr pane wait-output --match "$marker" --source recent-unwrapped "$pane_id" >/dev/null \
    || die "wait-output failed for pane $pane_id"
  herdr pane close "$pane_id" >/dev/null 2>&1 || true
  printf 'tuicr exited; pane %s closed\n' "$pane_id"
fi
