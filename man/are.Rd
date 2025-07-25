% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/are.R
\docType{data}
\name{are}
\alias{are}
\title{An R Eval}
\format{
A tibble with 29 rows and 7 columns:
\describe{
\item{id}{Character. Unique identifier/title for the code problem.}
\item{input}{Character. The question to be answered.}
\item{target}{Character. The solution, often with a description of notable
features of a correct solution.}
\item{domain}{Character. The technical domain
(e.g., Data Analysis, Programming, or Authoring).}
\item{task}{Character. Type of task
(e.g., Debugging, New feature, or Translation.)}
\item{source}{Character. URL or source of the problem. \code{NA}s indicate that
the problem was written originally for this eval.}
\item{knowledge}{List. Required knowledge/concepts for solving the problem.}
}
}
\source{
Posit Community, GitHub issues, R4DS solutions, etc. For row-level
references, see \code{source}.
}
\usage{
are
}
\description{
An R Eval is a dataset of challenging R coding problems. Each \code{input} is a
question about R code which could be solved on first-read only by experts
and, with a chance to read documentation and run some code, by
fluent data scientists. Solutions are in \code{target()} and enable a fluent
data scientist to evaluate whether the solution deserves full, partial, or
no credit.

Pass this dataset to \code{Task$new()} to situate it inside of an evaluation
task.
}
\examples{
are

dplyr::glimpse(are)
}
\keyword{datasets}
