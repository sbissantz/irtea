# Workflow cheatsheet

Run every command from the `irtea` folder unless noted otherwise.

## Where things live

| Folder | What it holds |
|---|---|
| `website/slides/` | Slide decks (`topic-inp.qmd`), shared slide settings (`_metadata.yml`), PDF settings (`beamer-header.tex`), images |
| `website/workbook/` | Workbook chapters (`topic-ex.qmd`), with hints and results in fold-out boxes |
| `website/theme.scss` | Look of the website and workbook (font, colors) |
| `website/_quarto.yml` | Website settings and menus |
| `website/_site/` | Built website (generated, not in git) |
| `R/`, `data/`, `data-raw/`, `man/`, `tests/` | The R package |

## Look at the website while you edit

```bash
quarto preview website
```

- Opens the site in your browser and reloads it when you save a `.qmd` file.
- Stop it with `Ctrl+C`.
- Run **only one preview at a time**. Positron's Preview button also starts one.
- After changing `slides/_metadata.yml`, `beamer-header.tex`, `theme.scss`, or any
  `_quarto.yml`, stop the preview and start it again. It does not pick up these files.

## Build everything once

```bash
quarto render website
```

- Takes about 30 seconds. Builds all pages, both slide formats (HTML and PDF), and the workbook.
- Open the PDF slides: `open website/_site/slides/basics-inp.pdf`

Only one slide deck:

```bash
quarto render website/slides/basics-inp.qmd                 # HTML and PDF
quarto render website/slides/basics-inp.qmd --to revealjs   # HTML only
quarto render website/slides/basics-inp.qmd --to beamer     # PDF only
```

## Publish the website

1. Stop all previews (`Ctrl+C`, and Positron's preview).
2. Publish:

   ```bash
   quarto publish gh-pages website
   ```

3. Confirm with Enter. Quarto builds the site and pushes it to the `gh-pages` branch.
4. After 1 to 2 minutes the site is live at <https://sbissantz.github.io/irtea/>.
   Reload the page if you still see the old version.

GitHub Pages always gets the whole site; single pages cannot be published. After
changing only one page, render that page and publish without rebuilding the rest:

```bash
quarto render website/slides/basics-inp.qmd
quarto publish gh-pages website --no-render
```

`--no-render` uploads `website/_site` as it is, so everything rendered locally goes
online.

### Keep unreleased sessions offline

- **Workbook chapter:** add `draft: true` to the header. With `draft-mode: gone` in
  `_quarto.yml`, the published page stays empty; menu entries and links remain. The
  local preview still shows the full chapter. To release: delete the line, render,
  publish.
- **Slide deck:** drafts do not work for slides (HTML and PDF are rendered anyway).
  Start the file name with an underscore (`slides/_irt-inp.qmd`) and add no menu entry
  yet; Quarto ignores such files completely. To release: rename the file (also its
  `pdf-link:`), add the menu entry in `_quarto.yml`, render, publish.
- Do not link to an underscore deck from a published page: a link to a page that is
  not rendered makes Quarto copy its source file into the site.

## Save your work with git

```bash
git status                       # what changed
git add -A                       # stage everything
git commit -m "Describe change"  # commit
git push                         # upload to GitHub
```

## The R package

In R, from the `irtea` folder:

```r
devtools::document()  # update help pages after changing roxygen comments
devtools::test()      # run the tests
devtools::check()     # full package check (about 20 seconds)
source("data-raw/personality-items.R")  # rebuild the dataset
```

## Add new content

- **Slide deck:** `website/slides/topic-inp.qmd` with `title`, `subtitle`, `author`,
  `institute` and `pdf-link: topic-inp.pdf` in the header (the HTML title slide links
  the PDF). The look comes from `slides/_metadata.yml` automatically. Add the HTML
  deck to the Folien menu in `_quarto.yml`.
- **Workbook chapter:** `website/workbook/topic-ex.qmd`. Exercises as
  `::: {#exr-short-name}` with a `## Title` inside, parts as `a.`, `b.`, ... After each
  part a collapsed solution box (result only, no steps); hints in a collapsed box where
  needed:

  ```markdown
  ::: {#exr-short-name}
  ## Title

  Intro text.

  ::: {.callout-note title="Hinweis" collapse="true"}
  Hints for the students.
  :::

  a.  First part.

  ::: {.callout-tip title="Lösung" collapse="true"}
  Result of part a
  :::

  b.  Second part.

  ::: {.callout-tip title="Lösung" collapse="true"}
  Result of part b
  :::
  :::
  ```

- Add each new page to the menus in `website/_quarto.yml`.
- Slides: put content on `##` slides. Keep `#` headings (section slides) without text.
- File names: lowercase, words joined with `-`.

## When something goes wrong

| Symptom | Cause and fix |
|---|---|
| "Quarto Render Error" in the preview | Two Quarto processes are running. Stop all previews, start one again. |
| Publish fails with a "rename" error | A preview is running. Stop it, publish again. |
| Preview does not show a settings change | Restart the preview (see above). |
| Website unchanged after publishing | Wait 1 to 2 minutes, then reload the page. |
| Diagram text not in Fira Sans | Fira Sans is not installed. Copy `FiraSans-*.otf` from `/usr/local/texlive/2026/texmf-dist/fonts/opentype/public/fira/` to `~/Library/Fonts`, then render again. |
| Stray Quarto processes | `ps aux \| grep quarto` lists them; stop them with `kill <number>`. |
