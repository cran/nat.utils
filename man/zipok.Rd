\name{zipok}
\alias{zipok}
\title{Verify integrity of one or more zip files}
\usage{
zipok(f, Verbose = FALSE)
}
\arguments{
  \item{f}{Path to one (or more) files}

  \item{Verbose}{Whether to be Verbose (default FALSE)}
}
\value{
TRUE when file OK, FALSE otherwise
}
\description{
Verify integrity of one or more zip files
}
\details{
Uses system unzip command.
}
\author{
jefferis
}
\seealso{
Other ziputils: \code{\link{zipinfo}}
}

