# irtea

Teaching material for B.F.3 "Übung zu Diagnostik/Testtheorie" (RPTU): an R package and a
Quarto website with slides and a workbook. Commands: `WORKFLOW.md`. Paths below are under
`website/`, except the R package folders.

## Structure and language

- `slides/topic-inp.qmd`: input decks, rendered to HTML (revealjs) and PDF (beamer).
- `workbook/topic-ex.qmd`: workbook chapters (exercises), solutions included (results
  only).
- `R/`, `data/`, `data-raw/`, `man/`, `tests/`: the R package.
- Content in German; code, comments and file names in American English. File names
  lowercase, words joined with `-`.
- Numbers: decimal point, also in German text (`0.5`; decimal commas break LaTeX math).
  Vector entries separated by commas: `(1.5, 0.5)^\top`. Round to two decimal places.
- German quotation marks: „…“.
- German abbreviations take a narrow no-break space (U+202F) between their parts:
  `z. B.`, `d. h.`, `u. a.` (pandoc turns it into `\,` in the PDF).

## Look

One look, Moloch, in all outputs. The PDF is the reference; the HTML copies it.
Change the look only in these files:

- PDF: `slides/_metadata.yml` (`format: beamer`) and `slides/beamer-header.tex`. Theme
  `moloch` (`progressbar=frametitle`, `titlepage=moloch`), `classoption: [t]`,
  `fontsize: 12pt`, `section-titles: false`, Fira Sans Light (text) and Fira Sans
  (titles), logo `slides/images/bf3-logo.png` at 2.5 cm, page numbers "n / N".
- HTML slides: CSS in `slides/_metadata.yml` (`format: revealjs`). The title slide's
  sizes are measured from the PDF; measure again if the PDF title page changes.
- PDF link: the HTML title slide links the PDF via `pdf-link:` in the deck header
  (partial `slides/title-slide.html`); the Folien menu lists only the HTML decks.
- Website and workbook: `theme.scss` (layer on `cosmo`).

Colors: dark `#23373b` (title bar, text, navbar, solution boxes), accent `#eb811b`
(progress line, underlines, hint boxes, formula highlight), links `#b5620d`, light
lines `#d6dadb`.

## Slides

- Content on `##` slides; `#` section slides have no text of their own (otherwise HTML
  and PDF differ).
- List spacing is set globally; do not override it.
- Callouts only for hints and notes.
- After a layout change, render both formats and check that nothing overflows.

## Workbook

- Exercise: `::: {#exr-name}` with a `## Title` inside, no box around it. Do not rename
  `#exr-` anchors; the slides link to them.
- Parts `a.`, `b.`, ... (not `a)`, which editors flag as an unmatched parenthesis); in
  text "Teil b".
- After each part: `::: {.callout-tip title="Lösung" collapse="true"}` with the result
  only, no steps.
- Hints: `::: {.callout-note title="Hinweise" collapse="true"}`.

## Bibliography (APA 7)

- References in `references.bib`, style `apa.csl`; both set in `_quarto.yml`.
- Cite with `[@key]` or `@key` (e.g. `[@moosbrugger2020, S. 16]`), never by hand. The
  list appears at `::: {#refs}` (in decks on the `## Literatur` slide).
- New entries: BibTeX export from Zotero, or by DOI from Crossref
  (`curl -sLH "Accept: application/vnd.citationstyles.csl+json" https://doi.org/<DOI>`).
  Key like `moosbrugger2020`, `langid = {german}` for German titles. Crossref's own
  BibTeX lacks editors and edition; take the edition from the publisher's page.

## Figures: viridis

- All plots and figures use viridis: `viridisLite::viridis(n)`, in ggplot2
  `scale_*_viridis_*()`. Hex: `#440154`, `#3B528B`, `#21908C`, `#5DC863`, `#FDE725`;
  white text on the first three, `#23373b` on the last two.
- Mermaid template (the `init` line keeps labels from being cut off, sets the slide
  font and replaces the white box behind the diagram in the PDF):

  ```
  %%| fig-width: 5
  %%{init: {"htmlLabels": false, "flowchart": {"htmlLabels": false}, "themeVariables": {"fontFamily": "Fira Sans"}, "themeCSS": "background-color: #fafafa;"}}%%
  flowchart LR
    classDef step fill:#3B528B,stroke:#3B528B,color:#fff
    classDef done fill:#5DC863,stroke:#5DC863,color:#23373b
  ```

  Rectangle nodes (`id["Text"]`); no `accDescr`/`accTitle` (breaks the HTML slides).
- Mermaid renders in headless Chrome, which needs Fira Sans as a system font: copy
  `FiraSans-*.otf` from TeX Live's `fonts/opentype/public/fira/` to `~/Library/Fonts`.

## Working rules

- Only one Quarto preview or render at a time.
- Ask before committing, pushing or publishing.
- `devtools::document()`, `devtools::test()` and `devtools::check()` stay clean.
