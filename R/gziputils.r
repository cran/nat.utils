#' Extract the crc (32 bit hash) of a gzip file
#'
#' Assumes that the gzip crc is at the end of the file.
#' Checks for a valid gzip magic number at the start of the file
#' @param f Path to a gzip file
#' @return hexadecimal formatted 
#' @export
#' @examples
#' rdsfile=system.file('help/aliases.rds')
#' gzip.crc(rdsfile)
gzip.crc<-function(f){
  con=file(f,open='rb')
  on.exit(close(con),add=TRUE)
  magic=readBin(con,what='raw',n=2)
  if(magic[1]!=0x1f || magic[2]!=0x8b) {
    warning("This is not a gzip file")
    return(NA)
  }
  seek(con,-8,origin='end')
  # TODO check endian issues (what happens if CRC was from opposite endian platform?)
  crc=readBin(con,integer(),size=4)
  format(as.hexmode(crc),width=8)
}

#' Check if a file is a gzip file
#' 
#' @param f Path to file to test
#' @return logical indicating whether \code{f} is in gzip format (or \code{NA}
#'   if the file cannot be accessed)
#' @examples
#' \dontrun{
#' notgzipfile=tempfile()
#' writeLines('not a gzip', notgzipfile)
#' is.gzip(notgzipfile)
#' con=gzfile(gzipfile<-tempfile(),open='wt')
#' writeLines('This one is gzipped', con)
#' is.gzip(gzipfile)
#' unlink(c(notgzipfile,gzipfile))
#' }
is.gzip<-function(f) {
  if(file.access(f, mode=4)<0) return(NA)
  x=file(f)
  on.exit(close(x))
  isTRUE(summary(x)$class=='gzfile')
}
