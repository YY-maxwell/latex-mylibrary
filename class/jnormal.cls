\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{jnormal}[2026/10/07 XeLaTeX Japanese article class]

% Class options
\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=summary,prefix=summary@}
\DeclareStringOption[shared]{numbering}
\DeclareStringOption[section]{numberwithin}
\DeclareStringOption[all]{equations}
\ProcessKeyvalOptions*

\DeclareOption{numbering=shared}{}
\DeclareOption{numbering=independent}{}
\DeclareOption{numberwithin=global}{}
\DeclareOption{numberwithin=section}{}
\DeclareOption{numberwithin=subsection}{}
\DeclareOption{equations=all}{}
\DeclareOption{equations=referenced}{}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{bxjsarticle}}
\ProcessOptions\relax
\PassOptionsToClass{xelatex,ja=standard}{bxjsarticle}
\LoadClass{bxjsarticle}

% Shared packages and XeLaTeX fonts
\RequirePackage{etoolbox}
\RequirePackage{amsthm}
\RequirePackage{core/packages}
\RequirePackage{fonts/math-newcm-euler}
\RequirePackage{core/macros}
\RequirePackage{fonts/japanese-xetex}
\RequirePackage{layout/headings}
\RequirePackage{layout/page-margins,layout/head-foot}
\RequirePackage{toc/toc-ja}
\RequirePackage{core/hyperlinks}

% Equation numbering
\ifdefstring{\summary@equations}{referenced}{\mathtoolsset{showonlyrefs=true}}{}
\ifdefstring{\summary@numberwithin}{section}{\numberwithin{equation}{section}}{}
\ifdefstring{\summary@numberwithin}{subsection}{\numberwithin{equation}{subsection}}{}

% Theorem styles
\newtheoremstyle{jnormal-definition}
  {8pt}{8pt}{\normalfont}{}
  {\sffamily}{}{5pt plus 1pt minus 1pt}
  {\thmnumber{{\bfseries(#2)}}\thmname{{\bfseries#1}}\thmnote{（#3）}}
\newtheoremstyle{jnormal-plain}
  {8pt}{8pt}{\itshape}{}
  {\sffamily\bfseries}{ }{5pt plus 1pt minus 1pt}
  {\thmnumber{{\bfseries(#2)}}\thmname{{\bfseries#1}}\thmnote{（#3）}}

% Theorem numbering
\theoremstyle{jnormal-definition}
\ifdefstring{\summary@numbering}{shared}{
  \newtheorem{innerdefinition}[equation]{定義}
}{
  \ifdefstring{\summary@numberwithin}{section}{
    \newtheorem{innerdefinition}{定義}[section]
  }{
    \ifdefstring{\summary@numberwithin}{subsection}{
      \newtheorem{innerdefinition}{定義}[subsection]
    }{\newtheorem{innerdefinition}{定義}}
  }
}
\ifdefstring{\summary@numbering}{shared}{
  \theoremstyle{jnormal-plain}
  \newtheorem{innertheorem}[equation]{定理}
  \newtheorem{innerproposition}[equation]{命題}
  \newtheorem{innercorollary}[equation]{系}
  \newtheorem{innerlemma}[equation]{補題}
  \theoremstyle{jnormal-definition}
  \newtheorem{innerexample}[equation]{例}
}{
  \theoremstyle{jnormal-plain}
  \newtheorem{innertheorem}[innerdefinition]{定理}
  \newtheorem{innerproposition}[innerdefinition]{命題}
  \newtheorem{innercorollary}[innerdefinition]{系}
  \newtheorem{innerlemma}[innerdefinition]{補題}
  \theoremstyle{jnormal-definition}
  \newtheorem{innerexample}[innerdefinition]{例}
}

% The environments take a heading and a label key.
\makeatletter
\newcommand{\jnormal@start}[4]{%
  \begin{#1}[#3]%
  \ifstrempty{#4}{\label{#2:\theinnerdefinition}}{\label{#2:#4}}%
}
\NewDocumentEnvironment{definition}{mm}{\jnormal@start{innerdefinition}{def}{#1}{#2}}{\end{innerdefinition}}
\NewDocumentEnvironment{theorem}{mm}{\jnormal@start{innertheorem}{thm}{#1}{#2}}{\end{innertheorem}}
\NewDocumentEnvironment{proposition}{mm}{\jnormal@start{innerproposition}{prop}{#1}{#2}}{\end{innerproposition}}
\NewDocumentEnvironment{corollary}{mm}{\jnormal@start{innercorollary}{cor}{#1}{#2}}{\end{innercorollary}}
\NewDocumentEnvironment{lemma}{mm}{\jnormal@start{innerlemma}{lem}{#1}{#2}}{\end{innerlemma}}
\NewDocumentEnvironment{example}{mm}{\jnormal@start{innerexample}{ex}{#1}{#2}}{\end{innerexample}}
\makeatother

\theoremstyle{jnormal-definition}
\newtheorem*{remark}{注意}
\newtheorem*{notation}{記法}

% Proof environment
\renewcommand{\proofname}{証明}
\renewcommand{\qedsymbol}{\scalebox{.5}[1]{\textcolor{gray}{$\blacksquare$}}}
\newenvironment{myproof}[1][証明]{\begin{proof}[#1]}{\end{proof}}
