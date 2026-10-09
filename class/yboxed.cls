\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{yboxed}[2025/09/18 ]


% --- Options ---
\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=summary,prefix=summary@}
\DeclareStringOption[global]{eqnumbering}
\DeclareStringOption[global]{thmnumbering}
\ProcessKeyvalOptions*


% --- These \DeclareOption lines mark eqnumbering/thmnumbering as
%     “handled here” so they will not be forwarded to the parent class
%     (article). This prevents unknown option warnings from article. ---
\DeclareOption{eqnumbering=global}{}
\DeclareOption{eqnumbering=section}{}
\DeclareOption{eqnumbering=subsection}{}
\DeclareOption{thmnumbering=global}{}
\DeclareOption{thmnumbering=section}{}
\DeclareOption{thmnumbering=subsection}{}


% --- Parent Class ---
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}


% --- Load packages ---
\RequirePackage{etoolbox}% for eq/thm numbering
% user-defined
\RequirePackage{core/packages}
\RequirePackage{fonts/math-newcm-euler}
\RequirePackage{core/macros}
\RequirePackage{layout/page-margins,layout/head-foot}
\RequirePackage{toc/toc-eng}
\RequirePackage{boxstyle/hruled, boxstyle/plain, boxstyle/simpleboxed, boxstyle/westruled, boxstyle/proofstyle}
\RequirePackage{core/hyperlinks}

% --- numbering systems for equation and theorem ---
\mathtoolsset{showonlyrefs=true}% 数式環境の中で，のちに参照するもののみ番号を振る設定

\AtEndOfClass{
    \makeatletter
    % equation numbering
    \ifdefstring{\summary@eqnumbering}{section}{
        \numberwithin{equation}{section}
        \renewcommand{\theequation}{\thesection.\arabic{equation}}
    }{
    \ifdefstring{\summary@eqnumbering}{subsection}{
        \numberwithin{equation}{subsection}
        \renewcommand{\theequation}{\thesubsection.\arabic{equation}}
    }{% else: default is like (1)...
        \@ifundefined{c@equation}{\newcounter{equation}}{}%
        \renewcommand{\theequation}{\arabic{equation}}
    }
    }

    % definition/theorem numbering
    \ifdefstring{\summary@thmnumbering}{section}{% if thmnumbering=section
        \newtcbtheorem[number within=section]{definition}{Definition}{
            proofstyle,
            line color = black,
            separator sign none,
            fonttitle = \bfseries,
            before upper = {%
                \hspace*{-14pt}\tcbtitle\textbf{.}\;
            },
        }{def}
    }{
    \ifdefstring{\summary@thmnumbering}{subsection}{%if thmnumbering=subsection
        \newtcbtheorem[number within=subsection]{definition}{Definition}{
            proofstyle,
            line color = black,
            separator sign none,
            fonttitle = \bfseries,
            before upper = {
                \hspace*{-14pt}\tcbtitle\textbf{.}\;
            },
        }{def}
    }{% else default
        \newtcbtheorem{definition}{Definition}{
            proofstyle,
            line color = black,
            separator sign none,
            fonttitle = \bfseries,
            before upper = {
                \hspace*{-14pt}\tcbtitle\textbf{.}\;
            },
        }{def}
    }
    }
    \makeatother

    % define theorem environments
    \newtcbtheorem[use counter from=definition]{theorem}{Theorem}{
        simpleboxed,
        separator sign none,
        fonttitle = \bfseries,
        fontupper = \itshape,
        before skip=0mm,
        after skip=-0mm,
    }{thm}
    \newtcbtheorem[use counter from=definition]{lemma}{Lemma}{
        simpleboxed,
        separator sign none,
        fonttitle = \bfseries,
        fontupper = \itshape
    }{lem}
    \newtcbtheorem[use counter from=definition]{corollary}{Corollary}{
        simpleboxed,
        separator sign none,
        fonttitle = \bfseries,
        fontupper = \itshape
    }{cor}
    \newtcbtheorem[use counter from=definition]{proposition}{Proposition}{
        simpleboxed,
        separator sign none,
        fonttitle = \bfseries,
        fontupper = \itshape
    }{prop}
    \newtcbtheorem[use counter from=definition]{example}{Example}{
        plain,
        separator sign none,
        fonttitle = \bfseries,
        before upper = {
            \hspace*{-14pt}\tcbtitle\textbf{.}\;
        },
    }{ex}
    \newtcolorbox{remark}{
        plain,
        fonttitle = \bfseries,
        before upper = {
            \hspace*{-14pt}\tcbtitle\;
        },
        title = Remark.
    }
    \newtcolorbox{notation}{
        plain,
        fonttitle = \bfseries,
        before upper = {
            \hspace*{-14pt}\tcbtitle\;
        },
        title = Notation.
    }

% --- proof environment --- %
\newcommand{\qedsymbol}{\scalebox{.5}[1]{\textcolor{gray}{$\blacksquare$}}}
    \newenvironment{myproof}{
        \begin{proofbox}
    }{
        \qedsymbol\end{proofbox}
    }
}
