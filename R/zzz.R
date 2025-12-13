

# Get ethdate components ----

get_component <- function(x, component) {
  components <- c("year", "month", "day", "td", "wx")
  if (length(component) != 1 || !(component %in% components)) {
    cli::cli_abort(
      c(
        "x" = "Invalid component {.val {component}}.",
        "i" = "The input {.var component} must be one of: {paste0(components, collapse = ', ')}."
      )
    )
  }

  if (!is_eth_date(x)) {
    cli::cli_abort(
      message = c(
        "x" = "The input {.var x} must be {.cls ethdate}.",
        "i" = "Current type of {.var x} is {.cls {class(x)}}.",
        "i" = "Please use the constructor function {.fn as_ethdate} to create the object."
      )
    )
  }
  x <- eth_date_components(x)
  vapply(x, function(x) x[[component]], FUN.VALUE = 1)
}

# Recycle vectors to the longest ----

recycle_vctr <- function(...) {
  args <- list(...)
  arg_names <- names(args)

  lengths <- vapply(args, length, integer(1))
  max_len <- max(lengths)

  for (i in seq_along(args)) {
    len <- lengths[i]
    name <- arg_names[i]

    if (len != max_len) {
      args[[i]] <- rep_len(args[[i]], max_len)
    }
  }

  args
}

