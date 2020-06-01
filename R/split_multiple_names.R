#,
#|
split_multiple_names <- function(adf){
  out <- adf %>%
    dplyr::filter(grepl("[,|]| \\/ ", subdivision_name)) %>%
    dplyr::mutate(subdivision_name = gsub("\\, ", "\\,", subdivision_name),
                  subdivision_name = gsub(" \\([a-z][a-z]\\)", "", subdivision_name),
                  subdivision_name = gsub(" \\(|\\)", "", subdivision_name)
    ) #prep


  # some of these are just reversed names with commas - pull those out
  # and do the reversing
  for_reverse <- out %>%
    rowwise() %>% #OH NOES! Yes, I'm doing it - for now
    dplyr::mutate(subdivision_name = purrr::map(subdivision_name, split_names_df, split = "[,]")) %>%
    tidyr::unnest(subdivision_name)%>%
    dplyr::group_by(country_code, subdivision_name) %>% #country, as some are spread across
    dplyr::count() %>%
    dplyr::ungroup() %>%
    dplyr::arrange(desc(n)) %>%
    filter(n > 1,
           !grepl("\\|", subdivision_name)) %>% #so, repeats only!
    dplyr::pull(subdivision_name)

  out_rev <- out %>%
    dplyr::mutate(
      subdivision_name_old = subdivision_name, #) %>%
      subdivision_name = stringr::str_replace(subdivision_name,
                                              paste0("(.*),(",paste0(for_reverse, collapse = "|"), ")"),
                                              "\\2 \\1")) %>%
    dplyr::filter(subdivision_name != subdivision_name_old) %>%
    select(-subdivision_name_old)

  #for everything else, one row per name
  out <- out %>%
   # rowwise() %>% #OH NOES! Yes, I'm doing it - for now
    dplyr::mutate(subdivision_name = purrr::map(subdivision_name, split_names_df)) %>%
    tidyr::unnest(cols = subdivision_name) %>%
    filter(!(subdivision_name %in% for_reverse)) #get rid of cruft

  #return combined
  bind_rows(out, out_rev, adf)

}

split_names_df <- function(.x, split = "[,|]| \\/ "){
  data.frame(subdivision_name =
               strsplit(.x, split = split)[[1]])
}
