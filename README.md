# mylibrary

Personal LaTeX classes and styles for mathematical documents.

## Current classes

The current interface is provided by:

- `normal`: English theorem environments implemented with `amsthm`;
- `boxed`: English theorem and proof environments implemented with `tcolorbox`;
- `jnormal`: Japanese theorem environments implemented with `amsthm`;
- `jboxed`: Japanese theorem and proof environments implemented with `tcolorbox`.

All four classes use the same document-side environment names:
`definition`, `theorem`, `proposition`, `lemma`, `corollary`, `example`,
`remark`, `notation`, and `proof`.

The author writes `\qed` explicitly in a proof.  All four classes accept the
same theorem syntax, for example:

```latex
\begin{definition}[A definition]
\label{def:sample}
...
\end{definition}
```

## Numbering options

```latex
\documentclass[
  numbering=separate,
  numberwithin=section,
]{normal}
```

- `numbering=separate|shared` controls whether theorem and equation counters
  are independent or shared;
- `numberwithin=global|section|subsection` sets the default reset unit;
- `thmnumberwithin=global|section|subsection` overrides it for theorems;
- `eqnumberwithin=global|section|subsection` overrides it for equations.

If the last two options are omitted, both inherit `numberwithin`.

## Templates and installation

The copyable document template is maintained in the notes workspace, not in
this library:

```text
notes/templates/template.tex
notes/templates/preamble.tex
```

Copy `template.tex` when starting a document.  Use `preamble.tex` as a
settings cookbook when changing margins, links, page styles, or numbering.

Copy this directory to a TeX tree searched by TeX, for example
`~/Library/texmf/tex/latex/mylibrary`.

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

The older Japanese classes currently in the tree are not the specification for
the new interface.
