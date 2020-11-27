
#' Stock prices
#' @details 
#' Scraps the historical stock prices for the provided companies.
#'
#' @description 
#' Scraps [**Le Boursier**](http://leboursier.ma/)'s API and get the historical prices for the specified companies.
#'
#' Returns a data.frame containing all the historical data for the specified stock.
#' If the plural variant is used it'll add a `symbol` column that'll contain the name of the company.
#' 
#' @param x,... Company name as returned by the [get_today()] function
#'
#' @export
#'
#' @examples
#'   stock("Wafa Assur")
#'   stock() # same as runing stock("MASI")
#'   stock("MASI")
#'   stock("MADEX")
#' @rdname stock
stock <- function(x) {
    #if(length(x)>1) do.call(stocks, as.list(x))
    #else 
    if(missing(x)) x<-NULL
    get_st(list_of_codes[tolower(list_of_codes$name) %in% tolower(x[[1]]), 2, drop=T])
}


#' @export
#'
#' @rdname stock
#' @examples
#'   stocks("Wafa Assur", "Nexans Maroc")
#'   stocks("Masi", "MADEX")
stocks <- function(...){
  print(vals <- list_of_codes[tolower(list_of_codes$name) %in% tolower(c(...)), ])
  stopifnot(nrow(vals)>0)

  df <- lapply(vals[[2]], get_st)
  sapply(df, nrow) -> each
  df <- do.call(rbind, df)
  df$symbol <- rep(vals[[1]], times=each)
  df
}

get_st <- function(x){
    if(missing(x) || is.null(x) || length(x)==0) x <- "Masi" 
    bool <- x %in% c("Masi","Madex") 
    
    get_html(paste0("https://www.leboursier.ma/index.php?option=com_api&view=api&format=json&method=get", if(bool) x else "Stock","OHLC", if(!bool) paste0("&ISIN=", x) ) ) -> df

    colnames(df) <- c("date", "open", "high", "low", "close", "volume")
    df$date = as.POSIXct(df$date/1000, origin="1970-01-01", tz="Africa/Casablanca")
    df
}
