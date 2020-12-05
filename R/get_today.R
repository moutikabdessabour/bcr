#' Latest daily variation of Moroccan stocks
#' @description 
#' Get the last variation of all stocks that are available in the stock exchange and the MASI/MADEX indices.
#' @return
#' Returns a `data.frame` containing the daily variation for all the stocks.
#' * `name`: name of the company/stock.
#' * `price`: last price.
#' * `variation`: variation of the price.
#'
#' @export
#'
#' @examples
#' get_today()
get_today <- function(){
    get_html("http://leboursier.ma/component/option,com_api/format,json/method,getBasicStocksInfo/") -> df
    df$name = sub(" P?/?N?$", "", df$name)
   
    setNames(df[nzchar(df$name), - 2], nm=c("name", "price", "variation"))
}