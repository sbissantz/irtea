# irtea

Teaching material for B.F.3 "Übung zu Diagnostik/Testtheorie" (RPTU): an R package
(datasets, later functions) plus a Quarto website with slides and a workbook.
Commands for preview, render, publish, and git: see `WORKFLOW.md`.

## Structure

- `website/slides/NN-topic.qmd`: slide decks, each rendered to HTML (revealjs) and PDF (beamer).
- `website/workbook/NN-topic.qmd`: workbook chapters, including the solutions
  (results only, see workbook rules). There are no separate or private solution files.
- `R/`, `data/`, `data-raw/`, `man/`, `tests/`: the R package.
- Content (slides, workbook, site text) is German. Code, comments, and file names are
  American English. File names: lowercase, words joined with `-`.
- Numbers use a decimal point, also in German text and math (`0.5`, not `0,5` or
  `0{,}5`): decimal commas are awkward in LaTeX. Separate vector entries with commas,
  e.g. `(1.5, 0.5)^\top`. Round data and results to two decimal places.
- German quotation marks: „…“ (closing mark U+201C, not a straight `"`).

## Look (do not change per deck or page)

All decks share one look, Moloch, in both formats. The PDF (beamer theme Moloch) is the
reference; the HTML copies it. Set the look only in these files:

- PDF: `website/slides/_metadata.yml` (`format: beamer`) and `website/slides/beamer-header.tex`.
  Theme `moloch` with `progressbar=frametitle`, `titlepage=moloch`; `classoption: [t]`
  (top-aligned frames); `fontsize: 12pt`; `section-titles: false` (Moloch draws the section pages).
  Font Fira Sans Light (text) and Fira Sans (titles). Course logo `images/bf3-logo.png`
  (transparent PNG), 2.5 cm, above the title. Page numbers "n / N".
- HTML slides: `website/slides/_metadata.yml` (`format: revealjs`, CSS in `include-in-header`).
  Mirrors the PDF: Fira Sans, dark title bar with orange progress line, section slides with
  title over a progress line, and the Moloch title page (left-aligned, logo on top, orange
  line between subtitle and authors). Title slide sizes and gaps are measured from the PDF;
  if the PDF title page changes, measure again.
- Website and workbook: `website/theme.scss` (Bootstrap layer on `cosmo`).

Colors (the same four everywhere):

| Role | Hex |
|---|---|
| Dark (title bar, text, navbar) | `#23373b` |
| Accent (progress line, underlines, note boxes, formula highlight on click) | `#eb811b` |
| Links | `#b5620d` |
| Track / light lines | `#d6dadb` |

Slide rules:

- Content goes on `##` slides. `#` headings (section slides) carry no text of their own,
  otherwise HTML and PDF differ.
- Lists: half a line between all items, also before a sublist (already set; do not override).
- Boxes are Quarto callouts (`::: {.callout-note}` etc.) for hints and notes only.
- After any layout change, render both formats and check that nothing overflows a slide.

Workbook rules:

- Exercises: `::: {#exr-short-name}` with a `## Title` inside; no boxes around exercises.
- Parts as `a.`, `b.`, ... (not `a)`: editors flag the lone parenthesis as unmatched).
  Refer to a part in text as "Teil b".
- Inside each exercise, at its end, both collapsed (students unfold them):
  - hints: `::: {.callout-note title="Hinweise" collapse="true"}` (orange);
  - solution: `::: {.callout-tip title="Lösung" collapse="true"}` (dark), results only,
    one line per part, no solution steps.
- Anchors (`#exr-...`) are link targets from the slides; do not rename them.

## Bibliography (APA 7)

- All references live in `website/references.bib` (export from Zotero as BibTeX).
- Entries with a DOI can come from Crossref:
  `curl -sLH "Accept: application/vnd.citationstyles.csl+json" https://doi.org/<DOI>`.
  Build the BibTeX entry from that output (key like `moosbrugger2020`, `langid = {german}`
  for German titles). Crossref's own BibTeX lacks editors and edition; take the edition
  from the publisher's page.
- Style: `website/apa.csl` (APA 7th edition), set once in `website/_quarto.yml`
  together with `bibliography:`. Applies to website, HTML slides, and PDF.
- Cite with `[@key]` or `@key` (e.g. `[@moosbrugger2020, S. 16]`); never write
  references or citations by hand.
- The reference list appears where `::: {#refs}` / `:::` is placed (on decks: on the
  `## Literatur` slide).

## Figures and plots: viridis

- Use the viridis palette for all plots and figures.
  - R base graphics: `viridisLite::viridis(n)`.
  - ggplot2: `scale_color_viridis_d()`, `scale_fill_viridis_c()`, etc.
- Viridis hex values (5 steps): `#440154`, `#3B528B`, `#21908C`, `#5DC863`, `#FDE725`.
  Use white text on the first three, `#23373b` text on the last two.
- Mermaid diagrams use the same colors via `classDef`, for example:

  ```
  classDef step fill:#3B528B,stroke:#3B528B,color:#fff
  classDef done fill:#5DC863,stroke:#5DC863,color:#23373b
  ```

- Mermaid settings that must stay at the top of each diagram: `%%| fig-width: 5` and
  `%%{init: {"htmlLabels": false, "flowchart": {"htmlLabels": false}, "themeVariables": {"fontFamily": "Fira Sans"}, "themeCSS": "background-color: #fafafa;"}}%%`
  (SVG text instead of HTML labels, which get cut off; same font as the slides; slide
  background color, otherwise the PDF shows a white rectangle behind the diagram).
  `flowchart LR` fits 16:9 slides best. Nodes are rectangles (`id["Text"]`).
  Do not use `accDescr`/`accTitle` (it breaks the HTML slides).
- Diagrams are drawn in headless Chrome, which only sees system fonts: Fira Sans must be
  installed on the machine that renders (free; copy `FiraSans-*.otf` from TeX Live's
  `fonts/opentype/public/fira/` to `~/Library/Fonts`). Otherwise diagrams use another font.

## Working rules

- Run only one Quarto preview or render at a time; two processes break each other.
- Ask before committing, pushing, or publishing.
- Package: `devtools::document()`, `devtools::test()`, `devtools::check()` must stay clean.
