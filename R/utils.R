list_of_codes<-structure(list(name = c("Addoha", "AFMA", "Afric Indus.", "Afriquia Gaz", 
"Agma", "Alliances", "Aluminium Maroc", "ATLANTASANAD", "Attijariwafa Bk Rg", 
"Auto Hall", "Auto Nejma", "BALIMA", "BoA Br", "BCP", "BMCI", 
"Cartier Saada", "CDM", "Central.Danone", "CIH", "Ciments Maroc", 
"CMT", "Colorado", "COSUMAR", "CTM", "Dari Couspate", "Delattre Lev.", 
"Delta Holding", "Diac Salaf", "DISWAY", "Ennakl", "EQDOM", "FENIE BROSSETTE", 
"HPS", "IBMaroc.com", "Immr Invest Br", "INVOLYS", "Jet Contractors", 
"LABEL VIE", "LafargeHolcim Ma Br", "Lesieur Cristal", "Lydec", 
"M2M Group", "Maghreb Oxygene", "Maghrebail", "Managem", "Maroc Leasing", 
"Maroc Telecom", "Med Paper", "Microdata", "Mutandis Br", "Nexans Maroc", 
"Oulmes", "PROMOPHARM", "Rebab Company", "Res.Dar Saada Br", 
"Risma", "S2M", "Saham Assurance", "SALAFIN", "SAMIR", "SMI", 
"Stokvis Nord Afr.", "SNEP", "Sonasid", "SOTHEMA", "SRM", "Ste Boissons", 
"STROC Indus.", "TAQA Morocco", "Timar", "Total Maroc", "Unimer", 
"Wafa Assur", "Zellidja", "MASI", "MADEX"), ISIN = c("MA0000011512", 
"MA0000012296", "MA0000012114", "MA0000010951", "MA0000010944", 
"MA0000011819", "MA0000010936", "MA0000011710", "MA0000012445", 
"MA0000010969", "MA0000011009", "MA0000011991", "MA0000012437", 
"MA0000011884", "MA0000010811", "MA0000011868", "MA0000010381", 
"MA0000012049", "MA0000011454", "MA0000010506", "MA0000011793", 
"MA0000011934", "MA0000012247", "MA0000010340", "MA0000011421", 
"MA0000011777", "MA0000011850", "MA0000010639", "MA0000011637", 
"MA0000011942", "MA0000010357", "MA0000011587", "MA0000011611", 
"MA0000011132", "MA0000012387", "MA0000011579", "MA0000012080", 
"MA0000011801", "MA0000012320", "MA0000012031", "MA0000011439", 
"MA0000011678", "MA0000010985", "MA0000011215", "MA0000011058", 
"MA0000010035", "MA0000011488", "MA0000011447", "MA0000012163", 
"MA0000012395", "MA0000011140", "MA0000010415", "MA0000011660", 
"MA0000010993", "MA0000012239", "MA0000011462", "MA0000012106", 
"MA0000012007", "MA0000011744", "MA0000010803", "MA0000010068", 
"MA0000011843", "MA0000011728", "MA0000010019", "MA0000011645", 
"MA0000011595", "MA0000010365", "MA0000012056", "MA0000012205", 
"MA0000011686", "MA0000012262", "MA0000012023", "MA0000010928", 
"MA0000010571", "Masi", "Madex")), row.names = c(NA, -76L), class = "data.frame")

index_types <- c("ST Index", "Rentability Index", "Currency Index", "Moroccan bond index", "CFG bond")




#' @importFrom httr GET content
#' @importFrom jsonlite fromJSON
#' @importFrom stats setNames
get_html <- function(url){
    fromJSON(rawToChar(content(GET(url), "raw")[-(1:3)]))$result -> result
    if(nrow(result)==1 & length(result[[1,1]])>0) setNames(do.call(data.frame, result), nm=names(result)) else as.data.frame(result)
}


make_fupper <- function(x){
  substr(x, 1, 1) <- toupper(substr(x, 1, 1))
  x
}