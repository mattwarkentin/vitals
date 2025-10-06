# vitals (development version)

* `$eval()` and `$log()` will now write log files to the same default 
  directory--the one specified when initializing the Task object. 
  Previously, `$eval()` wrote to that directory, while `$log()` wrote 
  to `vitals_log_dir()` (#158 by @SokolovAnatoliy).

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
