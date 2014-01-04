#' Return number of cpus (or a default on failure)
#' 
#' @param default Number of cores to assume if detectCores fails
#' @return Integer number of cores
#' @author jefferis
#' @importFrom parallel detectCores
#' @export
#' @seealso \code{\link{detectCores}}
#' @examples 
#' ncpus()
ncpus<-function(default=1){
  # nb now in base
  cores=detectCores()
  if(is.na(cores)) {
    cores=detectCores(TRUE)
    if(is.na(cores)){
      warning("I can't identify the number of cpus. Defaulting to",default)
      return(default)
    }
  }
  cores
}
