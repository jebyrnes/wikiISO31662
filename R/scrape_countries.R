#' Scrape ISO 3166-2 Country Codes from Wikipedia
#'
#'
#' @return A tibble of country codes and country names
#'
#' @export
#'
#' @references Wikipedia ISO-3166-2 Entry: \url{https://en.wikipedia.org/wiki/ISO_3166-2}
#'
#' @examples
#' \dontrun{
#' iso_countries <- scrape_countries()
#'
#' head(iso_countries)
#' }

scrape_countries <- function(){
  xml2::read_html(url) %>%
    rvest:: html_nodes("table") %>%
    `[`(1) %>% # first  table
    rvest::html_table() %>%
    `[[`(1) %>%
    dplyr::select(1:2) %>%
    dplyr::rename(country_code = `Entry(click to view codes)`,
                  country_name = `Country name (using title case)`) %>%
    dplyr::as_tibble()

}
