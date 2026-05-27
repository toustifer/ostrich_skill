#!/usr/bin/env bash
set -euo pipefail

ROOT=""
DATE=""
SECTION="今日记录"
TEXT=""

usage() {
    echo "Usage: $0 --root <diary-root> --date <YYYY-MM-DD> [--section <name>] [--text <content>]"
    exit 1
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        --root) ROOT="$2"; shift 2 ;;
        --date) DATE="$2"; shift 2 ;;
        --section) SECTION="$2"; shift 2 ;;
        --text) TEXT="$2"; shift 2 ;;
        *) usage ;;
    esac
done

[[ -z "$ROOT" || -z "$DATE" ]] && usage

YEAR="${DATE:0:4}"
MONTH="${DATE:5:2}"
DIR="$ROOT/$YEAR/$MONTH"
FILE="$DIR/$DATE.md"

mkdir -p "$DIR"

# Resolve weekday in Chinese
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
TEMPLATE="$SKILL_DIR/assets/diary-template.md"

if [[ ! -f "$FILE" ]]; then
    weekday_num=$(date -d "$DATE" +%u 2>/dev/null || date -j -f "%Y-%m-%d" "$DATE" +%u 2>/dev/null)
    case "$weekday_num" in
        1) weekday="周一" ;;
        2) weekday="周二" ;;
        3) weekday="周三" ;;
        4) weekday="周四" ;;
        5) weekday="周五" ;;
        6) weekday="周六" ;;
        7) weekday="周日" ;;
        *) weekday="周?" ;;
    esac

    sed -e "s/{{DATE}}/$DATE/g" -e "s/{{WEEKDAY}}/$weekday/g" "$TEMPLATE" > "$FILE"
fi

if [[ -n "${TEXT// }" ]]; then
    HEADER="## $SECTION"

    if ! grep -qF "$HEADER" "$FILE"; then
        printf '\n%s\n\n' "$HEADER" >> "$FILE"
    fi

    # Append bullet under the section header, then join subsequent lines
    INSERT=$(echo "$TEXT" | sed '1s/^/- /' | sed '2,$s/^/  /')
    awk -v header="$HEADER" -v insert="$INSERT" '
        BEGIN { found = 0 }
        { print }
        $0 == header { found = 1; next }
        found == 1 && $0 == "" {
            print ""
            print insert
            found = 0
        }
    ' "$FILE" > "${FILE}.tmp" && mv "${FILE}.tmp" "$FILE"
fi

echo "$FILE"
