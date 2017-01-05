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
  # tryCatch(
  #   processMessage(req),
  #   error = function(e) {
  #     return(conditionMessage(e))
  #   }
  # )

  processMessage(req)
}

#' Process Message
#'
#' Helper function to point request to correct parsing function
#' @param req Request from api.ai
processMessage <- function(req) {
  func <- req$result$metadata$intentName
  do.call(func,req)
}

## Behavior functions

#' Get ticker quote
#'
#' Gets stock price from web service
#' @param req Request from api.ai
#' @importFrom jsonlite unbox
finance.quote <- function(req) {
  speech <- "This is ground control to major tom"
  list(
    "speech" = unbox(speech),
    "displayText" = unbox(speech),
    "source" = unbox("stat-server")
  )
}
