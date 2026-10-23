#' Messmodelle erkennen üben
#'
#' Ein Quiz für die Konsole: In jeder Runde zeigt die Funktion Mittelwerte und
#' Kovarianzmatrix von Items, die einem zufällig gezogenen Messmodell folgen
#' (siehe [simulate_model()]). Sie tippen den Buchstaben des Modells ein und
#' erhalten eine Rückmeldung mit Begründung. Mit `q` beenden Sie das Quiz
#' vorzeitig.
#'
#' @param rounds Anzahl der Runden.
#' @param n_items Mögliche Anzahlen von Items, 3 bis 6; in jeder Runde wird
#'   eine davon gezogen.
#' @param n Stichprobengröße, an [simulate_model()] weitergegeben. `NULL`
#'   (Voreinstellung) zeigt die exakten modellimplizierten Werte.
#'
#' @return Unsichtbar ein Data Frame mit einer Zeile pro gespielter Runde
#'   (`model`, `answer`, `correct`).
#'
#' @examples
#' if (interactive()) {
#'   play_roulette()
#' }
#' @export
play_roulette <- function(rounds = 5, n_items = 3:6, n = NULL) {
  if (!interactive()) {
    stop("play_roulette() braucht eine interaktive R-Sitzung.", call. = FALSE)
  }
  run_roulette(rounds, n_items, n, read = readline)
}

# The game loop; `read` takes a prompt and returns the typed answer, so tests
# can replace readline().
run_roulette <- function(rounds, n_items, n, read) {
  if (!all(n_items %in% 3:6)) {
    stop("`n_items` darf nur Zahlen von 3 bis 6 enthalten.", call. = FALSE)
  }
  played <- data.frame(
    model = character(),
    answer = character(),
    correct = logical()
  )

  for (round in seq_len(rounds)) {
    model <- models[sample.int(length(models), 1)]
    size <- n_items[sample.int(length(n_items), 1)]
    cat(sprintf("\nRunde %d von %d\n\n", round, rounds))
    print(simulate_model(model, n_items = size, n = n))
    cat("\n", choices_text, sep = "")

    answer <- ask_answer(read)
    if (answer == "q") {
      break
    }
    correct <- names(model_letters)[model_letters == model]
    if (answer == correct) {
      cat("Richtig! ")
    } else {
      # fmt: skip
      cat(sprintf("Leider falsch: (%s) w\u00e4re richtig gewesen. ", correct))
    }
    cat(model_reasons[[model]], "\n", sep = "")
    played[nrow(played) + 1, ] <- list(model, answer, answer == correct)
  }

  cat(sprintf(
    "\nSie haben %d von %d Messmodellen richtig erkannt.\n",
    sum(played$correct),
    nrow(played)
  ))
  invisible(played)
}

# Ask until the answer is a letter from a to e, or q to quit. Strings with
# umlauts use \u escapes for portability; `# fmt: skip` keeps the formatter
# from turning them back into literal characters.
ask_answer <- function(read) {
  repeat {
    answer <- tolower(trimws(read("Ihre Antwort (a bis e, q beendet): ")))
    if (answer %in% c(names(model_letters), "q")) {
      return(answer)
    }
    cat("Bitte tippen Sie einen Buchstaben von a bis e oder q.\n")
  }
}

model_letters <- c(
  a = "parallel",
  b = "essentially_parallel",
  c = "tau_equivalent",
  d = "essentially_tau_equivalent",
  e = "tau_congeneric"
)

# fmt: skip
choices_text <- paste0(
  "Um welches Messmodell handelt es sich?\n",
  "(a) parallel\n",
  "(b) essenziell parallel\n",
  "(c) tau-\u00e4quivalent\n",
  "(d) essenziell tau-\u00e4quivalent\n",
  "(e) tau-kongenerisch\n"
)

# fmt: skip
model_reasons <- list(
  parallel = "Mittelwerte, Varianzen und Kovarianzen sind jeweils gleich: parallel.",
  essentially_parallel = paste(
    "Varianzen und Kovarianzen sind gleich, die Mittelwerte",
    "unterscheiden sich: essenziell parallel."
  ),
  tau_equivalent = paste(
    "Mittelwerte und Kovarianzen sind gleich, die Varianzen",
    "unterscheiden sich: tau-\u00e4quivalent."
  ),
  essentially_tau_equivalent = paste(
    "Die Kovarianzen sind gleich, Mittelwerte und Varianzen",
    "unterscheiden sich: essenziell tau-\u00e4quivalent."
  ),
  tau_congeneric = "Die Kovarianzen unterscheiden sich: tau-kongenerisch."
)
