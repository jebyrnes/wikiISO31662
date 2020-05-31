#' Scrape ISO 3166-2 Subdivision Codes from https://github.com/hyperknot/country-levels
#'
#'
#' @return A tibble of information of codes, types of names for a subdivision in
#' Wikipedia, and it's name.
#'
#' @export
#'
#' @references \url{https://github.com/hyperknot/country-levels}
#'
#' @examples
#' \dontrun{
#' iso_sub <- scrape_hyperknot()
#'
#' head(scrape_hyperknot)
#' }
scrape_hyperknot <- function(){
  #combines
  # https://www.openstreetmap.org/relation/
  # https://www.wikidata.org/wiki/
  # http://en.wikipedia.org/wiki/

  hyperknot_url <- "https://github.com/hyperknot/country-levels/releases/download/v2.2.0/export_json.tgz"
  f <- tempfile()
  utils::download.file(hyperknot_url, f, quiet=TRUE)
  utils::untar(f)
  unlink(f)

  #load files
  iso1 <- jsonlite::fromJSON("iso1.json")
  iso2 <- jsonlite::fromJSON("iso2.json")

  #remove files
  unlink(c("iso1.json", "fips.json", "iso2.json"))

  #make data frames

  iso1 <- purrr::map_dfr(iso1, as_tibble, .id = "country_code")
  iso2 <- purrr::map_dfr(iso2, as_tibble, .id = "code")


  #create something to return
  iso2 %>%
    dplyr::rename(subdivision_name = name) %>%
    mutate(subdivision_name_type = "github_hyperknot_country-levels",
           country_code = gsub("(^..)(-.*)", "\\1", subdivision_name)) %>%
    dplyr::select(code, country_code, subdivision_name_type, subdivision_name)

}


