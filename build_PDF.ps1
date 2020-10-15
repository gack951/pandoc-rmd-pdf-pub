Remove-Item .\tex2pdf* -r -force
$filename="PDF\thesis_"+$(Get-Date -Format yyyyMMdd_HHmmss)+".pdf"
# R Markdownを使わない場合はコメントアウト
Rscript -e "knitr::knit('thesis.Rmd')"
# Rmdのコードブロックにラベルを付ける。***を\clearpageに置換する。
$(Get-Content -Encoding UTF8 -Raw thesis.md) -replace "\r\n:\{", "{" -replace "\*{3,}", "\clearpage" | Set-Content -Encoding UTF8 thesis.tmp.md
Measure-Command {pandoc thesis.tmp.md -o $filename -F pandoc-crossref -F pandoc-citeproc --top-level-division=chapter -s -N --pdf-engine=lualatex} | ForEach-Object {"Built in $_"}
Remove-Item thesis.tmp.md, thesis.md
Invoke-Expression ".\$filename"