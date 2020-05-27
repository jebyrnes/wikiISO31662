#' Scrape ISO 3166-2 Subdivision Codes from Wikipedia
#'
#' @param quiet Should the debug information be quieted? Defaults to TRUE.
#'
#' @return A tibble of information of codes, types of names for a subdivision in
#' Wikipedia, and it's name.
#'
#' @export
#'
#' @references Wikipedia ISO-3166-2 Entry: \url{https://en.wikipedia.org/wiki/ISO_3166-2}
#'
#' @examples
#' \dontrun{
#' iso_sub <- scrape_subdivisions()
#'
#' head(iso_sub)
#' }
scrape_subdivisions <- function(quiet = TRUE){

  # get the tables from which spring links!
  links <- xml2::read_html(url) %>%
    rvest:: html_nodes("table") %>%
    `[`(1) %>% # first  table
    rvest::html_nodes("tr") %>%
    rvest::html_nodes("a") %>%
    rvest::html_attr("href") %>%
    grep("ISO_3166", ., value = TRUE)

  #get tables
  tabs <- purrr::map(links, parse_one_page, quiet = quiet)
  tabs <- purrr::discard(tabs, ~ nrow(.x) == 0)
  iso_df <- purrr::map_df(tabs, reshape_tab, quiet = quiet)

  #format table

  # fix missing codes
  iso_df_filtered <- iso_df %>%
    dplyr::filter(!is.na(subdivision_name)) %>%
    dplyr::mutate(
      code = ifelse(is.na(code), `Former code`, code),
      code = ifelse(is.na(code), `Alternative code`, code),
      code = ifelse(is.na(code), `Netherlands ISO 3166-2 code`, code)
    ) %>%
    # get rid of dups with no code
    dplyr::group_by(subdivision_name, country_code) %>%
    dplyr::filter(!is.na(code)) %>%
    dplyr::ungroup() %>%
    # get rid of duplicate rows
    dplyr::group_by(code, subdivision_name, country_code) %>%
    dplyr::slice(1L) %>%
    dplyr::ungroup() %>%
    # sift down
    dplyr::select(code, country_code, subdivision_name_type, subdivision_name) %>%
    dplyr::filter(grepl("[n,N]ame", subdivision_name_type) | subdivision_name_type== "Local variant")

  iso_df_filtered
}
