% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/scorer-detect.R
\name{scorer_detect}
\alias{scorer_detect}
\alias{detect_includes}
\alias{detect_match}
\alias{detect_pattern}
\alias{detect_exact}
\alias{detect_answer}
\title{Scoring with string detection}
\usage{
detect_includes(case_sensitive = FALSE)

detect_match(
  location = c("end", "begin", "any", "exact"),
  case_sensitive = FALSE
)

detect_pattern(pattern, case_sensitive = FALSE, all = FALSE)

detect_exact(case_sensitive = FALSE)

detect_answer(format = c("line", "word", "letter"))
}
\arguments{
\item{case_sensitive}{Logical, whether comparisons are case sensitive.}

\item{location}{Where to look for match: one of \code{"end"}, \code{"begin"},
\code{"any"}, or \code{"exact"}. Defaults to \code{"end"}.}

\item{pattern}{Regular expression pattern to extract answer.}

\item{all}{Logical: for multiple captures, whether all must match.}

\item{format}{What to extract after \code{"ANSWER:"}: \code{"letter"}, \code{"word"},
or \code{"line"}. Defaults to \code{"line"}.}
}
\value{
A function that scores model output based on string matching. Pass the
returned value to \verb{$eval(scorer)}. See the documentation for the \code{scorer}
argument in \link{Task} for more information on the return type.
}
\description{
The following functions use string pattern detection to score model outputs.
\itemize{
\item \code{detect_includes()}: Determine whether the \code{target} from the sample
appears anywhere inside the model output. Can be case sensitive or
insensitive (defaults to the latter).
\item \code{detect_match()}: Determine whether the \code{target} from the sample appears
at the beginning or end of model output (defaults to looking at the end).
Has options for ignoring case, white-space, and punctuation
(all are ignored by default).
\item \code{detect_pattern()}: Extract matches of a pattern from the model response
and determine whether those matches also appear in \code{target}.
\item \code{detect_answer()}: Scorer for model output that precedes answers with
"ANSWER: ". Can extract letters, words, or the remainder of the line.
\item \code{detect_exact()}: Scorer which will normalize the text of the answer and
target(s) and perform an exact matching comparison of the text. This
scorer will return \code{CORRECT} when the answer is an exact match to one
or more targets.
}
}
\examples{
if (!identical(Sys.getenv("ANTHROPIC_API_KEY"), "")) {
  # set the log directory to a temporary directory
  withr::local_envvar(VITALS_LOG_DIR = withr::local_tempdir())

  library(ellmer)
  library(tibble)

  simple_addition <- tibble(
    input = c("What's 2+2?", "What's 2+3?"),
    target = c("4", "5")
  )

  # create a new Task
  tsk <- Task$new(
    dataset = simple_addition,
    solver = generate(solver_chat = chat_anthropic(model = "claude-3-7-sonnet-latest")),
    scorer = detect_includes()
  )

  # evaluate the task (runs solver and scorer)
  tsk$eval()
}

}
\seealso{
\code{\link[=model_graded_qa]{model_graded_qa()}} and \code{\link[=model_graded_fact]{model_graded_fact()}} for model-based
scoring.
}
