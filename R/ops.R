
#' @export
summary.ethdate <- function(object, digits = 12L, ...) {

  x <- summary.default(unclass(object), digits = digits, ...)
  if(m <- match("NA's", names(x), 0)) {
    NAs <- as.character(as.integer(x[m]))
    x <- as.character(new_ethdate(x[-m]))
    x <- c(x, "NA's" = NAs)
  } else {
    x <- as.character(new_ethdate(x))
    }
  x
  }

#' @export
`+.ethdate` <- function(e1, e2) {
  # only valid if one of e1 and e2 is a scalar.
  if(inherits(e1, "ethdate") && inherits(e2, "ethdate"))
    stop("binary + is not defined for \"ethdate\" objects")
  x <- unclass(e1) + unclass(e2)
  new_ethdate(x)
  }

#' @export
`-.ethdate` <- function(e1, e2) {
  if(!inherits(e1, "ethdate"))
    stop("can only subtract from \"ethdate\" objects")
  if(inherits(e2, "ethdate")) {
    x <- unclass(e1) - unclass(e2)
    return(new_ethdiffday(x))
  }
  x <- unclass(e1) - e2
  new_ethdate(x)
  }



