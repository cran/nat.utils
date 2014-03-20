\name{ncpus}
\alias{ncpus}
\title{Return number of cpus (or a default on failure)}
\usage{
ncpus(default = 1)
}
\arguments{
  \item{default}{Number of cores to assume if detectCores
  fails}
}
\value{
Integer number of cores
}
\description{
Return number of cpus (or a default on failure)
}
\examples{
ncpus()
}
\author{
jefferis
}
\seealso{
\code{\link{detectCores}}
}

