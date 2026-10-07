\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{jyboxed}[2025/09/18 定義環境は左隅に縦線, 定理環境は枠で囲まれる]


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


% --- 定理環境，数式・定理番号の設定 ---
\mathtoolsset{showonlyrefs=true}% 数式環境の中で，のちに参照するもののみ番号を振る設定
\AtEndOfClass{%
    \makeatletter
    % --- 数式番号の設定 ---%
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
    % 定義環境と番号
    \ifdefstring{\summary@thmnumbering}{section}{% if thmnumbering=section
        \newtcbtheorem[number within=section]{definition}{定義}{
            westruled,
            line color = black,
            separator sign none,
            fonttitle = \bfseries,
            before upper = {
                \tcbtitle\textbf{.}\;
            },
        }{def}
    }{
    \ifdefstring{\summary@thmnumbering}{subsection}{% if thmnumbering=subsection
        \newtcbtheorem[number within=subsection]{definition}{定義}{
            westruled,
            line color = black,
            separator sign none,
            fonttitle = \bfseries,
            before upper = {
                \tcbtitle\textbf{.}\;
            },
        }{def}
    }{%
        \newtcbtheorem{definition}{定義}{
            westruled,
            line color = black,
            separator sign none,
            fonttitle = \bfseries,
            before upper = {
                \tcbtitle\textbf{.}\;
            },
        }{def}
    }
    }
    \makeatother

    % 定理環境
    \newtcbtheorem[use counter from=definition]{theorem}{定理}{
        simpleboxed,
        separator sign ={.},
        fonttitle = \bfseries
    }{thm}
    \newtcbtheorem[use counter from=definition]{lemma}{補題}{
        simpleboxed,
        separator sign ={.},
        fonttitle = \bfseries
    }{lem}
    \newtcbtheorem[use counter from=definition]{corollary}{系}{
        simpleboxed,
        separator sign ={.},
        fonttitle = \bfseries
    }{cor}
    \newtcbtheorem[use counter from=definition]{proposition}{命題}{
        simpleboxed,
        separator sign ={.},
        fonttitle = \bfseries
    }{prop}
    \newtcbtheorem[use counter from=definition]{example}{例}{
        plain,
        separator sign ={.},
        fonttitle = \bfseries,
        before upper={
            \hspace*{-14pt}\myunderline[0.6pt]{\tcbtitle.}\;
        },
    }{ex}
    \newtcolorbox{remark}{
        plain,
        separator sign ={.},
        fonttitle = \bfseries,
        before upper={
            \hspace*{-14pt}\myunderline[0.6pt]{\tcbtitle.}\;
        },
        title = 注意
    }
    \newtcolorbox{notation}{
        plain,
        separator sign ={.},
        fonttitle = \bfseries,
        before upper={
            \hspace*{-14pt}\myunderline[0.6pt]{\tcbtitle.}\;
        },
        title = 記法
    }

% --- 証明環境 --- %
\newcommand{\qedsymbol}{\scalebox{.5}[1]{\textcolor{gray}{$\blacksquare$}}}
    \newenvironment{myproof}{
        \begin{proofbox}[\textgt{\textsf{証明.}}]
    }{
        \qedsymbol\end{proofbox}
    }
}
