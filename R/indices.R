
#' Gets the Moroccan Market and Sector indices
#'
#' `indices` (resp. `sector_indices`) Returns a data.frame containing all the Market Indices (resp. Sector Indices) listed in [**Le Boursier**](http://leboursier.ma/details/marche.html).
#'
#' The column names are self explanatory.
#' @export
#' @rdname indices
#' @examples
#' \dontrun{
#'   indices()}
indices <- function() setNames(do.call(rbind, lapply(1:5, function(x) cbind(type=index_types[x], get_html(paste0("http://leboursier.ma/index.php?option=com_api&view=api&method=indexInfoByType&format=json&type=", x))))), nm=c("type", "name", "last_date", "price", "open", "close", "variation", "low", "high"))





#' @export
#' @rdname indices
#' @examples
#' \dontrun{
#'   sector_indices()}
sector_indices <- function() setNames(get_html("http://leboursier.ma/index.php?option=com_api&view=api&method=sectorsInfo&format=json"),nm=c("name", "price", "variation"))
