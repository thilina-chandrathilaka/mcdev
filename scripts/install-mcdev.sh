#!/usr/bin/env bash
# mcdev install script: fetch repo, overwrite .cursor with latest, merge .cursorrules (create / append / replace block).
# Run from your project root. Re-running updates mcdev files and merges the mcdev block in .cursorrules.
set -e

MCDEV_REPO="${MCDEV_REPO:-your-org/mcdev}"
MCDEV_BRANCH="${MCDEV_BRANCH:-main}"
TARBALL_DIR="${TMPDIR:-/tmp}/mcdev-install-$$"
START_MARKER="# --- mcdev (start) ---"
END_MARKER="# --- mcdev (end) ---"

cleanup() { rm -rf "$TARBALL_DIR"; }
trap cleanup EXIT

# Detect project root (directory where script is run)
TARGET_DIR="${MCDEV_TARGET_DIR:-$(pwd)}"
if [ ! -d "$TARGET_DIR" ]; then
  echo "Error: Target directory does not exist: $TARGET_DIR"
  exit 1
fi

mkdir -p "$TARBALL_DIR"
cd "$TARBALL_DIR"

# Fetch repo tarball
if [ -n "$MCDEV_GITHUB_TOKEN" ]; then
  # Private repo: use GitHub API tarball with token
  if ! curl -fsSL -H "Authorization: token $MCDEV_GITHUB_TOKEN" -L "https://api.github.com/repos/${MCDEV_REPO}/tarball/${MCDEV_BRANCH}" -o mcdev.tar.gz; then
    echo "Error: Failed to fetch mcdev repo (check MCDEV_REPO, MCDEV_BRANCH, and MCDEV_GITHUB_TOKEN)"
    exit 1
  fi
else
  # Public repo
  if ! curl -fsSL "https://github.com/${MCDEV_REPO}/archive/refs/heads/${MCDEV_BRANCH}.tar.gz" -o mcdev.tar.gz; then
    echo "Error: Failed to fetch mcdev repo (check MCDEV_REPO and MCDEV_BRANCH; for private repo set MCDEV_GITHUB_TOKEN)"
    exit 1
  fi
fi

tar xzf mcdev.tar.gz
# GitHub tarball extracts to owner-repo-sha (API) or repo-branch (refs/heads/branch)
EXTRACTED=$(find . -maxdepth 1 -type d -name '*' ! -name '.' | head -1)
if [ -z "$EXTRACTED" ] || [ ! -d "$EXTRACTED/.cursor" ]; then
  echo "Error: Unexpected tarball layout (missing .cursor)"
  exit 1
fi

# Overwrite .cursor with repo version (apply diffs on re-run)
mkdir -p "$TARGET_DIR/.cursor"
rsync -a --delete "$EXTRACTED/.cursor/" "$TARGET_DIR/.cursor/" 2>/dev/null || {
  cp -R "$EXTRACTED/.cursor/"* "$TARGET_DIR/.cursor/"
}

# Merge .cursorrules
REPO_CURSORRULES="$EXTRACTED/.cursorrules"
if [ ! -f "$REPO_CURSORRULES" ]; then
  echo "Warning: Repo has no .cursorrules; skipping merge"
else
  TARGET_CURSORRULES="$TARGET_DIR/.cursorrules"
  if [ ! -f "$TARGET_CURSORRULES" ]; then
    cp "$REPO_CURSORRULES" "$TARGET_CURSORRULES"
    echo "Created .cursorrules with mcdev block."
  else
    if grep -qF "$START_MARKER" "$TARGET_CURSORRULES" && grep -qF "$END_MARKER" "$TARGET_CURSORRULES"; then
      # Replace block: before + repo block + after (awk for portability on macOS and Linux)
      awk -v start="$START_MARKER" '$0 == start { exit } { print }' "$TARGET_CURSORRULES" > "$TARBALL_DIR/before.txt"
      awk -v end="$END_MARKER" 'f { print } $0 == end { f=1 }' "$TARGET_CURSORRULES" > "$TARBALL_DIR/after.txt"
      sed -n "/^${START_MARKER}$/,/^${END_MARKER}$/p" "$REPO_CURSORRULES" > "$TARBALL_DIR/block.txt"
      cat "$TARBALL_DIR/before.txt" "$TARBALL_DIR/block.txt" "$TARBALL_DIR/after.txt" > "$TARGET_CURSORRULES.tmp"
      mv "$TARGET_CURSORRULES.tmp" "$TARGET_CURSORRULES"
      echo "Updated mcdev block in .cursorrules."
    else
      echo "" >> "$TARGET_CURSORRULES"
      cat "$REPO_CURSORRULES" >> "$TARGET_CURSORRULES"
      echo "Appended mcdev block to .cursorrules."
    fi
  fi
fi

echo "mcdev files are in place. Open this project in Cursor and run mcdev-0-how-to-use to see commands."
