# pandoc+LuaLaTeXでR MarkdownからPDF作成(卒論/修論向け)

## 概要
RやPythonなどの実行結果を文書に埋め込むことができるR Markdownから、pandocとLuaLaTeXでPDFを作成するスクリプトとサンプル文書です。WindowsとLinux(テスト環境はDebian 10)でのコンパイルに対応しています。

## Windowsの場合
### インストールが必要なもの
- Visual Studio Code
https://azure.microsoft.com/ja-jp/products/visual-studio-code/
- pandoc
https://pandoc.org/installing.html
- pandoc-crossref
https://github.com/lierdakil/pandoc-crossref/releases/
- R (R Markdown)
https://cran.r-project.org/bin/windows/base/
    - `R > install.packages('knitr')`
    - Pathに `C:\Program Files\R\R-3.6.2\bin\x64` を追加
    - TeX Liveのfullを入れない場合(推奨)
        - `R > install.packages(c('knitr','tinytex','rmarkdown','ggsci','reticulate'))`
        - `R > tinytex::install_tinytex()`
        - `R > tinytex::tlmgr_install(c("luatexja","ms","ipaex","filehook","unicode-math","lualatex-math","xcolor","mdwtools","subfig","epstopdf-pkg"))`
        - Pathに `C:\Users\(UserName)\AppData\Roaming\TinyTeX\bin\win32` を追加
- TeX Live (非推奨)
https://texwiki.texjp.org/?TeX%20Live%2FWindows
    - Pathに `C:\texlive\2019\bin\win32` を追加
- モリサワフォント
モリサワフォントを使いたい場合は、`A-OTF-RyuminPr6N-Light.otf`と`A-OTF-GothicBBBPr6N-Medium.otf`をインストール

### 設定が必要なもの
- `PS > Set-ExecutionPolicy -ExecutionPolicy Bypass`

### 実行方法
1. 参考文献をBibLaTeX形式で出力
1. `PS > .\build_PDF.ps1`

## Linuxの場合
### インストールが必要なもの
- pandoc
https://pandoc.org/installing.html
- pandoc-crossref
https://github.com/lierdakil/pandoc-crossref/releases/
- R (R Markdown)
https://cran.r-project.org/bin/windows/base/
    - 以下のRは通常ユーザで実行し、個人ワークスペースに保存する
    - `R > install.packages(c('knitr','tinytex','rmarkdown','ggsci','reticulate'))`
    - `R > tinytex::install_tinytex()`
    - `R > tinytex::tlmgr_install(c("luatexja","ms","ipaex","filehook","unicode-math","lualatex-math","xcolor","mdwtools","subfig","epstopdf-pkg","caption"))`
    - Pathに追加 `export PATH=$PATH:~/.TinyTeX/bin/x86_64-linux`
- 原ノ味フォント (使われないがluatexjaのロード時に無いと失敗する)
    - https://www.ctan.org/pkg/haranoaji をダウンロードし、otfファイルを `~/.TinyTeX/texmf-local/fonts/opentype/public/haranoaji/` に移動
- TimesNewRoman
    - `times.ttf, timesbd.ttf, timesbi.ttf, timesi.ttf` をWindowsから `~/.TinyTeX/texmf-local/fonts/truetype/public/TimesNewRoman/` にコピー
    - `mktexlsr`
- モリサワフォント
    - モリサワフォントを使いたい場合は、`A-OTF-RyuminPr6N-Light.otf`と`A-OTF-GothicBBBPr6N-Medium.otf`を`~/.TinyTeX/texmf-local/fonts/opentype/public/morisawa/`にインストール

### 実行方法
`$ build_PDF.sh`