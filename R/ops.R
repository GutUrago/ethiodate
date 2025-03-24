
#' @export
summary.ethDate <- function(object, digits = 12L, ...) {

  x <- summary.default(unclass(object), digits = digits, ...)
  if(m <- match("NA's", names(x), 0)) {
    NAs <- as.character(as.integer(x[m]))
    x <- as.character(new_ethDate(x[-m]))
    x <- c(x, "NA's" = NAs)
  } else {
    x <- as.character(new_ethDate(x))
    }
  x
  }

#' @export
`+.ethDate` <- function(e1, e2) {
  # only valid if one of e1 and e2 is a scalar.
  if(inherits(e1, "ethDate") && inherits(e2, "ethDate"))
    stop("binary + is not defined for \"ethDate\" objects")
  x <- unclass(e1) + unclass(e2)
  new_ethDate(x)
  }

#' @export
`-.ethDate` <- function(e1, e2) {
  if(!inherits(e1, "ethDate"))
    stop("can only subtract from \"ethDate\" objects")
  if(inherits(e2, "ethDate")) {
    x <- unclass(e1) - unclass(e2)
    return(new_ethDiffDay(x))
  }
  x <- unclass(e1) - e2
  new_ethDate(x)
  }



