## code to prepare `wikipedia_scrape` dataset goes here
library(wikiISO31662)

iso_31662_subdivisions <- scrape_subdivisions(quiet = FALSE)
iso_31662_countries <- scrape_countries()


iso_31662_subdivisions_extended <- iso_31662_subdivisions %>%
  add_no_diacritic() %>%
  clean_subdivisions()

usethis::use_data(iso_31662_subdivisions, overwrite = TRUE)
usethis::use_data(iso_31662_subdivisions_extended, overwrite = TRUE)
usethis::use_data(iso_31662_countries, overwrite = TRUE)

# for a csv
readr::write_csv(iso_31662_subdivisions, here::here("data-raw", "iso_31662_subdivisions.csv"))
readr::write_csv(iso_31662_countries, here::here("data-raw", "iso_31662_countries"))
