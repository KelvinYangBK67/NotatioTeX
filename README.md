# NotatioTeX

**A small XeLaTeX extension for mathematical notation across writing systems and typographic traditions.**

NotatioTeX 的首期目標是《代微積拾級》等中文數學文獻，以及現代阿拉伯文數學排版。
本專案在現有 LaTeX 數學系統上提供可選、可覆寫的文種接口；不另造公式引擎。

> **Status:** 0.1.0 development baseline. Its examples are synthetic API tests,
> **not** authoritative transcriptions of *代微積拾級*. Complete Arabic RTL
> mathematics and historical symbol catalogues are **not implemented**.

## Requirements

- XeLaTeX (XeTeX engine only for now), LaTeX kernel, `fontspec`.
- An installed CJK font for the Chinese example (`Noto Serif CJK SC`).
- An installed Arabic font for the Arabic example (`Amiri`).
- Optional: `amsmath`, `unicode-math`, `xeCJK`, `polyglossia`, as appropriate to
  the host document. NotatioTeX does **not** load or reconfigure these.

No fonts are distributed by this repository.

## Quick start

Copy the three files from `tex/latex/notatiotex/` into your TeX project (or
put the directory on `TEXINPUTS`), then compile using XeLaTeX:

```tex
\documentclass{article}
\usepackage[chinese,arabic]{notatiotex}
\NotatioSetHanFont{Noto Serif CJK SC}
\NotatioSetArabicFont{Amiri}
\NotatioDeclareSymbol{custom:han}{\NotatioHanMath{甲}}
\begin{document}
\[
  \NotatioUseSymbol{custom:han} + \NotatioHanMath{乙}
  = \NotatioArabicNumeral{12.5}
\]
\end{document}
```

## Minimal public API

| Command | Meaning |
| --- | --- |
| `\NotatioDeclareSymbol{key}{replacement}` | Declare or override an explicit named mapping. |
| `\NotatioUseSymbol{key}` | Insert the named replacement; undefined keys cause an error. |
| `\NotatioSetGlyphFont{font}` | Choose a text font for generic glyph insertion. |
| `\NotatioGlyph[class]{glyph}` | Insert a Unicode glyph as a text-font math atom. |
| `\NotatioSetHanFont{font}` | Choose a Chinese glyph font (`chinese` option). |
| `\NotatioHanMath[class]{glyph}` | Insert a Chinese character (`chinese` option). |
| `\NotatioSetArabicFont{font}` | Choose an Arabic glyph font (`arabic` option). |
| `\NotatioArabicMath[class]{glyph}` | Insert an Arabic-script glyph (`arabic` option). |
| `\NotatioArabicNumeral{12.5}` | Produce `١٢٫٥` (`arabic` option); only ASCII digits and `.` are mapped. |

`class` defaults to `ord`. Supported math classes: `ord`, `bin`, `rel`,
`op`, `open`, `close`, `punct`, `inner`. Outside math mode the class is ignored.
For binary signs or relations, **set the class yourself** to retain conventional
TeX math spacing. The font selected must contain the actual codepoints.

Options: `chinese`, `arabic`, `all` (both); omit options for the core alone.
Additional packages retain control over page direction and full math layout.

**Unicode PDF extraction:** For shaped Arabic letters, XeTeX's standard
`\XeTeXgenerateactualtext=1` primitive can improve logical Unicode copying.
NotatioTeX does not set it globally, but `tests/copy.tex` demonstrates it and
verifies extraction with `pdftotext`. It attaches ActualText to visible glyph
runs; it is **not** an independent invisible text overlay. Copy fidelity can
still vary by reader, font, and layout.

## Build / tests

```sh
bash tests/run-tests.sh
```

This compiles four tests and two independent examples to `build/`. Where
`pdftotext` is available, the test suite also checks extracted Unicode text.
GitHub Actions runs the same XeLaTeX checks. No generated PDFs are committed.

## Scope

See [docs/scope.md](docs/scope.md) for explicit non-goals and development
stages. In particular, Arabic-script glyph insertion **does not** imply fully
RTL mathematical layout. A full historical symbol table requires verification
against sources and fonts before implementation.

## License

MIT (see `LICENSE`).
