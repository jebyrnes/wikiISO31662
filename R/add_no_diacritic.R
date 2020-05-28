#' Get Subdivision Names without Diacritics
#'
#' @param adf A data frame with a `subdivision_name` column
#' @param merge Merge with the previous data? Defaults to TRUE
#'
#' @return a tibble
#' @export
#'
#' @examples
#' \dontrun{
#' iso_31662_subdivisions_all <- add_no_diacritic(iso_31662_subdivisions)
#'
#' }
add_no_diacritic <- function(adf, merge = TRUE){
  out <- adf %>%
    dplyr::mutate(subdivision_name_old = subdivision_name,
                  subdivision_name =
                    stringi::stri_trans_general(subdivision_name, "Latin-ASCII")) %>%
    dplyr::filter(subdivision_name != subdivision_name_old) %>%
    dplyr::select(-subdivision_name_old) %>%
    dplyr::mutate(subdivision_name_type = paste(subdivision_name_type, "no_diacritic", sep="_"))

  if(merge)
    out <- dplyr::bind_rows(adf, out)

  out

}
