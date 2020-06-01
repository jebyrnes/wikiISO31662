## code to prepare `wikipedia_scrape` dataset goes here
library(wikiISO31662)
library(dplyr)

iso_31662_subdivisions <- scrape_subdivisions(quiet = FALSE)
iso_31662_countries <- scrape_countries()


iso_31662_subdivisions_extended <- iso_31662_subdivisions %>%
  bind_rows(scrape_iso_3166_2_js()) %>%
  bind_rows(scrape_rnaturalearth()) %>%
  bind_rows(scrape_hyperknot()) %>%
  expand_abbreviations() %>%
  split_multiple_names() %>%
  clean_subdivisions() %>%
  add_no_diacritic() %>%
  group_by(code, country_code, subdivision_name) %>%
  slice(1L) %>%
  ungroup()

usethis::use_data(iso_31662_subdivisions, overwrite = TRUE)
usethis::use_data(iso_31662_subdivisions_extended, overwrite = TRUE)
usethis::use_data(iso_31662_countries, overwrite = TRUE)

# for a csv
readr::write_csv(iso_31662_subdivisions, here::here("data-raw", "iso_31662_subdivisions.csv"))
readr::write_csv(iso_31662_subdivisions_extended, here::here("data-raw", "iso_31662_subdivisions_extended.csv"))
readr::write_csv(iso_31662_countries, here::here("data-raw", "iso_31662_countries"))
