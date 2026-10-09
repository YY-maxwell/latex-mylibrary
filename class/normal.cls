\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{normal}[2026/10/08 Minimal amsthm-based class]

% Forward article options such as twoside while keeping the class extensible.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

\RequirePackage{core/packages}
\RequirePackage{core/macros}
\RequirePackage{amsthm}
\RequirePackage{layout/page-margins}
\RequirePackage{layout/head-foot}
\RequirePackage{toc/toc-eng}

% Numbered theorem-like environments share one counter and are reset by section.
\theoremstyle{definition}
\newtheorem{definition}{Definition}[section]
\newtheorem{example}[definition]{Example}

\theoremstyle{plain}
\newtheorem{theorem}[definition]{Theorem}
\newtheorem{proposition}[definition]{Proposition}
\newtheorem{lemma}[definition]{Lemma}
\newtheorem{corollary}[definition]{Corollary}

\theoremstyle{remark}
\newtheorem*{remark}{Remark}
\newtheorem*{notation}{Notation}

\RequirePackage{core/hyperlinks}

\endinput
