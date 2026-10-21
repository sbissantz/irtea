#' Antworten auf drei Persönlichkeitsitems
#'
#' Simulierte Antworten von 7 Personen auf drei Items eines
#' Persönlichkeitsinventars, erhoben auf einer Schiebereglerskala von -12
#' (Ablehnung) bis 12 (Zustimmung). Grundlage für Aufgabe 8 in Kapitel 1
#' des Übungshefts.
#'
#' @format Ein Data Frame mit 7 Zeilen (Personen) und 3 Spalten:
#' \describe{
#'   \item{i1}{„Ich ziehe es vor, meine Zeit alleine zu verbringen, als mit
#'     anderen Menschen zu interagieren."}
#'   \item{i2}{„Ich genieße es, im Mittelpunkt der Aufmerksamkeit zu stehen."}
#'   \item{i3}{„Ich finde es wichtig, in sozialen Situationen höflich und
#'     respektvoll zu sein."}
#' }
#' @source Simuliert; siehe Lösungsvorschlag zu Kapitel 1, Aufgabe 8.
"personality_items"

#' Antworten auf einen Fragebogen zur Prüfungsangst
#'
#' Simulierte Antworten auf einen fiktiven Fragebogen mit 20 Items zur
#' Prüfungsangst, angelehnt an das Vier-Komponenten-Modell (Besorgtheit,
#' Aufgeregtheit, Interferenz, Mangel an Zuversicht). Antwortskala von 1
#' („trifft überhaupt nicht zu“) bis 7 („trifft voll und ganz zu“). Zwei
#' Stichproben: eine heterogene Online-Stichprobe (N = 1000) und eine
#' homogenere Stichprobe von Psychologiestudierenden im ersten Semester
#' (N = 1000). Grundlage für Kapitel 8 des Übungshefts.
#'
#' @format Ein Data Frame mit 2000 Zeilen (Personen) und 21 Spalten:
#' \describe{
#'   \item{sample}{Stichprobe: `"online"` oder `"students"`.}
#'   \item{i01}{„Ich mache mir Sorgen, dass ich durchfallen könnte.“}
#'   \item{i02}{„Vor Prüfungen habe ich Herzklopfen.“}
#'   \item{i03}{„In Prüfungen schweifen meine Gedanken ab.“}
#'   \item{i04}{„Ich zweifle an meinen Fähigkeiten, wenn eine Prüfung
#'     ansteht.“}
#'   \item{i05}{„Ich grüble darüber nach, welche Folgen eine schlechte Note
#'     für mich hätte.“}
#'   \item{i06}{„In Prüfungen bin ich angespannt.“}
#'   \item{i07}{„In Prüfungen fällt mir Gelerntes nicht ein, obwohl ich es
#'     eigentlich weiß.“}
#'   \item{i08}{„Ich habe wenig Vertrauen in meine Leistung in Prüfungen.“}
#'   \item{i09}{„Ich befürchte, schlechter abzuschneiden als die anderen.“}
#'   \item{i10}{„Vor Prüfungen habe ich ein flaues Gefühl im Magen.“}
#'   \item{i11}{„In Prüfungen lenken mich Gedanken an ein mögliches
#'     Scheitern von den Aufgaben ab.“}
#'   \item{i12}{„Ich traue mir in Prüfungen wenig zu.“}
#'   \item{i13}{„Ich befürchte, dass mir in der Prüfung das Gelernte nicht
#'     einfällt.“}
#'   \item{i14}{„In Prüfungen fühle ich mich nervös.“}
#'   \item{i15}{„In Prüfungen denke ich an Dinge, die mit den Aufgaben nichts
#'     zu tun haben.“}
#'   \item{i16}{„Ich fühle mich Prüfungen nicht gewachsen.“}
#'   \item{i17}{„Ich mache mir Gedanken darüber, was andere von mir denken,
#'     wenn ich versage.“}
#'   \item{i18}{„In Prüfungen werden meine Hände feucht.“}
#'   \item{i19}{„In Prüfungen fällt es mir schwer, mich zu konzentrieren.“}
#'   \item{i20}{„Ich weiß vorher meist nicht, wie eine Prüfung für mich
#'     ausgehen wird.“}
#' }
#' @source Simuliert mit einem Faktormodell und itemspezifischen Schwellen
#'   (Skript `data-raw/test-anxiety.R` im GitHub-Repository des Pakets).
"test_anxiety"
