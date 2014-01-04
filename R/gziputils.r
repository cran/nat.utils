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
