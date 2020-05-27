
# wikipedia URLs
baseurl <- "https://en.wikipedia.org"
url <- "https://en.wikipedia.org/wiki/ISO_3166-2"


# weird duplicate col names that bind_rows does not want
# from tables where some columns have two headers
fix_dup_names <- function(adf) {
  n <- names(adf)
  if (length(unique(n)) == length(n)) {
    return(adf)
  }
  names(adf) <- paste(n, 1:length(n), sep = "_")
  names(adf)[n == "Code"] <- "Code"
  adf[-1, ]
}

parse_one_page <- function(a_link, quiet = FALSE) {
  if (!quiet) print(a_link)
  xml2::read_html(paste0(baseurl, a_link)) %>%
    rvest::html_nodes("body table.wikitable.sortable") %>%
    rvest::html_table(fill = TRUE) %>%
    purrr::map(fix_dup_names) %>%
    data.table::rbindlist(fill = TRUE) %>% # used instead of bind_rows to deal with mixed classes
    dplyr::as_tibble() %>%
    dplyr::mutate(country_code = gsub("\\/wiki\\/ISO_3166-2\\:", "", a_link))
}


reshape_tab <- function(adf, quiet = FALSE) {
  if (!quiet) print(adf[1, ])
  adf %>%
    dplyr::mutate_all(as.character) %>% # sneaky integers sneaking in
    tidyr::pivot_longer(
      cols = !dplyr::matches("Code"),
      names_to = "subdivision_name_type",
      values_to = "subdivision_name"
    ) %>%
    dplyr::rename(code = Code)
}
