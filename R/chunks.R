#' Split inputs into a number of chunks
#'
#' @details You must specify exactly one of \code{nchunks} and \code{chunksize}.
#' @param x A vector of inputs e.g. ids, neurons etc (optional, see examples)
#' @param size The number of inputs (defaults to \code{length(x)} when \code{x}
#'   is present)
#' @param nchunks The desired number of chunks
#' @param chunksize The desired number of items per chunk
#'
#' @return The elements of x split into a list of chunks or (when \code{x} is
#'   missing) a vector of integer indices in the range \code{1:nchunks}
#'   specifying the chunk for each input element .
#'
#' @export
#' @examples
#' make_chunks(1:11, nchunks=2)
#' make_chunks(size=11, chunksize=2)
make_chunks <- function(x, size=length(x), nchunks=NULL, chunksize=NULL) {
  checkmate::assert_int(size, lower=1)
  
  if(missing(nchunks)) {
    if(missing(chunksize))
      stop("You must supply one of nchunks or chunksize!")
    checkmate::assert_int(chunksize, lower=1)
    nchunks=ceiling(size/chunksize)
    checkmate::assert_int(nchunks, lower=1)
  } else {
    if(!missing(chunksize))
      stop("You must only supply one of nchunks or chunksize!")
    checkmate::assert_int(nchunks, lower=1)
    chunksize=ceiling(size/nchunks)
    checkmate::assert_int(chunksize, lower=1)
  }
  chunks=rep(seq_len(nchunks), rep(chunksize, nchunks))[seq_len(size)]
  if(missing(x)) chunks else split(x, chunks)
}
