# Scope and implementation boundaries

## Objective

NotatioTeX is a small XeLaTeX add-on for mathematical notation that is not
served well by conventional LaTeX defaults. Initial targets are Chinese
mathematical typography, especially notational evidence in *代微積拾級*, and
contemporary Arabic mathematical typography.

## Boundaries for the initial baseline

- Respect the ordinary LaTeX math engine. Do not replace amsmath, unicode-math,
  polyglossia, fontspec, xeCJK, or TeX's mathematical layout system.
- Preserve actual Unicode character data where it is available, rather than
  drawing glyphs or adding an invisible OCR/text overlay.
- Do not globally redefine common math commands (`\frac`, `\sqrt`, etc.).
- Each glyph insertion declares its intended TeX math atom class. Spacing
  follows that class; no heuristic classification is applied.
- No font bundling. Glyph coverage remains dependent on the user's font.
- Do not pretend that flipping RTL text direction produces RTL math layout.
  Correct RTL formula structures, mirroring, radicals, matrices, operators,
  limits and copy/paste need independent implementation and validation.
- Do not predeclare unverified Chinese historical symbols or fabricate
  Unicode equivalences for them. Compose only after verification against
  editions and the required font repertoire.

## Future independently reviewable features

1. A source-cited notation inventory of *代微積拾級* (exact symbols and meanings).
2. Unicode/font coverage table for Han mathematical symbols, including
   mouth-radical and celestial/stem-derived forms where applicable.
3. Verified named mappings for the Chinese mathematical repertory.
4. Arabic mathematical symbol coverage and font-specific OpenType support.
5. Correct bidirectional mathematical layout with explicit examples and tests.
6. Round-trip extraction tests on the compiled PDFs.

Avoid committing fonts or reproduced scans without rights clearance.
