#!/usr/bin/env python3
"""Check that equation numbers follow edits to references across aux-file runs."""

import os
from pathlib import Path
import re
import subprocess
import tempfile


ROOT = Path(__file__).resolve().parent.parent
BASE = r"""\documentclass{normal}
\begin{document}
\section{Changes}
\begin{equation}\label{eq:first}a=b\end{equation}
\begin{equation}\label{eq:second}b=c\end{equation}
@REFERENCES@
\end{document}
"""
ERRORS = re.compile(r"^!|undefined references|Reference .*undefined|duplicate ignored", re.M | re.I)


def main():
    env = os.environ.copy()
    env["TEXINPUTS"] = f"{ROOT / 'class'}//:{ROOT / 'style'}//:" + env.get("TEXINPUTS", "")
    with tempfile.TemporaryDirectory(prefix="mylib-autonum-changes-") as directory:
        work = Path(directory)
        source = work / "changes.tex"
        for reference, expected in (
            ("", set()),
            (r"\eqref{eq:first}", {"eq:first"}),
            (r"\Cref{eq:second}", {"eq:second"}),
            ("", set()),
        ):
            source.write_text(BASE.replace("@REFERENCES@", reference))
            for _ in range(3):
                result = subprocess.run(
                    ["xelatex", "-interaction=nonstopmode", "-halt-on-error",
                     f"-output-directory={work}", str(source)],
                    cwd=work, env=env, text=True, capture_output=True,
                )
                if result.returncode:
                    raise RuntimeError(result.stdout[-1500:])
            aux = (work / "changes.aux").read_text()
            log = (work / "changes.log").read_text(errors="replace")
            if ERRORS.search(log):
                raise AssertionError(f"warning after {reference!r}")
            actual = {
                label for label in ("eq:first", "eq:second")
                if f"\\newlabel{{{label}}}" in aux
            }
            if actual != expected:
                raise AssertionError(f"{reference!r}: expected {expected}, got {actual}")
            print("PASS", reference or "no references", sorted(actual))


if __name__ == "__main__":
    main()
