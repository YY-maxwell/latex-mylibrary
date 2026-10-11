\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{jnormal}[2026/10/11 Japanese amsthm-based article class]

% The Japanese classes use bxjsarticle as their common parent.
% The underlying engine is selected by the compiler; this class only supplies the corresponding Japanese text setup.
\RequirePackage{iftex}

\makeatletter
\def\mylib@class@numbering{separate}
\def\mylib@class@numberwithin{section}
\def\mylib@class@thmnumberwithin{}
\def\mylib@class@eqnumberwithin{}

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

% All other options, including paper size and font size, belong to bxjsarticle.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{bxjsarticle}}
\ProcessOptions\relax

% Make the engine choice explicit for bxjsarticle while keeping one public class name for both supported engines.
\ifLuaTeX
  \PassOptionsToClass{lualatex,ja=standard}{bxjsarticle}
\else\ifXeTeX
  \PassOptionsToClass{xelatex,ja=standard}{bxjsarticle}
\else
  \ClassError{jnormal}{Unsupported engine}{Use LuaLaTeX or XeLaTeX to compile this class.}
\fi\fi
\LoadClass{bxjsarticle}

\edef\mylib@class@commonoptions{%
  numbering=\mylib@class@numbering,%
  numberwithin=\mylib@class@numberwithin,%
  thmnumberwithin=\mylib@class@thmnumberwithin,%
  eqnumberwithin=\mylib@class@eqnumberwithin%
}
\expandafter\PassOptionsToPackage\expandafter
  {\mylib@class@commonoptions}{theorem/common}

\RequirePackage{core/packages}
\RequirePackage{fonts/math-newcm-euler}
\RequirePackage{core/macros}
\RequirePackage{layout/page-margins}
\RequirePackage{layout/head-foot}
\RequirePackage{toc/toc-ja}
\RequirePackage{core/hyperlinks}
\RequirePackage{math/equation}

\ifLuaTeX
  \RequirePackage{fonts/japanese-luatex}
\else
  \RequirePackage{fonts/japanese-xetex}
\fi

\RequirePackage{theorem/common}
\RequirePackage{math/japanese}
\RequirePackage{theorem/names-ja}
\RequirePackage{theorem/japanese}
\RequirePackage{theorem/normal}
\RequirePackage{theorem/backend-amsthm}

\makeatother

\endinput
