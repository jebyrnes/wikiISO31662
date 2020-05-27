## code to prepare `wikipedia_scrape` dataset goes here
library(wikiISO31662)

iso_31662_subdivisions <- scrape_subdivisions(quiet = FALSE)
iso_31662_countries <- scrape_countries()

usethis::use_data(iso_31662_subdivisions, overwrite = TRUE)
usethis::use_data(iso_31662_countries, overwrite = TRUE)
