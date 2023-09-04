# PGRcode
R package holding code for "A Practical Guide to Data Analysis Using R"

To install the package, do 
```
remotes::install_github('jhmaindonald/PGRcode', build_vignettes=TRUE)
```

Individual code files or other vignette files can be downloaded thus:
```
vigdir <- "https://github.com/jhmaindonald/PGRcode/raw/main/vignettes/"
if(!file.exists('~/tmp2'))system('mkdir ~/tmp')
download.file(paste0(vigdir, 'ch1.Rmd'), '~/tmp/ch1.Rmd')
```

Or, go to https://github.com/jhmaindonald/PGRcode/blob/main/vignettes/,
click on file name on the far left, then on the far right of the
row that is immediately above the first line of the file, click on
the download symbol that is the second symbol across from __Raw__.
