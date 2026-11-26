#!/usr/bin/env python3
"""Check each supported reference command independently, including stars and lists."""

import os
from pathlib import Path
import subprocess
import tempfile


ROOT = Path(__file__).resolve().parent.parent
SOURCE = r"""\documentclass{normal}
\begin{document}
\begin{equation}\label{eq:first}a=b\end{equation}
\begin{equation}\label{eq:second}b=c\end{equation}
@REFERENCE@
\end{document}
"""


def main():
    env = os.environ.copy()
    env["TEXINPUTS"] = f"{ROOT / 'class'}//:{ROOT / 'style'}//:" + env.get("TEXINPUTS", "")
    cases = [
        (rf"\{name}{star}{{eq:first}}", ("eq:first",))
        for name in ("cref", "Cref", "labelcref", "ref", "eqref")
        for star in ("", "*")
    ]
    cases += [
        (rf"\{name}{star}{{eq:first,eq:second}}", ("eq:first", "eq:second"))
        for name in ("cref", "Cref", "labelcref")
        for star in ("", "*")
    ]
    with tempfile.TemporaryDirectory(prefix="mylib-autonum-commands-") as directory:
        work = Path(directory)
        for index, (reference, labels) in enumerate(cases):
            source = work / f"command-{index}.tex"
            source.write_text(SOURCE.replace("@REFERENCE@", reference))
            for _ in range(3):
                result = subprocess.run(
                    ["xelatex", "-interaction=nonstopmode", "-halt-on-error",
                     f"-output-directory={work}", str(source)],
                    cwd=work, env=env, text=True, capture_output=True,
                )
                if result.returncode:
                    raise RuntimeError(f"{reference}: {result.stdout[-1500:]}")
            aux = (work / f"command-{index}.aux").read_text()
            log = (work / f"command-{index}.log").read_text(errors="replace")
            if "undefined references" in log.lower() or "duplicate ignored" in log.lower():
                raise AssertionError(f"reference warning: {reference}")
            for label in ("eq:first", "eq:second"):
                numbered = f"\\newlabel{{{label}}}" in aux
                if numbered != (label in labels):
                    raise AssertionError(f"{reference}: wrong numbering for {label}")
            print("PASS", reference)


if __name__ == "__main__":
    main()
