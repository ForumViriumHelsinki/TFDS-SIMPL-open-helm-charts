#!/bin/zsh
set -e

SCRIPT_DIR=$(cd "$(dirname "$0")" &> /dev/null && pwd)
MONOREPO_DIR=$(dirname "$SCRIPT_DIR")
INDEX_FILE="$MONOREPO_DIR/INCLUDED_MICROSERVICES.md"

if [ ! -f "$INDEX_FILE" ]; then
    echo "Error: $INDEX_FILE not found."
    exit 1
fi

echo "============================================================"
echo " TFDS Microservice Updater"
echo " Reading targets from INCLUDED_MICROSERVICES.md..."
echo "============================================================"

# Using a simpler awk approach: split by '|', then trim whitespace and backticks
grep '^| `.*` | `.*` |' "$INDEX_FILE" | while read -r line; do
    CHART_NAME=$(echo "$line" | awk -F'|' '{print $2}' | tr -d ' `')
    TAG=$(echo "$line" | awk -F'|' '{print $3}' | tr -d ' `')
    REPO_URL=$(echo "$line" | awk -F'|' '{print $5}' | tr -d ' `')

    echo "------------------------------------------------"
    echo "Processing: $CHART_NAME"
    echo "Version:    $TAG"
    echo "Source:     $REPO_URL"
    
    DEST_DIR="$MONOREPO_DIR/charts/$CHART_NAME"
    REPO_DIR="/tmp/${CHART_NAME}_repo_update"

    rm -rf "$REPO_DIR"
    git clone "$REPO_URL" "$REPO_DIR" >/dev/null 2>&1 || { echo "ERROR: Failed to clone $CHART_NAME"; continue; }
    
    git -C "$REPO_DIR" fetch --tags >/dev/null 2>&1

    if git -C "$REPO_DIR" checkout "$TAG" >/dev/null 2>&1; then
        echo "Checked out exact tag: $TAG"
    elif git -C "$REPO_DIR" checkout "v$TAG" >/dev/null 2>&1; then
        echo "Checked out prefixed tag: v$TAG"
    else
        echo "WARNING: Failed to checkout $TAG or v$TAG. Falling back to main/master..."
        git -C "$REPO_DIR" checkout main >/dev/null 2>&1 || git -C "$REPO_DIR" checkout master >/dev/null 2>&1
    fi

    rm -rf "$DEST_DIR"
    mkdir -p "$DEST_DIR"

    if [ -d "$REPO_DIR/charts/$CHART_NAME" ]; then
        cp -r "$REPO_DIR/charts/$CHART_NAME"/* "$DEST_DIR/"
    elif [ -d "$REPO_DIR/charts" ]; then
        if [ -f "$REPO_DIR/charts/Chart.yaml" ]; then
            cp -r "$REPO_DIR/charts"/* "$DEST_DIR/"
        else
            cp -r "$REPO_DIR/charts"/*/* "$DEST_DIR/" 2>/dev/null || cp -r "$REPO_DIR/charts"/* "$DEST_DIR/"
        fi
    else
        cp -r "$REPO_DIR"/* "$DEST_DIR/"
    fi


    if [ -f "$DEST_DIR/Chart.yaml" ]; then
        sed -i '' "s/\${PROJECT_RELEASE_VERSION}/$TAG/g" "$DEST_DIR/Chart.yaml"
    fi

    rm -rf "$DEST_DIR/.git"

    rm -rf "$REPO_DIR"
    
    echo "SUCCESS: $CHART_NAME updated."
done

echo "============================================================"
echo " Update process complete."
echo " NOTE: Do not forget to re-apply any TFDS-specific patches"
echo " (e.g., certsEndpoint in authentication-provider) if the"
echo " upstream values.yaml was overwritten during this sync."
echo "============================================================"
