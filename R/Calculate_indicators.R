#' Calculate the summary values ("indicators") in the  head of  the spreadsheet tools
#'
#' @param sim
#'
#' @return
#' @export
calculate_indicators<-function(SIM){
 SIM %>% summarise_all(sum)

}

