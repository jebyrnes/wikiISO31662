#' ISO 3166-2 Subdivision Codes from Wikipedia
#'
#' A dataset many variations of subdivision names and their accompanying ISO 3166 2 codes
#'
#' @format A data frame with 7784 rows and 4 variables:
#' \describe{
#'   \item{code}{The ISO 3166-2 Subdivision Code}
#'   \item{country_code}{The ISO 3166-2 Country Code of the country the subdivision is in}
#'   \item{subdivision_name_type}{The type of name (from Wikipedia column). Many
#'   subdivisions have their names in multiple languages}
#'   \item{subdivision_name}{The name of the subdivision in that type}
#' }
#' @source  \url{https://en.wikipedia.org/wiki/ISO_3166-2}
"iso_31662_subdivisions"

#' ISO 3166-2 Country Codes from Wikipedia
#'
#' A dataset of country names and their accompanying ISO 3166 2 codes scraped from
#' Wikipedia
#'
#' @format A data frame with 249 rows and 2 variables:
#' \describe{
#'   \item{country_code}{The ISO 3166-2 Country Code of that nation}
#'   \item{country_name}{The name of the country (english)}
#'   ...
#' }
#' @source  \url{https://en.wikipedia.org/wiki/ISO_3166-2}
"iso_31662_countries"
