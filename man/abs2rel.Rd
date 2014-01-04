\name{abs2rel}
\alias{abs2rel}
\title{Remove common part of two paths, leaving relative path}
\usage{
  abs2rel(path, stempath = getwd(),
    StopIfNoCommonPath = FALSE)
}
\arguments{
  \item{path}{Path to make relative}

  \item{stempath}{Root to which \code{path} will be made
  relative}

  \item{StopIfNoCommonPath}{Error if no path in common}
}
\value{
  Character vector containing relative path
}
\description{
  Remove common part of two paths, leaving relative path
}
\examples{
path = "/Volumes/JData/JPeople/Sebastian/images"
abs2rel(path,'/Volumes/JData')
}
\author{
  jefferis
}
\seealso{
  \code{\link{path.expand}, \link{normalizePath}}
}

