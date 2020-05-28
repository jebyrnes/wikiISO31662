#' Get the ISO 3166 2 Subdivision Table from iso-3166-2.js
#'
#' @return
#' @reference \url{https://github.com/olahol/iso-3166-2.js/}
#' @export
#'
#' @examples
#' \dontrun{
#' scrape_iso_3166_2_js() %>%
#'     head()
#' }
scrape_iso_3166_2_js <- function(){

    out <- readr::read_csv("https://github.com/olahol/iso-3166-2.js/raw/master/data.csv",
                    col_names = c(
                      "Country",
                      "iso_3166_2",
                      "name",
                      "type",
                      "Country iso_3166_2"
                    ),
                    col_types = "ccccc"
    )

    out %>%
      dplyr::rename(code = iso_3166_2,
             country_code = `Country iso_3166_2`,
             subdivision_name = name) %>%
      dplyr::mutate(subdivision_name_type = "iso-3166-2.js") %>%
      dplyr::select(-Country, -type)

}
