# vitals (development version)

* `$eval()` now routes arguments to solvers and scorers based on
  their function signatures, allowing users to pass arguments specific to each
  without requiring ellipses in both functions (#98, #152). `$eval()` now errors when supplied unnamed arguments.

* Solvers and scorers can now return arbitrary R objects in metadata; they
  will be summarized in a lossy format when logged to .json.

* The package will now set the envvar `IN_VITALS_EVAL` to `"true"` during 
  solving and scoring.

* Numeric task targets will no longer introduce errors in the log viewer.

* Images generated from tool calls will now be logged compatibly with the log 
  viewer (#138).

* Updated the vendored Inspect Log Viewer to Inspect version 0.3.122 (#138).

* `detect_match()` now lists the correct `location` options in its default 
  value (#140, #142 by @mattwarkentin).

* The log viewer previously reported the scorer's response as both the solver's
  and scorers response—this is now fixed (#141, #142 by @mattwarkentin).

# vitals 0.1.0

* Initial CRAN submission.
