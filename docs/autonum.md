# Automatic equation numbering

The four current classes load `equation/autonum-support.sty` after their theorem
backend and equation tag style. The package loads `autonum` after `amsmath`,
`hyperref`, and `cleveref`, as required by the
[autonum manual](https://mirrors.ctan.org/macros/latex/contrib/autonum/autonum.pdf).
`core/hyperlinks.sty` loads `hyperref` with `hypertexnames=false` so that
equations without numbers do not create duplicate link destinations.

`autonum` handles `\ref` and `\cref` directly. This library uses its documented
comma-list helper for `\Cref` and `\labelcref`. The ordinary `\eqref` calls the
patched `\ref`; this library also defines `\eqref*` through `\ref*`, retaining
the selected equation tag format while omitting the link. These commands do
not alter theorem counters, reference names, or font commands.

The package does not recognize `\crefrange` as a reference for automatic
numbering. A range whose endpoints are equations must be written as separate
references if those equations would otherwise have no reference. Explicit
`\tag` prints its tag even without a reference; `autonum` only writes that
equation's label when referenced. `\notag` suppresses a row's number. To force
an ordinary number without any reference, use the `+` form of the environment,
such as `equation+` or `align+`. Starred math environments are removed by
`autonum`. See the README for examples and migration guidance.

Run the regression checks from the repository root:

```sh
python3 tests/verify-references.py
python3 tests/verify-autonum-commands.py
python3 tests/verify-autonum-changes.py
```

The first check covers all four classes under XeLaTeX and LuaLaTeX, both
numbering modes, and all three `numberwithin` values. The second checks each
supported reference command and comma-list form independently. The third
checks that numbers appear and disappear after references are edited. The
`tests/autonum-links.tex` fixture places targets on separate pages for checking
PDF link destinations. Compilation may require three or more runs after
reference changes.

With TeX Live 2025, `autonum`'s `etextools` dependency loads `etex.sty`, which
reports `Extended allocation already in use`. This warning also occurs in a
minimal `article` document that loads `etex` before `autonum`; it does not
indicate a numbering or reference failure. Under LuaLaTeX, `etextools` also
reports that `\pdfstrcmp` is unavailable and uses its documented fallback.
These are new upstream dependency warnings; no undefined references or
duplicate hyperlink destinations remain after convergence. The existing
`unicode-math`, `mathtools`, and `xeCJK` warnings remain unchanged.
