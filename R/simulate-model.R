#' Mittelwerte und Kovarianzmatrix eines Messmodells erzeugen
#'
#' Erzeugt Mittelwerte und Kovarianzmatrix von Items, die einem der fünf
#' Messmodelle der Klassischen Testtheorie folgen. Die Parameter (Mittelwerte,
#' Kovarianzen bzw. Ladungen, Fehlervarianzen) werden bei jedem Aufruf neu
#' gezogen; mit [set.seed()] lassen sich die Werte reproduzieren.
#'
#' Ohne `n` gibt die Funktion die exakten modellimplizierten Werte zurück, wie
#' in den Tabellen der Vorlesung. Mit `n` simuliert sie eine Stichprobe dieser
#' Größe und gibt deren Mittelwerte und Kovarianzmatrix zurück; dann gelten
#' die Muster des Modells nur noch ungefähr.
#'
#' Die Modelle zeigen sich so in den Werten:
#'
#' | Modell | Mittelwerte | Varianzen | Kovarianzen |
#' |---|---|---|---|
#' | `"parallel"` | gleich | gleich | gleich |
#' | `"essentially_parallel"` | verschieden | gleich | gleich |
#' | `"tau_equivalent"` | gleich | verschieden | gleich |
#' | `"essentially_tau_equivalent"` | verschieden | verschieden | gleich |
#' | `"tau_congeneric"` | verschieden | verschieden | verschieden |
#'
#' @param model Messmodell, eines von `"parallel"`, `"essentially_parallel"`,
#'   `"tau_equivalent"`, `"essentially_tau_equivalent"` und
#'   `"tau_congeneric"`.
#' @param n_items Anzahl der Items, 3 bis 6.
#' @param n Stichprobengröße. `NULL` (Voreinstellung) gibt die exakten
#'   modellimplizierten Werte zurück.
#'
#' @return Eine Liste der Klasse `measurement_model` mit den Elementen
#'   `model`, `means` (Mittelwerte), `cov` (Kovarianzmatrix) und `n`; bei
#'   simulierten Werten zusätzlich `data` (die simulierten Antworten). Die
#'   Ausgabe zeigt nur Mittelwerte und Kovarianzmatrix, nicht das Modell.
#'
#' @seealso [play_roulette()] zum Üben.
#' @examples
#' set.seed(1)
#' simulate_model("tau_equivalent", n_items = 4)
#'
#' # simulierte Stichprobe: die Muster gelten nur noch ungefähr
#' simulate_model("parallel", n = 300)
#' @export
simulate_model <- function(
  model = c(
    "parallel",
    "essentially_parallel",
    "tau_equivalent",
    "essentially_tau_equivalent",
    "tau_congeneric"
  ),
  n_items = 3,
  n = NULL
) {
  model <- match.arg(model)
  if (!n_items %in% 3:6) {
    stop("`n_items` muss eine Zahl von 3 bis 6 sein.", call. = FALSE)
  }
  if (!is.null(n) && (!is.numeric(n) || n < 10)) {
    stop("`n` muss `NULL` oder eine Zahl ab 10 sein.", call. = FALSE)
  }

  equal_means <- model %in% c("parallel", "tau_equivalent")
  equal_variances <- model %in% c("parallel", "essentially_parallel")

  means <- if (equal_means) {
    rep(draw_distinct(seq(1.5, 4.5, by = 0.1), 1), n_items)
  } else {
    draw_distinct(seq(1.5, 4.5, by = 0.1), n_items, min_gap = 0.2)
  }

  error_variances <- if (equal_variances) {
    rep(draw_distinct(seq(0.2, 0.5, by = 0.05), 1), n_items)
  } else {
    draw_distinct(seq(0.1, 0.6, by = 0.05), n_items, min_gap = 0.1)
  }

  # one-decimal loadings keep every covariance at two decimals
  loadings <- if (model == "tau_congeneric") {
    draw_distinct(seq(0.4, 1, by = 0.1), n_items)
  } else {
    rep(sqrt(draw_distinct(seq(0.3, 0.7, by = 0.05), 1)), n_items)
  }

  covariance <- outer(loadings, loadings)
  diag(covariance) <- loadings^2 + error_variances
  covariance <- round(covariance, 2)
  item_names <- paste0("x", seq_len(n_items))
  names(means) <- item_names
  dimnames(covariance) <- list(item_names, item_names)

  result <- list(model = model, means = means, cov = covariance, n = n)
  if (!is.null(n)) {
    noise <- matrix(stats::rnorm(n * n_items), n, n_items)
    data <- sweep(noise %*% chol(covariance), 2, means, "+")
    colnames(data) <- item_names
    result$means <- colMeans(data)
    result$cov <- stats::cov(data)
    result$data <- as.data.frame(data)
  }
  structure(result, class = "measurement_model")
}

models <- eval(formals(simulate_model)$model)

# Draw `size` values from `values` without replacement, at least `min_gap`
# apart, so that different values stay visibly different after rounding.
draw_distinct <- function(values, size, min_gap = 0) {
  repeat {
    drawn <- values[sample.int(length(values), size)]
    if (size == 1 || min(diff(sort(drawn))) >= min_gap - 1e-9) {
      return(drawn)
    }
  }
}

#' @export
as.data.frame.measurement_model <- function(x, ...) {
  formatted <- formatC(x$cov, format = "f", digits = 2)
  formatted[upper.tri(formatted)] <- ""
  table <- rbind(
    Mittelwert = formatC(x$means, format = "f", digits = 2),
    formatted
  )
  as.data.frame(table, stringsAsFactors = FALSE)
}

#' @export
print.measurement_model <- function(x, ...) {
  print(as.data.frame(x), right = TRUE)
  invisible(x)
}
