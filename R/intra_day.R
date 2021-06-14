

#' @export
#'
#' @rdname intra_day
#' @examples
#' if( bcr:::check_internet() ) {
#' head(intraday(), 30)
#' }
intraday <- function(name){
    if(missing(name)) name<-NULL
    get_intra(list_of_codes[tolower(list_of_codes$name) %in% tolower(name[[1]]), 2, drop=T])
}

#' Intraday Prices
#' @description
#' Scraps the intraday stock prices for the provided companies
#'
#' @return
#' Returns a `data.frame` containing all the intraday prices for the specified stocks.
#' * `time`: the time of the record.
#' * `price`: the price at that time.
#' Where the `symbol` column contains the name of the company.
#'
#' @param name,... Company names as returned by the [get_today()] function
#'
#'
#' @rdname intra_day
#' @export
#' @examples
#' if( bcr:::check_internet() ) {
#' intradays("Wafa Assur", "Nexans Maroc")
#' }
intradays <- function(...){
    vals <- list_of_codes[tolower(list_of_codes$name) %in% tolower(c(...)), ]
    stopifnot(nrow(vals)>0)

    df <- lapply(vals[[2]], get_intra)
    sapply(df, nrow) -> each
    df <- do.call(rbind, df)
    df$symbol <- rep(vals[[1]], times=each)
    df
}

get_intra <- function(x){
    x <- if(missing(x) || is.null(x) || length(x)==0) "getMarketIntraday" else{ if(tolower(x)=="madex") "getMadexIntraday"  else paste0("getStockIntraday&ISIN=", x)}
    url <- paste0("www.leboursier.ma/index.php?option=com_api&view=api&format=json&method=" , x )

    setNames(get_html(url), nm=c("time", "price"))
}

