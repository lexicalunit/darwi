#!/bin/bash

set -exu

# convert journal to pdf
pandoc journal.md -s -o journal.pdf

# build darwi.pdf from base, book, and journal
pdftk \
    B=base.pdf \
    S=book.pdf \
    J=journal.pdf \
    cat B S2-end J \
    output darwi.pdf

# cleanup journal build artifacts
rm -f journal.pdf

# convert form fillable darwi.pdf to flattened image
pdf2ps "darwi.pdf" - | ps2pdf - "flat.pdf"
convert -resize 1100x -density 300 -quality 100 flat.pdf page.png
convert page-*.png -append all.png
convert all.png -background white -flatten flat.png
pngquant --nofs -s 2 --quality=100 flat.png -fo darwi.png

# cleanup image conversion artifacts
rm page-*.png flat.pdf all.png flat.png
