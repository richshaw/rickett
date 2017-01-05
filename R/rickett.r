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
  do.call(func,list('req' = req))
}

## Behavior functions

#' Get ticker quote
#'
#' Gets stock price from web service
#' @param req Request from api.ai
#' @importFrom jsonlite unbox
#' @importFrom quantmod getQuote
finance.quote <- function(req) {

  ticker <- req$result$parameters$ticker
  quote <- as.list(getQuote(ticker))

  if(is.na(quote$Last)) {
    speech <- sprintf("Gosh, I can't find the price of %s, you should probably fire me.",ticker)
  } else {
    speech <- sprintf("%s is trading at %f. Today we've seen a change of %f which is %s. Volume is running at $i.",
                    ticker,quote$Last,quote$Change,quote$`% Change`,quote$Volume)
  }

  list(
    "speech" = unbox(speech),
    "displayText" = unbox(speech),
    "source" = unbox("stat-server")
  )
}
