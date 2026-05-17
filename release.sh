#!/usr/bin/env bash
# ============================================================
#  release.sh — Music Reading Trainer release helper
#  First introduced for v0.1.0 (May 2026)
#
#  Adapted from the Ear Trainer release script. Same shape, same
#  guardrails, same human-friendly output — adjusted for this
#  repo's file layout (single index.html, no separate ear-trainer.html
#  mirror — GitHub Pages serves index.html directly).
#
#  What this does, in order:
#    1. Verifies the working tree is clean (no uncommitted changes).
#    2. Reads the version you pass in (e.g. ./release.sh 0.1.0).
#    3. Confirms index.html and CHANGELOG.md both reference that
#       exact version — refuses to release if they don't match.
#    4. Confirms a v<version> tag does NOT already exist.
#    5. Shows you a summary of what's about to happen and waits for
#       you to type "yes" before doing anything destructive.
#    6. Tags v<version>, pushes the commit and the tag to origin.
#
#  What this does NOT do:
#    - Edit files for you. You bump the version in index.html and
#      write the CHANGELOG entry by hand (or with Claude's help).
#      The script's job is to make sure those edits are consistent
#      and to perform the git plumbing safely.
#    - Build, lint, or test. This project is a single static HTML
#      file with no build step.
#
#  Usage:
#    ./release.sh 0.1.0
#    ./release.sh 0.1.1 --dry-run     (show what would happen, do nothing)
#
#  Exit codes:
#    0  success
#    1  precondition failed (dirty tree, version mismatch, tag exists)
#    2  user aborted at the confirmation prompt
#    3  bad arguments
# ============================================================

set -euo pipefail

# ---- colors (only if stdout is a terminal) -----------------
if [ -t 1 ]; then
  RED=$'\033[31m'; GRN=$'\033[32m'; YLW=$'\033[33m'
  BLU=$'\033[34m'; DIM=$'\033[2m';  RST=$'\033[0m'
else
  RED=""; GRN=""; YLW=""; BLU=""; DIM=""; RST=""
fi

say()  { printf '%s\n' "$*"; }
ok()   { printf '%s✓%s %s\n' "${GRN}" "${RST}" "$*"; }
warn() { printf '%s!%s %s\n' "${YLW}" "${RST}" "$*"; }
fail() { printf '%s✗%s %s\n' "${RED}" "${RST}" "$*" >&2; }
step() { printf '\n%s── %s ──%s\n' "${BLU}" "$*" "${RST}"; }

# ---- argument parsing --------------------------------------
DRY_RUN=0
VERSION=""

for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN=1 ;;
    -h|--help)
      sed -n '2,36p' "$0"
      exit 0
      ;;
    -*)
      fail "unknown flag: $arg"
      exit 3
      ;;
    *)
      if [ -n "$VERSION" ]; then
        fail "more than one version supplied: '$VERSION' and '$arg'"
        exit 3
      fi
      VERSION="$arg"
      ;;
  esac
done

if [ -z "$VERSION" ]; then
  fail "usage: ./release.sh <version> [--dry-run]"
  fail "example: ./release.sh 0.1.0"
  exit 3
fi

# Sanity-check version format (semver-ish: N.N.N, no leading 'v').
if ! [[ "$VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  fail "version must look like 0.1.0 (no leading 'v', no suffix)"
  fail "got: $VERSION"
  exit 3
fi

TAG="v$VERSION"

# ---- precondition: in a git repo ---------------------------
step "Checking environment"

if ! git rev-parse --git-dir >/dev/null 2>&1; then
  fail "not inside a git repository"
  exit 1
fi
ok "inside a git repo"

# ---- precondition: on the main branch ----------------------
CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
if [ "$CURRENT_BRANCH" != "main" ]; then
  warn "current branch is '$CURRENT_BRANCH', not 'main'"
  warn "releases normally happen from main; continuing anyway, but double-check this is intentional"
else
  ok "on main branch"
fi

# ---- precondition: working tree clean ----------------------
if ! git diff --quiet || ! git diff --cached --quiet; then
  fail "working tree has uncommitted changes"
  fail "commit or stash them before releasing:"
  git status --short >&2
  exit 1
fi
ok "working tree clean"

# ---- precondition: index.html mentions this version --------
step "Checking index.html version stamp"

# We expect ONE version mention in index.html, in the top HTML comment:
#   Music Reading Trainer · vX.Y.Z · YYYY-MM-DD
# (Single-file app; no separate JS-comment version stamp needed since
# the JS is inline in the same file.)
INDEX_VERSION_HITS=$(grep -c "Music Reading Trainer · v$VERSION" index.html || true)

if [ "$INDEX_VERSION_HITS" -lt 1 ]; then
  fail "index.html top comment does not mention v$VERSION"
  fail "expected to find a line like:  Music Reading Trainer · v$VERSION · YYYY-MM-DD"
  exit 1
fi
ok "index.html top comment mentions v$VERSION"

# ---- precondition: CHANGELOG has an entry for this version ---
step "Checking CHANGELOG.md"

if ! grep -q "^## \[$VERSION\]" CHANGELOG.md; then
  fail "CHANGELOG.md has no '## [$VERSION]' heading"
  fail "add a release entry for v$VERSION before running this script"
  exit 1
fi
ok "CHANGELOG.md has an entry for [$VERSION]"

# Soft-warn if the entry has no date on its heading line.
if ! grep -qE "^## \[$VERSION\] — [0-9]{4}-[0-9]{2}-[0-9]{2}" CHANGELOG.md; then
  warn "CHANGELOG entry for [$VERSION] has no YYYY-MM-DD date — fine, but worth a glance"
fi

# ---- precondition: tag doesn't already exist ---------------
step "Checking tag availability"

if git rev-parse --verify --quiet "refs/tags/$TAG" >/dev/null; then
  fail "tag $TAG already exists locally"
  fail "if this was a previous attempt, delete it: git tag -d $TAG"
  exit 1
fi

# Also check the remote, in case someone else pushed a tag with this name.
if git ls-remote --tags origin "refs/tags/$TAG" 2>/dev/null | grep -q "$TAG"; then
  fail "tag $TAG already exists on origin"
  exit 1
fi
ok "tag $TAG is available locally and on origin"

# ---- summarize and confirm ---------------------------------
step "Summary"

LAST_TAG="$(git describe --tags --abbrev=0 2>/dev/null || echo '(none)')"
COMMIT_COUNT="$(git rev-list --count "${LAST_TAG:+$LAST_TAG..}HEAD" 2>/dev/null || echo '?')"
HEAD_SHA="$(git rev-parse --short HEAD)"

cat <<EOF
  Version:        $VERSION
  Tag:            $TAG
  Branch:         $CURRENT_BRANCH
  HEAD commit:    $HEAD_SHA
  Previous tag:   $LAST_TAG
  Commits since:  $COMMIT_COUNT

About to:
  1. Tag HEAD ($HEAD_SHA) as $TAG with an annotated message.
  2. Push the current branch to origin/$CURRENT_BRANCH.
  3. Push the tag $TAG to origin.

EOF

if [ "$DRY_RUN" -eq 1 ]; then
  warn "--dry-run set: stopping here. No git operations performed."
  exit 0
fi

printf "Type %syes%s to proceed: " "${YLW}" "${RST}"
read -r CONFIRM
if [ "$CONFIRM" != "yes" ]; then
  warn "aborted by user (got '$CONFIRM', wanted 'yes')"
  exit 2
fi

# ---- do the thing ------------------------------------------
step "Releasing"

git tag -a "$TAG" -m "Release $TAG

See CHANGELOG.md section [$VERSION] for full notes."
ok "created tag $TAG"

git push origin "$CURRENT_BRANCH"
ok "pushed $CURRENT_BRANCH to origin"

git push origin "$TAG"
ok "pushed tag $TAG to origin"

step "Done"
say  "  ${GRN}✓${RST} Released ${TAG}"
say  "  ${DIM}GitHub Pages will rebuild within a minute or two.${RST}"
say  "  ${DIM}Check: https://filmnoises.github.io/Music-Reading/${RST}"
