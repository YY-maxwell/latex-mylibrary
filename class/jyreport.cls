\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{jyreport}[2025/05/10 Simple Japanese class for report]

\LoadClass{jlreq}

% --- 基本パッケージ ---
\RequirePackage{etoolbox}
\RequirePackage{core/packages}
\RequirePackage{fonts/math-newcm-euler}
\RequirePackage{core/macros}
\RequirePackage{fonts/japanese-luatex}
\RequirePackage{layout/headings}
\RequirePackage{layout/page-margins}
\RequirePackage{toc/toc-ja}
\RequirePackage{boxstyle/hruled, boxstyle/plain, boxstyle/simpleboxed, boxstyle/westruled, boxstyle/proofstyle}
\RequirePackage{core/hyperlinks}


% --- 数式設定 ---
\mathtoolsset{showonlyrefs=true}% 数式環境の中で，のちに参照するもののみ番号を振る設定


% --- ヘッダーとフッター ---
\RequirePackage{fancyhdr}% package for custom headers/footers
\RequirePackage{etoolbox}% required to use \patchcmd
% === Header layout: section name on the left, subsection name on the right, page number at the bottom ===
% Redefine \sectionmark to remove \MakeUppercase and \subsectionmark to display subsection name in the right header
\makeatletter
\pagestyle{fancy}%
\fancyhf{}%
\fancyhead[L]{\@title}
\fancyhead[R]{\@author}
\fancyfoot[C]{\thepage}%
\renewcommand{\headrulewidth}{0.3pt}%
\setlength{\headheight}{18pt}% with 20truemm margins, LaTeX warns that head height is too small
\setlength{\headwidth}{\textwidth}%
\makeatother
\AddToHook{cmd/maketitle/after}{\thispagestyle{empty}}% タイトルがある1ページ目だけヘッダーなし

% --- titleとauthorの位置 ---
\makeatletter
\renewcommand{\maketitle}{
    \noindent
    \begin{minipage}[t]{0.6\textwidth}
        \raggedright
        \textbf{\LARGE \@title}
    \end{minipage}%
    \begin{minipage}[t]{0.4\textwidth}
        \raggedleft
        \textbf{\large \@author}
    \end{minipage}
    \vspace{2em}
    }
\makeatother


% --- Problem environment ---
\newtcolorbox{problem}[1][\textbf{問題}]{
    westruled,
    % colback = black!5!white,
    line color = gray,
    title={#1},
    separator sign none,
    before upper = {
        \tcbtitle
    }
}
