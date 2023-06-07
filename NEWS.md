# nat.utils 0.6.1

* remove defunct file.hardlink()
* fix T in function signature identified by CRAN

# nat.utils 0.6

## What's Changed
* fix bug for `common_path()` on Windows (noticed by CRAN) (https://github.com/natverse/nat.utils/commit/bf1160095907f646b76df247edd82f0570899f52)
* Feature/chunks by @jefferis in https://github.com/natverse/nat.utils/pull/9
* Switch to GitHub actions by @jefferis in https://github.com/natverse/nat.utils/pull/10
* Update README esp URLs by @jefferis in https://github.com/natverse/nat.utils/pull/11

**Full Changelog**: https://github.com/natverse/nat.utils/compare/v0.5.1...v0.6


# nat.utils 0.5.1

* fixes `gzip.crc()` bug on solaris (#8, thanks to Brian Ripley)
* dev: simplify gzip.crc test and therefore no longer depend on digest

# nat.utils 0.5

* new function `common_path()` finds common prefix of multiple paths
* new function `split_path()` breaks a path into its components, optionally 
  including file separators.
* file.hardlink is now defunct
* dev: imports utils::read.table
* dev: extra tests and code coverage support

# nat.utils 0.4.3

* bugfix: `abs2rel()` handles multiple paths without a warning
* bugfix: `zipinfo()` quotes files
* dev: upgrade to roxygen2 v4.0.2 and better rstudio settings

# nat.utils 0.4.2

* bugfix: export `is.gzip()`
* bugfix: test error

# nat.utils 0.4.1

* add `is.gzip()` function
* `RunCmdForNewerInput()` now has a Force option (FALSE by default) that can be
  used to override mtime checks and run the command if possible.
* dev: upgrade to roxygen2 v4

# nat.utils 0.4

* `RunCmdForNewerInput()` can now evaluate expressions in the context of the caller
  (so that variables can be used properly)
* tests: fix a test failure for latest version of testthat
* dev: add travis continuous integration, update docs with roxygen2 v3.1

# nat.utils 0.3

* deprecate file.hardlink in favour of base::file.link
* prepare CRAN release

# nat.utils 0.2

* add `zipinfo()` and `zipok()` functions (and tests)

# nat.utils 0.1

* First version on github
* translates main functions from AnalysisSuite Utils/OSUtils.R
