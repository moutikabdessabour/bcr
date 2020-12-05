#' Moroccan Market and Sectoral indices
#' @description 
#' Gets the Moroccan Market indices (`indices()`) or Sectoral indices (`sectoral_indices()`) that are listed in [**Le Boursier**](http://leboursier.ma/details/marche.html).
#' @return
#' the `indices()` function returns a `data.frame` with the following columns:
#' * `type` : the category of the index.
#' * `name` : name of the index.
#' * `last_date` : last date the price of the index changed.
#' * `price` : the price of the index.
#' * `open` : the opening price of the index.
#' * `close` : the closing price of the index.
#' * `variation` : variation of the price.
#' * `low` : lowest price of the index.
#' * `high` : highest price of the index
#' 
#' the `sectoral_indices()` function returns a `data.frame` with the following columns:
#' * `name` : name of the sector.
#' * `price` : latest price of the index.
#' * `variation` : variation of the price of the index.
#' @export
#' @rdname indices
#' @examples
#' indices()
indices <- function() setNames(do.call(rbind, lapply(1:5, function(x) cbind(type=index_types[x], get_html(paste0("http://leboursier.ma/index.php?option=com_api&view=api&method=indexInfoByType&format=json&type=", x))))), nm=c("type", "name", "last_date", "price", "open", "close", "variation", "low", "high"))





#' @export
#' @rdname indices
#' @examples
#' sectoral_indices()
sectoral_indices <- function() setNames(get_html("http://leboursier.ma/index.php?option=com_api&view=api&method=sectorsInfo&format=json"),nm=c("name", "price", "variation"))
