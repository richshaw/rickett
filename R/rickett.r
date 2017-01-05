#' Message
#'
#' This function parses messages to Rickett
#' @param req Request from api.ai
#' @keywords chat finance
#' @export
#' @examples
#' message()

message <- function(...) {
  req <- list(...)
  tryCatch(
    processMessage(req),
    error = function(e) {
      return(conditionMessage(e))
    }
  )
}

#' Process Message
#'
#' Helper function to point request to correct parsing function
#' @param req Request from api.ai
processMessage <- function(req) {
  speech <- "This is ground control to major tom"
  list(
    "speech" = speech,
    "displayText" = speech,
    "source" = "stat-server"
  )
}
