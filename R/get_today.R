#' Get the daily variation 
#'
#' Returns a data.frame containing the daily variation for all the stocks
#'
#' @export
#'
#' @examples
#'   get_today()
get_today <- function(){
    get_html("http://leboursier.ma/component/option,com_api/format,json/method,getBasicStocksInfo/") -> df
    df$name = sub(" P?/?N?$", "", df$name)
   
    df[nzchar(df$name), -2]
}