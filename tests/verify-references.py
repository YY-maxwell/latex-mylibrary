#!/usr/bin/env python3
"""Compile the reference fixture across classes, engines, and numbering modes."""

import itertools
import os
from pathlib import Path
import re
import subprocess
import tempfile


ROOT = Path(__file__).resolve().parent.parent
SOURCE = (ROOT / "tests/references.tex.in").read_text()
TYPES = {
    "r:def": "definition",
    "r:thm": "theorem",
    "r:prop": "proposition",
    "r:lem": "lemma",
    "r:cor": "corollary",
    "r:ex": "example",
    "r:eq": "equation",
    "r:align": "equation",
    "r:tag": "equation",
    "r:row-used": "equation",
    "r:inner-equation": "equation",
    "r:inner-theorem": "theorem",
    "r:lem-two": "lemma",
    "r:lem-three": "lemma",
    "r:late": "lemma",
    "sec:first": "section",
    "sub:first": "subsection",
    "sec:second": "section",
}
ERRORS = re.compile(
    r"^!|undefined references|different types|Reference .*undefined|"
    r"destination with the same identifier|duplicate ignored", re.M | re.I
)


def main():
    env = os.environ.copy()
    env["TEXINPUTS"] = f"{ROOT / 'class'}//:{ROOT / 'style'}//:" + env.get("TEXINPUTS", "")
    failures = []
    with tempfile.TemporaryDirectory(prefix="mylib-references-") as temporary:
        work = Path(temporary)
        env["TEXMFVAR"] = str(work / "texmf-var")
        env["TEXMFCACHE"] = str(work / "texmf-var")
        cases = [
            (*case, False)
            for case in itertools.product(
                ("normal", "boxed", "jnormal", "jboxed"),
                ("xelatex", "lualatex"),
                ("separate", "shared"),
                ("global", "section", "subsection"),
            )
        ]
        cases.append(("normal", "xelatex", "separate", "section", True))
        for cls, engine, numbering, within, custom_fonts in cases:
            name = f"{cls}-{engine}-{numbering}-{within}"
            if custom_fonts:
                name += "-custom-fonts"
            font_settings = (
                r"\renewcommand{\mylibrefnamefont}[1]{\textbf{#1}}" + "\n"
                r"\renewcommand{\mylibrefnumberfont}[1]{\texttt{#1}}" + "\n"
                r"\renewcommand{\mylibequationtagfont}[1]{\textrm{#1}}"
                if custom_fonts else ""
            )
            tex = (
                SOURCE.replace("@CLASS@", cls)
                .replace("@NUMBERING@", numbering)
                .replace("@WITHIN@", within)
                .replace("@FONT_SETTINGS@", font_settings)
            )
            (work / f"{name}.tex").write_text(tex)
            for _ in range(3):
                result = subprocess.run(
                    [engine, "-interaction=nonstopmode", "-halt-on-error",
                     f"-output-directory={work}", str(work / f"{name}.tex")],
                    cwd=work, env=env, text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                )
                if result.returncode:
                    failures.append((name, result.stdout[-1200:]))
                    break
            else:
                log = (work / f"{name}.log").read_text(errors="replace")
                aux = (work / f"{name}.aux").read_text(errors="replace")
                if ERRORS.search(log):
                    failures.append((name, "reference error or warning in log"))
                for label, expected in TYPES.items():
                    pattern = rf"\\newlabel\{{{re.escape(label)}@cref\}}\{{\{{\[{expected}\]"
                    if not re.search(pattern, aux):
                        failures.append((name, f"wrong or missing type: {label} -> {expected}"))
                for label in ("r:unused", "r:row-unused"):
                    if f"\\newlabel{{{label}}}" in aux:
                        failures.append((name, f"unreferenced equation numbered: {label}"))
                prefix = {"global": "", "section": "1.", "subsection": "1.1."}[within]
                lemma_number = prefix + "4"
                equation_number = prefix + ("7" if numbering == "shared" else "1")
                for label, expected in (("r:lem", lemma_number), ("r:eq", equation_number)):
                    if "\\newlabel{" + label + "}{{" + expected + "}" not in aux:
                        failures.append((name, f"wrong number: {label} -> {expected}"))
                if not any(failure[0] == name for failure in failures):
                    print("PASS", name)
    for name, detail in failures:
        print("FAIL", name, detail[:400])
    raise SystemExit(bool(failures))


if __name__ == "__main__":
    main()
