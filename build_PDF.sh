#!/usr/bin/zsh
filename="PDF/thesis_"$(date "+%Y%m%d_%H%M%S")".pdf"
sed -r 's/^```(.+)/```{\1}/' thesis.Rmd > thesis.tmp.Rmd
ret=$(Rscript -e "knitr::knit('thesis.tmp.Rmd')" 2>&1) || { echo $ret; exit 1; }
sed -e '/^\!/N;s/\n:{/{/g' -e 's/\*\{3,\}/\\clearpage/g' thesis.tmp.md > thesis.md
#exec 2> >(awk '{print strftime("[%Y-%m-%d %H:%M:%S]"),$0 } { fflush() } ' >>pandoc.log)
/bin/time -f "Built in %es" pandoc thesis.md -o $filename -F pandoc-crossref -F pandoc-citeproc --top-level-division=chapter -s -N --pdf-engine=lualatex #--verbose
#/bin/time -f "Built in %es" pandoc thesis.tmp.md -o test.tex -F pandoc-crossref -F pandoc-citeproc --top-level-division=chapter -s -N
rm thesis.tmp.Rmd thesis.tmp.md thesis.md
