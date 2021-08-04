---
title: Pandoc
---

```bash
# HTML to MD
pandoc test.html -o test.md --parse-raw

MD to PDF
pandoc test.md -s -o test.pdf
pandoc -s sites_comparison.md -t html5 -o 'test.pdf'
pandoc -s sites_comparison.md -c pandoc.css -o 'test2.pdf'

# MD to EPUB
pandoc -S README -o README.epub
```