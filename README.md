# LaTeX classes and styles

Personal LaTeX classes and packages for Japanese and English documents.

## Engines

- `jynormal`, `jyboxed`, `jyplain`, and `jyreport` are for LuaLaTeX.
- `ynormal` and `yboxed` are for LuaLaTeX.
- `jnormal` is for XeLaTeX and is based on `bxjsarticle`.

The math font package uses New Computer Modern Math and Euler Math. Japanese font packages are engine-specific: LuaLaTeX uses `luatexja`; XeLaTeX uses `xeCJK` and Harano Aji fonts.

## Install

Copy this directory to a TeX tree searched by TeX, for example `~/Library/texmf/tex/latex/mylibrary`. Compile Japanese classes with their designated engine.

```sh
latexmk -lualatex sample.tex
latexmk -xelatex sample.tex
```

## `jnormal` numbering

```latex
\documentclass[
  numbering=shared,
  numberwithin=section,
  equations=all
]{jnormal}
```

- `numbering=shared|independent` controls whether theorem-like environments share the equation counter.
- `numberwithin=global|section|subsection` controls counter resets.
- `equations=all|referenced` controls whether every numbered equation is displayed or only referenced equations are displayed.

The defaults are `shared`, `section`, and `all`.

Numbered environments take a heading and a label key:

```latex
\begin{definition}{A definition}{sample}
...
\end{definition}
```

The class adds environment-specific label prefixes (`def:`, `thm:`, `prop:`, `cor:`, `lem:`, and `ex:`). Pass an empty second argument to generate the key from the environment counter.

## Directory layout

```text
class/       Document classes
style/
  core/      Engine-independent packages and macros
  fonts/     Math fonts and engine-specific Japanese fonts
  layout/    Page margins, headings, and running headers
  boxstyle/  Box and theorem appearance styles
  toc/       Table-of-contents styles
```
