\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{boxed}[2026/10/09 tcolorbox theorem class]

\makeatletter
\def\mylib@class@numbering{separate}
\def\mylib@class@numberwithin{section}
\def\mylib@class@thmnumberwithin{}
\def\mylib@class@eqnumberwithin{}

% Theorem-numbering options are handled here and are not forwarded to article.
\DeclareOption{numbering=shared}{\def\mylib@class@numbering{shared}}
\DeclareOption{numbering=separate}{\def\mylib@class@numbering{separate}}
\DeclareOption{numberwithin=global}{\def\mylib@class@numberwithin{global}}
\DeclareOption{numberwithin=section}{\def\mylib@class@numberwithin{section}}
\DeclareOption{numberwithin=subsection}{\def\mylib@class@numberwithin{subsection}}
\DeclareOption{thmnumberwithin=global}{\def\mylib@class@thmnumberwithin{global}}
\DeclareOption{thmnumberwithin=section}{\def\mylib@class@thmnumberwithin{section}}
\DeclareOption{thmnumberwithin=subsection}{\def\mylib@class@thmnumberwithin{subsection}}
\DeclareOption{eqnumberwithin=global}{\def\mylib@class@eqnumberwithin{global}}
\DeclareOption{eqnumberwithin=section}{\def\mylib@class@eqnumberwithin{section}}
\DeclareOption{eqnumberwithin=subsection}{\def\mylib@class@eqnumberwithin{subsection}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

\edef\mylib@class@commonoptions{%
  numbering=\mylib@class@numbering,%
  numberwithin=\mylib@class@numberwithin,%
  thmnumberwithin=\mylib@class@thmnumberwithin,%
  eqnumberwithin=\mylib@class@eqnumberwithin%
}
\expandafter\PassOptionsToPackage\expandafter
  {\mylib@class@commonoptions}{theorem/common}

\RequirePackage{core/packages}
\RequirePackage{core/macros}
\RequirePackage{layout/page-margins}
\RequirePackage{layout/head-foot}
\RequirePackage{toc/toc-eng}
\RequirePackage{core/hyperlinks}
\RequirePackage{theorem/common}
\RequirePackage{theorem/boxed}
\RequirePackage{theorem/backend-tcolorbox}

\makeatother

\endinput
