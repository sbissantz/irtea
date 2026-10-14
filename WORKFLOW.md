# Workflow cheatsheet

Run every command from the `irtea` folder unless noted otherwise.

## Where things live

| Folder | What it holds |
|---|---|
| `website/slides/` | Slide decks (`NN-topic.qmd`), shared slide settings (`_metadata.yml`), PDF settings (`beamer-header.tex`), images |
| `website/workbook/` | Workbook chapters (`NN-topic.qmd`) |
| `website/solutions/` | Solutions, one file per chapter. Own **private** git repo (`irtea-solutions`), ignored by `irtea` |
| `website/theme.scss` | Look of the website and workbook (font, colors) |
| `website/_quarto.yml` | Website settings and menus |
| `website/_site/` | Built public website (generated, not in git) |
| `website/_site-solutions/` | Built instructor version with solutions (generated, **never publish**) |
| `R/`, `data/`, `data-raw/`, `man/`, `tests/` | The R package |

## Look at the website while you edit

```bash
quarto preview website
```

- Opens the site in your browser and reloads it when you save a `.qmd` file.
- Stop it with `Ctrl+C`.
- Run **only one preview at a time**. Positron's Preview button also starts one.
- After changing `slides/_metadata.yml`, `beamer-header.tex`, `theme.scss`, or any
  `_quarto*.yml`, stop the preview and start it again. It does not pick up these files.

Your version with solutions:

```bash
quarto preview website --profile solutions
```

## Build everything once

```bash
quarto render website
```

- Takes about 30 seconds. Builds all pages, both slide formats (HTML and PDF), and the workbook.
- Open the PDF slides: `open website/_site/slides/01-intro.pdf`
- Instructor version: `quarto render website --profile solutions` (goes to `website/_site-solutions/`).

Only one slide deck:

```bash
quarto render website/slides/01-intro.qmd                 # HTML and PDF
quarto render website/slides/01-intro.qmd --to revealjs   # HTML only
quarto render website/slides/01-intro.qmd --to beamer     # PDF only
```

## Publish the website

1. Stop all previews (`Ctrl+C`, and Positron's preview).
2. Publish:

   ```bash
   quarto publish gh-pages website
   ```

3. Confirm with Enter. Quarto builds the public version (without solutions) and pushes
   it to the `gh-pages` branch.
4. After 1 to 2 minutes the site is live at <https://sbissantz.github.io/irtea/>.
   Reload the page if you still see the old version.

## Save your work with git

There are two repositories: `irtea` (public) and `website/solutions` (private).

```bash
git status                       # what changed
git add -A                       # stage everything
git commit -m "Describe change"  # commit
git push                         # upload to GitHub
```

For the solutions, run the same commands inside `website/solutions/`:

```bash
cd website/solutions
git add -A && git commit -m "Describe change" && git push
cd ../..
```

The very first push of the solutions repo needs `git push -u origin master` instead of
`git push` (it links the local branch to GitHub once).

## The R package

In R, from the `irtea` folder:

```r
devtools::document()  # update help pages after changing roxygen comments
devtools::test()      # run the tests
devtools::check()     # full package check (about 20 seconds)
source("data-raw/personality-items.R")  # rebuild the dataset
```

## Add new content

- **Slide deck:** `website/slides/NN-topic.qmd` with `title`, `subtitle`, `author`,
  `institute` in the header. The look comes from `slides/_metadata.yml` automatically.
- **Workbook chapter:** `website/workbook/NN-topic.qmd`. Exercises as
  `::: {#exr-short-name}` with a `## Title` inside.
- **Solutions:** `website/solutions/NN-topic.qmd`, link back with
  `[Zur Aufgabe](../workbook/NN-topic.qmd#exr-short-name)`.
- Add each new page to the menus in `website/_quarto.yml`
  (solutions in `website/_quarto-solutions.yml`).
- Slides: put content on `##` slides. Keep `#` headings (section slides) without text.
- File names: lowercase, words joined with `-`.

## When something goes wrong

| Symptom | Cause and fix |
|---|---|
| "Quarto Render Error" in the preview | Two Quarto processes are running. Stop all previews, start one again. |
| Publish fails with a "rename" error | A preview is running. Stop it, publish again. |
| Preview does not show a settings change | Restart the preview (see above). |
| Website unchanged after publishing | Wait 1 to 2 minutes, then reload the page. |
| Stray Quarto processes | `ps aux \| grep quarto` lists them; stop them with `kill <number>`. |
