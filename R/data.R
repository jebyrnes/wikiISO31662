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

#' ISO 3166-2 Subdivision Codes from Wikipedia with Additional Modified Subdivisions
#'
#' Many different subdivision name datasets deviate from what is in the ISO standard.
#' This dataset seeks to provide a more comprehensive listing of names for easier
#' acquisition of standardized ISO 3166-2 subdivision codes via a merge or join operation.
#' Currently includes
#' \describe{
#'   \item{}{Names with no diacritics}
#'   }
#'
#' @format A data frame with 9720 rows and 4 variables:
#' \describe{
#'   \item{code}{The ISO 3166-2 Subdivision Code}
#'   \item{country_code}{The ISO 3166-2 Country Code of the country the subdivision is in}
#'   \item{subdivision_name_type}{The type of name (from Wikipedia column). Many
#'   subdivisions have their names in multiple languages}
#'   \item{subdivision_name}{The name of the subdivision in that type}
#' }
#' @source  \url{https://en.wikipedia.org/wiki/ISO_3166-2}
"iso_31662_subdivisions_extended"

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
