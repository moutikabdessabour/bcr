
#' Moroccan Market and Sector indices
#' @description 
#' Gets the Moroccan Market and Sector indices that are listed in [**Le Boursier**](http://leboursier.ma/details/marche.html).
#' @export
#' @rdname indices
#' @examples
#' indices()
indices <- function() setNames(do.call(rbind, lapply(1:5, function(x) cbind(type=index_types[x], get_html(paste0("http://leboursier.ma/index.php?option=com_api&view=api&method=indexInfoByType&format=json&type=", x))))), nm=c("type", "name", "last_date", "price", "open", "close", "variation", "low", "high"))





#' @export
#' @rdname indices
#' @examples
#' sector_indices()
sector_indices <- function() setNames(get_html("http://leboursier.ma/index.php?option=com_api&view=api&method=sectorsInfo&format=json"),nm=c("name", "price", "variation"))
