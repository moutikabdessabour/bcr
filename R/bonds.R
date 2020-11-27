
#' Scraps the data of the Moroccan Bonds
#'
#' Returns a data.frame containing all the bonds listed in [**Le Boursier**](http://leboursier.ma/details/marche.html).
#' The column names are self explanatory except for `full_name` which stands for the full name of the bond issuer.
#'
#'
#' @export
#'
#' @rdname bonds
#' @examples
#'   bonds()
bonds <- function() {
    setNames(get_html("http://leboursier.ma/index.php?option=com_api&view=api&method=getBondsInfo&format=json")[-c(5,9)], nm=c("bond_name", "issued", "issuer", "full_name", "rate", "price_ref", "price_last")) -> df
    df$rate <- df$rate/100
    df
}