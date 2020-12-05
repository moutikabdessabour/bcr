
#' Moroccan Bonds
#'
#' @description 
#' Scraps all the bonds listed in [**Le Boursier**](http://leboursier.ma/details/marche.html).
#' 
#' @return 
#' Returns a `data.frame` containing :
#' * `bond_name`: name of the bond.
#' * `issued`: number of issued bonds.
#' * `issuer`: the company that issued the bond.
#' * `full_name`: full name of the bond issuer.
#' * `rate`: rate of return.
#' * `price_ref`: first price.
#' * `price_last`: latest price.
#'
#' @export
#'
#' @rdname bonds
#' @examples
#' bonds()
bonds <- function() {
    setNames(get_html("http://leboursier.ma/index.php?option=com_api&view=api&method=getBondsInfo&format=json")[- c(5,9)], nm=c("bond_name", "issued", "issuer", "full_name", "rate", "price_ref", "price_last")) -> df
    df$rate <- df$rate/100
    df
}