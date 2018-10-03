# Variable, global to package's namespace.
# This function is not exported to user space and does not need to be documented.
MYPKGOPTIONS <- settings::options_manager(
  conventional.color="brown",
  renewable.color="green",
  storage_discharging.color="lightgreen",
  storage_loading.color="skyblue",
  curtailment.color="red",
  demand.color="blue"
  )

# User function that gets exported:

#' Set or get options for this package
#'
#' @param ... Option names to retrieve option values or \code{[key]=[value]} pairs to set options.
#'
#' @section Supported options:
#' The following options (listed with their defailt values) are supported:
#' \itemize{
#'
#' \item{conventional.color="brown"}
#' \item{renewable.color="green"}
#' \item{storage_discharging.color="lightgreen"}
#' \item{storage_loading.color="skyblue"}
#' \item{curtailment.color="red"}
#' \item{demand.color="blue"}
#'
#' }
#'
#' @export
pkg_options <- function(...){
  # protect against the use of reserved words.
  settings::stop_if_reserved(...)
  MYPKGOPTIONS(...)
}

#' Reset global options for pkg
#'
#' @export
pkg_reset<-function() settings::reset(MYPKGOPTIONS)
