\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{jboxed}[2026/10/11 Japanese tcolorbox theorem class]

% The Japanese classes use bxjsarticle as their common parent.
% The compiler selects LuaLaTeX or XeLaTeX; the public class name stays the same.
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

\ifLuaTeX
  \PassOptionsToClass{lualatex,ja=standard}{bxjsarticle}
\else\ifXeTeX
  % Let bxjsarticle define the CJK families, but retain slanted emphasis.
  \PassOptionsToPackage{AutoFakeSlant=0.2}{xeCJK}
  \PassOptionsToClass{xelatex,ja=standard}{bxjsarticle}
\else
  \ClassError{jboxed}{Unsupported engine}{Use LuaLaTeX or XeLaTeX to compile this class.}
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
\RequirePackage{math/equation-ja}
\RequirePackage{theorem/names-ja}
\RequirePackage{theorem/typography-ja}
\RequirePackage{theorem/boxed}
\RequirePackage{theorem/backend-tcolorbox}

\makeatother

\endinput
