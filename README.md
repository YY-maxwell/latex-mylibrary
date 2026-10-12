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

The numbered theorem-like environments also have unnumbered starred forms:
`definition*`, `theorem*`, `proposition*`, `lemma*`, `corollary*`, and
`example*`.  They accept the same optional title argument and do not advance
the theorem counter.

The author writes `\qed` explicitly in a proof.  All four classes accept the
same theorem syntax, for example:

```latex
\begin{definition}[A definition]
\label{def:sample}
...
\end{definition}
```

The `comment` package is loaded by all four classes.  A block can therefore be
excluded with:

```latex
\begin{comment}
This is not processed or printed.
\end{comment}
```

Named blocks can be included or excluded with the package commands
`\includecomment`, `\excludecomment`, and `\specialcomment`.  The opening and
closing commands of these environments should be placed on lines of their own.

## Numbering options

```latex
\documentclass[
  numbering=separate,
  numberwithin=section,
]{normal}
```

- `numbering=separate|shared` controls whether theorem and equation counters
  are independent or shared;
- `numberwithin=global|section|subsection` sets the reset unit;
- with `numbering=separate`, `thmnumberwithin=global|section|subsection`
  and `eqnumberwithin=global|section|subsection` may override it for theorem
  and equation counters, respectively;
- with `numbering=shared`, the two individual options are invalid because the
  shared counter has only one reset unit.

With `numbering=separate`, omitted individual options inherit `numberwithin`.

## Page styles

The default page style is `notes`.  Two other named styles can be selected in
the preamble:

```latex
\pagestyle{seminar}
\seminarheader{Seminar title}
```

- `notes` displays the current section and subsection in the header;
- `seminar` uses a configurable centered header and a centered page number in
  the footer;
- `paper` uses a configurable centered running header and page numbers at the
  outer top corners.  It requires the `twoside` class option.

Set the running headers with `\seminarheader{...}` and `\paperheader{...}`.
These choices are page-style settings rather than separate document classes.

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
  math/      Mathematical notation and operators
  theorem/   Theorem backends and their shared interface
  toc/       Table-of-contents styles
```

## Legacy classes

`ynormal`, `yboxed`, `jynormal`, `jyboxed`, `jyplain`, and `jyreport` remain for
existing documents.  New documents should use one of the four current classes
listed above.  The legacy interfaces are not the specification for the current
classes and do not constrain their design.  Before a legacy class is removed or
moved, its remaining uses and any required migration must be checked.
