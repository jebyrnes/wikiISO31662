#' Create Clean Subdivision Names without Additional Regional Specifications
#'
#' @param adf A data frame with a `subdivision_name` column
#' @param merge Merge with the previous data? Defaults to TRUE
#'
#' @return A tibble of information of codes in the same format as \code{\link{iso_31662_subdivisions}}
#' @export
#'
#' @examples
#' \dontrun{
#' iso_31662_subdivisions_clean <- clean_subdivisions(iso_31662_subdivisions)
#'
#' }
clean_subdivisions <- function(adf, merge = TRUE){

  out <- adf %>%
    dplyr::mutate(
      subdivision_name_old = subdivision_name,
      subdivision_name = gsub("State of ", "", subdivision_name),
      subdivision_name = gsub("City of ", "", subdivision_name),
      subdivision_name = gsub(" City", "", subdivision_name),
      subdivision_name = gsub(" Region$", "", subdivision_name),
      subdivision_name = gsub(" County$", "", subdivision_name),
      subdivision_name = gsub("^County ", "", subdivision_name),
      subdivision_name = gsub(" Governorate$", "", subdivision_name),
      subdivision_name = gsub(" District$", "", subdivision_name),
      subdivision_name = gsub(" Voivodeship$", "", subdivision_name),
      subdivision_name = gsub(" Council$", "", subdivision_name),
      subdivision_name = gsub(" Department$", "", subdivision_name),
      subdivision_name = gsub(" Parish$", "", subdivision_name),
      subdivision_name = gsub(" Municipality$", "", subdivision_name),
      subdivision_name = gsub("s novads$", "", subdivision_name),
      subdivision_name = gsub(" Province$", "", subdivision_name),
      subdivision_name = gsub(" \\(de\\)", "", subdivision_name),
      subdivision_name = gsub("^Kanton )", "", subdivision_name),
      subdivision_name = gsub("^\\'", "", subdivision_name),
      subdivision_name = gsub("-Capital$", "", subdivision_name)
    ) %>%
    dplyr::filter(subdivision_name != subdivision_name_old) %>%
    dplyr::select(-subdivision_name_old) %>%
    dplyr::mutate(subdivision_name_type = paste(subdivision_name_type, "cleaned", sep="_"))

  if(merge)
    out <- dplyr::bind_rows(adf, out)

  out

}
