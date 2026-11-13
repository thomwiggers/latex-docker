#!/bin/sh
# Smoke test run inside a freshly built image: check that the tools the image
# promises are there and that a small document with a bibliography compiles
# with both pdfLaTeX and LuaLaTeX.
set -eu

for tool in pdflatex lualatex biber make git python3 gs; do
    command -v "$tool" >/dev/null || { echo "missing: $tool" >&2; exit 1; }
done
python3 -c 'import numpy, matplotlib'

work=$(mktemp -d)
cd "$work"

cat > refs.bib <<'BIB'
@article{knuth84,
  author  = {Donald E. Knuth},
  title   = {Literate Programming},
  journal = {The Computer Journal},
  year    = {1984},
}
BIB

cat > smoke.tex <<'TEX'
\documentclass{article}
\usepackage{amsmath}
\usepackage{tikz}
\usepackage{booktabs}
\usepackage[backend=biber]{biblatex}
\addbibresource{refs.bib}
\begin{document}
Hello \(e^{i\pi} + 1 = 0\) \cite{knuth84}.
\begin{tikzpicture}\draw (0,0) circle (1);\end{tikzpicture}
\printbibliography
\end{document}
TEX

run() {
    engine=$1
    mkdir "out-$engine"
    "$engine" -interaction=nonstopmode -halt-on-error -output-directory="out-$engine" smoke.tex
    biber --input-directory="out-$engine" --output-directory="out-$engine" smoke
    "$engine" -interaction=nonstopmode -halt-on-error -output-directory="out-$engine" smoke.tex
    test -s "out-$engine/smoke.pdf"
}
run pdflatex
run lualatex
echo "smoke test passed"
