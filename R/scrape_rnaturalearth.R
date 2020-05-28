#' Scrape ISO 3166-2 Subdivision Codes from RNaturalearth
#'
#' Uses the ropensci rnaturalearth package to get moar ISO 3166-2 codes
#'
#'
#' @return A tibble of information of codes, types of names for a subdivision in
#' in the same column format as iso_31662_subdivisions
#'
#' @export
#'
#' @references \url{https://www.naturalearthdata.com/}
#' @references \url{https://github.com/ropensci/rnaturalearth}
#'
#' @examples
#' \dontrun{
#' iso_rinat <- scrape_rnaturalearth()
#'
#' head(iso_rinat)
#' }
scrape_rnaturalearth <- function(){
  rnat <- rnaturalearth::ne_states(returnclass = "sf") %>%
    dplyr::as_tibble() %>%
    dplyr::select(-geometry)

  #reshape names with tidyr
  rnat_reshape  <- rnat %>%
    dplyr::select(iso_3166_2, iso_a2, dplyr::contains("name"), -name_len) %>%
    tidyr::pivot_longer(cols = dplyr::contains("name"),
                 names_to = "subdivision_name_type",
                 values_to = "subdivision_name") %>%
    dplyr::rename(code = iso_3166_2, country_code = iso_a2) %>%
    dplyr::mutate(subdivision_name_type =
                    paste(subdivision_name_type, "rnaturalearth", sep = "_")) %>%
    dplyr::filter(!is.na(subdivision_name))

  rnat_reshape
}
