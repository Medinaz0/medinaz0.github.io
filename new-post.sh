#!/bin/bash
# new-post.sh - Create a new write-up post for Jekyll
# Usage:
#   ./new-post.sh -p htb "MachineName"
#   ./new-post.sh -p vulnhub "Brainpan"
#   ./new-post.sh -p homelab "My AD Lab"
#   ./new-post.sh -l
#   ./new-post.sh -h

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG="$SCRIPT_DIR/platforms.conf"
TEMPLATES_DIR="$SCRIPT_DIR/templates"

usage() {
    cat <<EOF
Usage: $(basename "$0") -p PLATFORM [-d DATE] MACHINE_NAME
       $(basename "$0") -l
       $(basename "$0") -h

Create a new write-up post for Jekyll (HTB, VulnHub, Home Lab, etc.).

Options:
  -p PLATFORM   Platform slug (required). Use -l to list available.
  -d DATE       Custom date in YYYY-MM-DD format (default: today)
  -l            List available platforms and exit
  -h            Show this help and exit

Examples:
  $(basename "$0") -p htb "Olympus"
  $(basename "$0") -p vulnhub "Brainpan"
  $(basename "$0") -p homelab "My AD Lab"
EOF
    exit 0
}

# ── Parse flags ───────────────────────────────────────────────
PLATFORM=""
CUSTOM_DATE=""
LIST_MODE=false

while getopts ":p:d:lh" opt; do
    case $opt in
        p) PLATFORM="$OPTARG" ;;
        d) CUSTOM_DATE="$OPTARG" ;;
        l) LIST_MODE=true ;;
        h) usage ;;
        \*) echo "Error: Invalid option -$OPTARG" >&2; usage ;;
        :) echo "Error: Option -$OPTARG requires an argument" >&2; exit 1 ;;
    esac
done
shift $((OPTIND - 1))

# ── Load config ───────────────────────────────────────────────
if [ ! -f "$CONFIG" ]; then
    echo "Error: Config file not found: $CONFIG" >&2
    echo "Run 'git pull' or re-clone the repository." >&2
    exit 1
fi
# shellcheck source=platforms.conf
source "$CONFIG"

# ── List mode ─────────────────────────────────────────────────
if [ "$LIST_MODE" = true ]; then
    echo "Available platforms:"
    for p in $PLATFORMS; do
        pu=$(echo "$p" | tr '[:lower:]' '[:upper:]')
        name_var="PLATFORM_${pu}_NAME"
        echo "  - $p    (${!name_var})"
    done
    exit 0
fi

# ── Validate platform ─────────────────────────────────────────
if [ -z "$PLATFORM" ]; then
    echo "Error: -p PLATFORM is required" >&2
    usage
fi

pu=$(echo "$PLATFORM" | tr '[:lower:]' '[:upper:]')
name_var="PLATFORM_${pu}_NAME"
if [ -z "${!name_var:-}" ]; then
    echo "Error: Unknown platform '$PLATFORM'" >&2
    echo "Use -l to list available platforms." >&2
    exit 1
fi

# Read platform fields from config
PLATFORM_NAME="${!name_var}"
icon_var="PLATFORM_${pu}_ICON";          PLATFORM_ICON="${!icon_var}"
cat_var="PLATFORM_${pu}_CATEGORY";       PLATFORM_CATEGORY="${!cat_var}"
tmpl_var="PLATFORM_${pu}_TEMPLATE";      TEMPLATE_FILE="${!tmpl_var}"
pref_var="PLATFORM_${pu}_IMAGE_PREFIX";  IMAGE_PREFIX="${!pref_var}"

# ── Machine name ──────────────────────────────────────────────
NAME="$*"
if [ -z "$NAME" ]; then
    echo "Error: Machine name is required" >&2
    usage
fi

# ── Compute paths and variables ───────────────────────────────
SLUG=$(echo "$NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
DATE="${CUSTOM_DATE:-$(date +%Y-%m-%d)}"
POST_FILE="_posts/${DATE}-${IMAGE_PREFIX}-${SLUG}.md"
IMG_DIR="assets/images/${IMAGE_PREFIX}-${SLUG}"
TEMPLATE="$TEMPLATES_DIR/$TEMPLATE_FILE"

# ── Validate template ─────────────────────────────────────────
if [ ! -f "$TEMPLATE" ]; then
    echo "Error: Template not found: $TEMPLATE" >&2
    echo "Make sure the templates/ directory exists and has the required files." >&2
    exit 1
fi

# ── Check for envsubst ────────────────────────────────────────
if ! command -v envsubst &>/dev/null; then
    echo "Error: envsubst not found." >&2
    echo "Install gettext:" >&2
    echo "  Debian/Ubuntu: sudo apt install gettext" >&2
    echo "  Arch Linux:    sudo pacman -S gettext" >&2
    echo "  macOS:         brew install gettext" >&2
    exit 1
fi

# ── Create image directory ────────────────────────────────────
mkdir -p "$IMG_DIR"

# ── Render template ───────────────────────────────────────────
export NAME SLUG DATE PLATFORM_NAME PLATFORM_ICON PLATFORM_CATEGORY IMAGE_PREFIX
envsubst '${NAME} ${SLUG} ${DATE} ${PLATFORM_NAME} ${PLATFORM_ICON} ${PLATFORM_CATEGORY} ${IMAGE_PREFIX}' \
    < "$TEMPLATE" > "$POST_FILE"

# ── Done ──────────────────────────────────────────────────────
echo "✅ Created: $POST_FILE"
echo "✅ Created: $IMG_DIR/"

