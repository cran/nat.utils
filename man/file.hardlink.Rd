\name{file.hardlink}
\alias{file.hardlink}
\title{Make hardlink to file}
\usage{
file.hardlink(from, to)
}
\arguments{
  \item{from}{Source file}

  \item{to}{(New) target hardlink file to create}
}
\value{
logical indicating success
}
\description{
Used system call to access 'ln' command line utility. Now
deprecated in favour of recently introduced file.link
function in base R.
}
\author{
jefferis
}
\seealso{
\code{\link{file.symlink}}
}

