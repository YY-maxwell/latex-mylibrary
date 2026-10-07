\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{jyplain}[2025/09/18 定義・定理環境はインデントあり, 見出しに下線]


% --- Options ---
\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=summary,prefix=summary@}
\DeclareStringOption[global]{eqnumbering}
\DeclareStringOption[global]{thmnumbering}
\ProcessKeyvalOptions*


% --- These \DeclareOption lines mark eqnumbering/thmnumbering as
%     “handled here” so they will not be forwarded to the parent class
%     (article). This prevents unknown option warnings from article. -------------
\DeclareOption{eqnumbering=global}{}
\DeclareOption{eqnumbering=section}{}
\DeclareOption{eqnumbering=subsection}{}
\DeclareOption{thmnumbering=global}{}
\DeclareOption{thmnumbering=section}{}
\DeclareOption{thmnumbering=subsection}{}


% --- Parent Class ---
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{jlreq}}
\ProcessOptions\relax
\LoadClass{jlreq}


% --- Load packages ---
\RequirePackage{etoolbox}% for eq/thm numbering
% user-defined
\RequirePackage{core/packages}
\RequirePackage{fonts/math-newcm-euler}
\RequirePackage{core/macros}
\RequirePackage{fonts/japanese-luatex}
\RequirePackage{layout/headings}
\RequirePackage{layout/page-margins,layout/head-foot}
\RequirePackage{toc/toc-ja}
\RequirePackage{boxstyle/hruled, boxstyle/plain, boxstyle/simpleboxed, boxstyle/westruled, boxstyle/proofstyle}
\RequirePackage{core/hyperlinks}

% --- 定理環境，数式・定理番号の設定 --- %
\mathtoolsset{showonlyrefs=true}% 数式環境の中で，のちに参照するもののみ番号を振る設定

\AtEndOfClass{%
    \makeatletter
    % --- 数式番号の設定 --- %
    \ifdefstring{\summary@eqnumbering}{section}{
        \numberwithin{equation}{section}
        \renewcommand{\theequation}{\thesection.\arabic{equation}}
    }{
    \ifdefstring{\summary@eqnumbering}{subsection}{
        \numberwithin{equation}{subsection}
        \renewcommand{\theequation}{\thesubsection.\arabic{equation}}
    }{
        \@ifundefined{c@equation}{\newcounter{equation}}{}
        \renewcommand{\theequation}{\arabic{equation}}
    }
    }
    % --- 定理番号・定理環境の設定 --- %
    \ifdefstring{\summary@thmnumbering}{section}{% if thmnumbering=section
        % 定義環境
        \newtcbtheorem[number within=section]{definition}{定義}{
            plain,
            separator sign ={.},
            fonttitle = \gtfamily\sffamily,
            before upper = {%
                \hspace*{-14pt}\myunderline[0.6pt]{\tcbtitle.}\;
            },
            before skip=12pt,
            after skip=12pt
        }{def} 
    }{
    \ifdefstring{\summary@thmnumbering}{subsection}{% if thmnumbering=subsection
        % 定義環境
        \newtcbtheorem[number within=subsection]{definition}{定義}{
            plain,
            separator sign = {.},
            fonttitle = \gtfamily\sffamily,
            before upper = {%
                \hspace*{-14pt}\myunderline[0.6pt]{\tcbtitle.}\;
            },
            before skip=12pt,
            after skip=12pt
        }{def}
    }{% else default
        \newtcbtheorem{definition}{定義}{
            plain,
            separator sign = {.},
            fonttitle = \gtfamily\sffamily,
            before upper = {
                \hspace*{-14pt}\myunderline[0.6pt]{\tcbtitle.}\;
            },
            before skip=12pt,
            after skip=12pt
        }{def}
    }
    }
    \makeatother

    % 定理環境の設定（定義環境は上ですでに設定済み）
    \newtcbtheorem[use counter from=definition]{theorem}{定理}{
        plain,
        separator sign ={.},
        fonttitle = \sffamily\gtfamily,
        before upper = {
            \hspace*{-14pt}\myunderline[0.6pt]{\tcbtitle.}\;
        },
        before skip=12pt,
        after skip=12pt
    }{thm}
    \newtcbtheorem[use counter from=definition]{lemma}{補題}{
        plain,
        separator sign ={.},
        fonttitle = \sffamily\gtfamily,
        before upper = {
            \hspace*{-14pt}\myunderline[0.6pt]{\tcbtitle.}\;
        }, 
        before skip=12pt,
        after skip=12pt
    }{lem}
    \newtcbtheorem[use counter from=definition]{corollary}{系}{
        plain,
        separator sign ={.},
        fonttitle = \sffamily\gtfamily,
        before upper = {
            \hspace*{-14pt}\myunderline[0.6pt]{\tcbtitle.}\;
        },
        before skip=12pt,
        after skip=12pt
    }{cor}
    \newtcbtheorem[use counter from=definition]{proposition}{命題}{
        plain,
        separator sign ={.},
        fonttitle = \sffamily\gtfamily,
        before upper = {
            \hspace*{-14pt}\myunderline[0.6pt]{\tcbtitle.}\;
        },
        before skip=12pt,
        after skip=12pt
    }{prop}
    \newtcbtheorem[use counter from=definition]{example}{例}{
        plain,
        separator sign ={.},
        fonttitle = \sffamily\gtfamily,
        before upper={
            \hspace*{-14pt}\myunderline[0.6pt]{\tcbtitle.}\;
        },
        before skip=12pt,
        after skip=12pt
    }{ex}
    \newtcolorbox{remark}{
        plain,
        fonttitle = \gtfamily\sffamily,
        before upper={
            \hspace*{-14pt}\myunderline[0.6pt]{\tcbtitle.}\;
        },
        title = 注意
    }
    \newtcolorbox{notation}{
        plain,
        fonttitle = \sffamily\gtfamily,
        before upper={
            \hspace*{-14pt}\myunderline[0.6pt]{\tcbtitle.}\;
        },
        title = 記法
    }

% --- 証明環境 --- %
\newcommand{\qedsymbol}{\scalebox{.5}[1]{\textcolor{gray}{$\blacksquare$}}}
    \newenvironment{myproof}{
        \vspace{-20pt}
        \begin{proofbox}[{\myunderline[0.3pt]{証明.}}]
    }{
        \qedsymbol\end{proofbox}
    }
}
