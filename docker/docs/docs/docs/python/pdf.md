---
title: PDF
---

## Convert image to pdf
```python
import os, glob
import img2pdf

source_dir = "/Users/kahnwong/Downloads/album/"
dest_dir = '/Users/kahnwong/Dropbox/'

os.chdir(source_dir)
images = glob.glob('*.jpg')
filename = "Trip"

# multiple inputs (variant 2)
with open(filename + '.pdf',"wb") as f:
    f.write(img2pdf.convert(images))

print('Done')
```

## Merge pdf
```python
import os
from PyPDF2 import PdfFileReader, PdfFileMerger
import glob, os


"""List all files"""
os.chdir(PDF_PATH)
pdfs = glob.glob('*.pdf')

"""Merge"""
merger = PdfFileMerger()

filename = FILENAME

for pdf in pdfs:
    merger.append(PdfFileReader(os.path.join(pdf), "rb"))
merger.write(os.path.join(filename + ".pdf"))
```