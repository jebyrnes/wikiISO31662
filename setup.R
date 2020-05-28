library(devtools)
library(usethis)

use_r("utils")
use_r("globals")
use_r("scrape_subdivisions")
use_r("scrape_countries")
use_r("add_no_diacritic")
use_r("data")

use_package("dplyr")
use_package("tidyr")
use_package("rvest")
use_package("purrr")
use_package("data.table")
use_package("xml2")
use_package("magrittr")
use_package("stringi")

use_data_raw("wikipedia_scrape")
use_pipe(export = TRUE)

use_mit_license(name = "Jarrett Byrnes")
use_code_of_conduct()
