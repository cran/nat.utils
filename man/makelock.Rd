\name{makelock}
\alias{makelock}
\alias{removelock}
\title{Make and remove (NFS safe) lock files}
\usage{
makelock(lockfile, lockmsg, CreateDirectories = TRUE)

removelock(lockfile)
}
\arguments{
  \item{lockfile}{Path to lockfile}

  \item{lockmsg}{Character vector with message to be
  written to lockfile}

  \item{CreateDirectories}{Recursively create directories
  implied by lockfile path}
}
\value{
logical indicating success
}
\description{
Creates a lock file on disk containing a message that
should identify the current R session. Will return FALSE is
someone else has already made a lockfile. In order to avoid
race conditions typical on NFS mounted drives makelock
appends a unique message to the lock file and then reads
the file back in. Only if the unique message is the first
line in the file will makelock return TRUE.

\code{removelock} displays a warning if lockfile does not
exist
}
\examples{
makelock(lock<-tempfile())
stopifnot(!makelock(lock))
removelock(lock)
}
\author{
jefferis
}

