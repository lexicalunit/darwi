#!/bin/bash

pandoc journal.md -s -o journal.pdf

pdftk \
    B=base.pdf \
    S=book.pdf \
    J=journal.pdf \
    cat B S2-end J \
    output darwi.pdf

rm -f journal.pdf
