#' Stock prices
#'
#' @description 
#' Scraps [**Le Boursier**](http://leboursier.ma/)'s and gets the historical prices for the specified companies.
#' @return 
#' Returns a `data.frame` containing all the historical data for the specified stock.
#' * `date`: the date of the given record.
#' * `open`: the opening price of the stock on `date`.
#' * `high`:  the highest price.
#' * `low`:  the lowest price.
#' * `close`:  the closing price.
#' * `volume`: Volume of stocks traded on `date`.
#' 
#' If the plural variant is used it'll add a `symbol` column that'll contain the name of the company.
#' 
#' @param x,... Company name as returned by the [get_today()] function
#'
#' @export
#'
#' @examples
#' head(stock("Wafa Assur"), 20)
#' head(stock(), 20) # same as runing stock("MASI")
#' head(stock("MADEX"), 20)
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
#' head(stocks("Masi", "MADEX"), 20)
stocks <- function(...){
  vals <- list_of_codes[tolower(list_of_codes$name) %in% tolower(c(...)), ]
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
