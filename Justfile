# Development commands. Nothing outside typst.toml, lib.typ, src/, README.md,
# LICENSE and docs/ belongs in a submission to typst/packages; `exclude` in
# typst.toml keeps the rest out of the downloaded bundle either way.
#
# Before submitting: set `repository` in typst.toml, and check that the
# version in every `@preview/cartouche:…` import matches the one being
# published.

root := justfile_directory()
name := `grep '^name' typst.toml | head -1 | cut -d'"' -f2`
version := `grep '^version' typst.toml | head -1 | cut -d'"' -f2`
data-dir := if os() == "macos" { "$HOME/Library/Application Support" } else if os() == "windows" { "$APPDATA" } else { "${XDG_DATA_HOME:-$HOME/.local/share}" }

export TYPST_ROOT := root

[private]
default:
  @just --list --unsorted

# link the package into the @local namespace, so docs/ and dev/ resolve
install:
  mkdir -p "{{data-dir}}/typst/packages/local/{{name}}"
  ln -sfn "{{root}}" "{{data-dir}}/typst/packages/local/{{name}}/{{version}}"
  @echo "linked @local/{{name}}:{{version}}"

# remove the @local link
uninstall:
  rm -f "{{data-dir}}/typst/packages/local/{{name}}/{{version}}"

# run the test suite
test *args:
  tt run --no-fail-fast {{ args }}

# update the stored reference images
update *args:
  tt update {{ args }}

# compile everything against the typst on PATH, without comparing pixels
check: install
  #!/usr/bin/env bash
  set -euo pipefail
  typst --version
  for f in tests/*/test.typ dev/gallery.typ dev/placement.typ; do
    typst compile -f pdf "$f" /dev/null 2>/dev/null || typst compile "$f" "${TMPDIR:-/tmp}/check.pdf"
    echo "ok $f"
  done

# regenerate the images used by the README
docs: install
  #!/usr/bin/env bash
  set -euo pipefail
  mkdir -p dev/build
  typst compile dev/gallery.typ docs/gallery-light.png --ppi 120
  typst compile dev/gallery.typ docs/gallery-dark.png --ppi 120 --input theme=dark
  typst compile dev/placement.typ dev/build/place-{p}.png --ppi 150
  typst compile dev/contact-sheet.typ docs/placement.png --ppi 150 \
    --input pages=/dev/build/place-1.png,/dev/build/place-2.png --input width=7cm
  # docs/example.typ imports the published package; point it at the local copy
  sed 's|@preview/{{name}}:{{version}}|@local/{{name}}:{{version}}|' docs/example.typ > dev/build/example.typ
  typst compile dev/build/example.typ dev/build/page-{p}.png --ppi 150
  typst compile dev/contact-sheet.typ docs/example.png --ppi 150 --input per-row=3 \
    --input pages=/dev/build/page-1.png,/dev/build/page-2.png,/dev/build/page-3.png,/dev/build/page-4.png,/dev/build/page-5.png

# everything CI runs
ci: test docs
