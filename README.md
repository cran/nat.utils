# nat.utils
<!-- badges: start -->
[![natverse](https://img.shields.io/badge/natverse-Part%20of%20the%20natverse-a241b6)](https://natverse.org/)
[![Docs](https://img.shields.io/badge/docs-100%25-brightgreen.svg)](https://natverse.org/nat.utils/reference/)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/nat.utils)](https://cran.r-project.org/package=nat.utils) 
[![Downloads](https://cranlogs.r-pkg.org/badges/nat.utils?color=brightgreen)](https://cran.r-project.org/package=nat.utils)
[![Release Version](https://img.shields.io/github/release/natverse/nat.utils.svg)](https://github.com/natverse/nat.utils/releases/latest) 
[![R-CMD-check](https://github.com/natverse/nat.utils/workflows/R-CMD-check/badge.svg)](https://github.com/natverse/nat.utils/actions)
[![Codecov test coverage](https://codecov.io/gh/natverse/nat.utils/branch/master/graph/badge.svg)](https://app.codecov.io/gh/natverse/nat.utils?branch=master)
<!-- badges: end -->

An R package containing utility functions to support the NeuroAnatomy Toolbox (nat)

## Background
This package provides support functions for the [nat](https://github.com/natverse/nat)
NeuroAnatomy Toolbox package. Some functions may nevertheless be of general 
interest. See the [online documentation](https://natverse.org/nat.utils/reference/) 
for a for full function listing.

## Installation

### Released versions
From [CRAN](https://cran.r-project.org/package=nat.utils). The recommended
option for simplicity and since this package is not under heavy development:

```r
install.packages("nat.utils")
```

### Bleeding Edge
Straight from github with Hadley Wickham's remotes package:

```r
if(!require("remotes")) install.packages("remotes")
remotes::install_github('natverse/nat.utils')
```
Note: Windows users need [Rtools](https://www.murdoch-sutherland.com/Rtools/) to
install in this way.
