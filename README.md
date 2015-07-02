# nat.utils
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/nat.utils)](http://cran.r-project.org/web/packages/nat.utils) 
[![Release Version](https://img.shields.io/github/release/jefferis/nat.utils.svg)](https://github.com/jefferis/nat.utils/releases/latest) 
[![Build Status](https://travis-ci.org/jefferis/nat.utils.png)](https://travis-ci.org/jefferis/nat.utils)
[![Coverage Status](https://img.shields.io/coveralls/jefferis/nat.utils.svg)](https://coveralls.io/r/jefferis/nat.utils?branch=master)

An R package containing utility functions to support the NeuroAnatomy Toolbox (nat)

## Background
This package provides support functions for the [nat](https://github.com/jefferis/nat)
NeuroAnatomy Toolbox package. Some functions may nevertheless be of general 
interest. See the [reference manual](http://cran.r-project.org/web/packages/nat.utils/nat.utils.pdf) 
on [CRAN](http://cran.r-project.org/web/packages/nat.utils/) for a for full function listing.

## Installation

### Released versions
From [CRAN](http://cran.r-project.org/web/packages/nat.utils/)- the recommended
option for simplicity and since this package is not under heavy development:

```r
install.packages("nat.utils")
```

### Bleeding Edge
Straight from github with Hadley Wickham's [devtools](https://github.com/hadley/devtools) package:

```r
if(!require("devtools")) install.packages("devtools")
devtools::install_github('nat.utils','jefferis')
```
Note: Windows users need [Rtools](http://www.murdoch-sutherland.com/Rtools/) to
install in this way.
