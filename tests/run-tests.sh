#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
if ! command -v xelatex >/dev/null 2>&1; then
  echo 'XeLaTeX is required to run the tests.' >&2
  exit 1
fi
mkdir -p build
export TEXINPUTS="${PWD}/tex/latex/notatiotex//:${TEXINPUTS:-}"
for file in tests/core-only.tex tests/smoke.tex tests/unicode-math.tex \
            tests/copy.tex examples/chinese.tex examples/arabic.tex; do
  name="$(basename "$file" .tex)"
  echo "Compiling $file"
  xelatex -halt-on-error -interaction=nonstopmode -file-line-error \
    -output-directory=build "$file" > "build/${name}.stdout" 2>&1 || {
      cat "build/${name}.stdout" >&2
      exit 1
    }
  test -s "build/${name}.pdf"
done
if command -v pdftotext >/dev/null 2>&1; then
  pdftotext build/copy.pdf build/copy.txt
  grep -Fq '甲' build/copy.txt
  grep -Fq 'س' build/copy.txt
  grep -Fq '١٢٫٥' build/copy.txt
  echo 'Unicode PDF extraction checks passed.'
else
  echo 'pdftotext not installed; PDF extraction checks skipped.'
fi
echo 'XeLaTeX smoke tests passed (6 PDFs).'
