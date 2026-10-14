# irtea

Teaching material for B.F.3 "Übung zu Diagnostik/Testtheorie" (RPTU): an R package
(datasets, later functions) plus a Quarto website with slides and a workbook.
Commands for preview, render, publish, and git: see `WORKFLOW.md`.

## Structure

- `website/slides/NN-topic.qmd`: slide decks, each rendered to HTML (revealjs) and PDF (beamer).
- `website/workbook/NN-topic.qmd`: workbook chapters.
- `website/solutions/NN-topic.qmd`: solutions. Private repo, ignored by this repo.
  Never copy solution content into public files.
- `R/`, `data/`, `data-raw/`, `man/`, `tests/`: the R package.
- Content (slides, workbook, site text) is German. Code, comments, and file names are
  American English. File names: lowercase, words joined with `-`.

## Look (do not change per deck or page)

All decks share one look, Moloch, in both formats. Set it only in these files:

- PDF: `website/slides/_metadata.yml` (`format: beamer`) and `website/slides/beamer-header.tex`.
  Theme `moloch` with `progressbar=frametitle`, `titlepage=plain`; `classoption: [t]`
  (top-aligned frames); `fontsize: 12pt`; `section-titles: false` (Moloch draws the section pages).
  Font Fira Sans Light (text) and Fira Sans (titles). Logo `images/rptu-logo.png`, 3 cm,
  centered at the bottom of the title page. Page numbers "n / N".
- HTML slides: `website/slides/_metadata.yml` (`format: revealjs`, CSS in `include-in-header`).
  Mirrors the PDF: Fira Sans, dark title bar with orange progress line, section slides with
  title over a progress line, centered title slide with orange underline and logo at the bottom.
- Website and workbook: `website/theme.scss` (Bootstrap layer on `cosmo`).

Colors (the same four everywhere):

| Role | Hex |
|---|---|
| Dark (title bar, text, navbar) | `#23373b` |
| Accent (progress line, underlines) | `#eb811b` |
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
- Anchors (`#exr-...`) are link targets from the slides; do not rename them.

## Bibliography (APA 7)

- All references live in `website/references.bib` (export from Zotero as BibTeX).
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

- Mermaid settings that must stay: `%%| fig-width: 5` and
  `%%{init: {"htmlLabels": false}}%%` at the top of each diagram; `flowchart LR`
  fits 16:9 slides best. Do not use `accDescr`/`accTitle` (it breaks the HTML slides).

## Working rules

- Run only one Quarto preview or render at a time; two processes break each other.
- Never publish `website/_site-solutions/` (instructor build with solutions).
- Ask before committing, pushing, or publishing.
- Package: `devtools::document()`, `devtools::test()`, `devtools::check()` must stay clean.
