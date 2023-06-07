#' Construct paths to files in the extdata folder of a package
#'
#' @details \code{inst/extdata} is the conventional place to store data that is
#'   not managed directly by the standard R package mechanisms. Unfortunately
#'   its location changes at different stages of the package build/load process,
#'   since in the final  package all folders underneath \code{inst} are moved
#'   directly to the package root.
#'
#' @param ... components of the path (eventually appended to location of
#'   \code{extdata})
#' @param package The package to search
#' @param firstpath An additional location to check before looking anywhere else
#' @param Verbose Whether to print messages about failed paths while looking for
#'   extdata
#'
#' @return A character vector containing the constructed path
#' @export
#' @importFrom utils file_test
#' @family extdata
#' @examples
#' find_extdata(package='nat.utils')
find_extdata <- function(..., package=NULL, firstpath=NULL, Verbose=FALSE) {
  paths <- c('inst/extdata', 'extdata')
  
  tried <- data.frame(wd=character(), path=character(), found=logical(), stringsAsFactors = F)
  
  check_dirs <- function(x, wd = getwd()) {
    owd = setwd(wd)
    on.exit(setwd(owd))
    
    found <- FALSE
    for (p in x) {
      found <- file_test('-d', p)
      add_tried(p, found)
      if (found)
        return(p)
    }
    NULL
  }
  
  add_tried <- function(path, found = F) {
    ntried = nrow(tried)
    tried <<- rbind(tried,
                  data.frame(
                    wd = getwd(),
                    path = path,
                    found = found,
                    stringsAsFactors = F
                  ))
  }
  
  p <- check_dirs(union(firstpath, paths))
  if(length(p)) return(file.path(p, ...))
  
  owd <- getwd()
  if(isTRUE(basename(owd)=="data")) {
    p <- check_dirs(file.path(normalizePath(dirname(owd)), paths))
    if(length(p)) return(file.path(p, ...))
  }

  if (is.null(package)) {
    stop(
      "Cannot find extdata in local dir and no package argument specified!\n",
      "Current location: ", getwd(), "\n",
      "Current folder contents: ", paste(dir(all.files = T), collapse=" "), "\n",
      "Checked: ", paste("wd:", tried$wd, "path:", tried$path, collapse = "\n"))
  }

  # sometimes we end up in the folder one up from the package for some reason
  if(isTRUE(package%in%dir(owd))) {
    p <- check_dirs(file.path(package, paths))
    if(length(p)) return(file.path(p, ...))
  }

  packp <- try(system.file(package = package))
  pack_extdata <- file.path(packp, "extdata")
  p <- check_dirs(pack_extdata)
  if(length(p)) return(file.path(p, ...))
  stop("Cannot find extdata in local dir or installed package!\n",
       "Current location: ", getwd(), "\n",
       "Current folder contents: ", paste(dir(all.files = T), collapse=" "), "\n",
       "Checked: ", paste("wd:", tried$wd, "path:", tried$path, collapse = "\n"))
  
  file.path(p, ...)
}



#' Make a neuronlist object from two separate files
#'
#' @details It is expected that you will use this in an R source file within the
#'   data folder of a package. See \bold{Examples} for more information.
#'
#'   If \code{dfpath} is missing, it will be inferred from \code{datapath}
#'   according to the following pattern: \itemize{
#'
#'   \item \code{myblob.rda} main data file
#'
#'   \item \code{myblob.df.rda} metdata file
#'
#'   }
#'
#' @param datapath Path to the data object
#' @param dfpath Path to the data.frame object (constructed from \code{datapath}
#'   when \code{NULL}, see details)
#' @param package Character vector naming a package whose extdata directory will
#'   be sought (with \code{\link{find_extdata}}) and prepended to the two input
#'   paths.
#' @param ... Additional arguments passd to \code{\link{find_extdata}}
#' @return a \code{neuronlist} object
#' @export
#' @importFrom tools file_ext file_path_sans_ext
#' @family extdata
#' @examples
#' \dontrun{
#' # you could use the following in a file
#' # data/make_data.R
#' delayedAssign('pns', read_nl_from_parts('pns.rds', package='testlazyneuronlist'))
#' # based on objects created by
#' save_nl_in_parts(pns)
#' # which would make:
#' # - inst/extdata/pns.rds
#' # - inst/extdata/pns.df.rds
#' }
read_nl_from_parts <- function(datapath, dfpath=NULL, package=NULL, ...) {
  if(is.null(dfpath)) {
    dfpath=paste0(file_path_sans_ext(datapath), ".df.", file_ext(datapath))
  }
  if(!is.null(package)) {
    datapath <- find_extdata(datapath, package=package, ...)
    dfpath <- find_extdata(dfpath, package=package, ...)
  }
  x <- read_data(datapath)
  df <- read_data(dfpath)
  attr(x, 'df') <- df
  x
}

#' Save a neuronlist object into separate data and metadata parts
#'
#' @details Saves a neuronlist into separate data and metadata parts. This can
#'   significantly mitigate git repository bloat since only the metadata object
#'   will change when any metadata is updated. By default the objects will be
#'   saved into the package \code{inst/extdata} folder with sensible names based
#'   on the incoming object. E.g. if \code{x=mypns} the files will be \itemize{
#'
#'   \item mypns.rds
#'
#'   \item mypns.df.rds
#'
#'   }
#' @param x A neuronlist object to save in separate parts
#' @param datapath Optional path to new data file (constructed from name of
#'   \code{x} argument when missing)
#' @param dfpath Optional path to new metadata file (constructed from
#'   \code{datapath} when missing)
#' @param extdata Logical indicating whether the files should be saved into
#'   extdata folder (default \code{TRUE}, when \code{FALSE} the paths are
#'   untouched)
#' @param format Either \code{'rds'} (default) or \code{'rda'}.
#' @param ... Additional arguments passed to \code{\link{saveRDS}} or
#'   \code{\link{save}} (based on the value of \code{format}).
#' @return character vector with path to the saved files (returned invisibly)
#' @importFrom utils file_test
#' @importFrom tools file_ext file_path_sans_ext
#' @family extdata
#' @export
#' @examples
#' \dontrun{
#' save_nl_in_parts(pns)
#' # which would make:
#' # - inst/extdata/pns.rds
#' # - inst/extdata/pns.df.rds
#'
#' save_nl_in_parts(pns, format='rda')
#' # which would make:
#' # - inst/extdata/pns.rda
#' # - inst/extdata/pns.df.rda
#'
#' save_nl_in_parts(pns, 'mypns.rda')
#' # which would make (NB format argument wins):
#' # - inst/extdata/mypns.rds
#' # - inst/extdata/mypns.df.rds
#' }
save_nl_in_parts <- function(x, datapath=NULL, dfpath=NULL, extdata=TRUE, format=c("rds", "rda"), ...) {
  if(!inherits(x, 'neuronlist')) 
    stop("I don't know what to do with objects of class: ", class(x))
  format=match.arg(format)
  dataname <- if(is.null(datapath)) {
    deparse(substitute(x))
  } else {
    if(file_ext(datapath)%in%c("rds",'rda')) file_path_sans_ext(datapath) else datapath
  }
  dfname <- if(is.null(dfpath)) {
    paste0(dataname,".df")
  } else {
    if(file_ext(dfpath)%in%c("rds",'rda')) file_path_sans_ext(dfpath) else dfpath
  }
  
  datapath=paste0(dataname, ".", format)
  dfpath=paste0(dfname, ".", format)
  dataname <- basename(dataname)
  dfname <- basename(dfname)
  
  if(extdata) {
    edp <- file.path('inst/extdata') 
    if(!file_test('-d', edp))
      stop("Folder", edp, "doesn't exist. Please create it!")
    datapath=file.path(edp, datapath)
    dfpath=file.path(edp, dfpath)
  }
  
  if(format=="rda") {
    assign(dfname, attr(x, 'df'))
    save(list = dfname, file=dfpath, ...)
    attr(x, 'df') <- NULL
    assign(dataname, x)
    save(list = dataname, file=datapath, ...)
  } else {
    saveRDS(attr(x,'df'), file = dfpath, ...)
    attr(x, 'df') <- NULL
    saveRDS(x, file = datapath, ...)
  }
  invisible(c(datapath, dfpath))
}

#' @importFrom tools file_ext
read_data <- function(x) {
  if(file_ext(x)=='rda') {
    e <- new.env()
    names=load(x, envir = e)
    if(length(names)>1) warning("There is more than one object saved in:", x)
    get(names, envir=e)
  } else {
    readRDS(x)
  }
}

# for testing purposes
make_fake_package <- function(basedir=tempfile(), package='lhns', 
                              inside_library=FALSE, as_installed=inside_library) {
  p <- basedir
  if(inside_library) p <- file.path(p, 'library')
  packdir <- p <- file.path(p, package)
  if(!as_installed) p <- file.path(p, 'inst')
  p <- file.path(p, 'extdata')
  # <pkg>/extdata
  dir.create(p, recursive = T)
  # <pkg>/data
  dir.create(file.path(packdir, 'data'), recursive = T)
  # <pkg>/DESCRIPTION
  # we need this to trick find.package
  desc=c("Package: rhubarb", "Version: 1.0")
  writeLines(desc, con = file.path(packdir, 'DESCRIPTION'))
  c(base=basedir, package=packdir, extdata=p)
}

