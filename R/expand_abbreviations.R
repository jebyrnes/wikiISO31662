#' Expand common abbreviations in names
#'
#' @param adf A data frame with a `subdivision_name` column
#' @param merge Merge with the previous data? Defaults to TRUE
#'
#' @return A tibble of information of codes in the same format as \code{\link{iso_31662_subdivisions}}
#' @export
#'
#' @examples
#' \dontrun{
#' iso_31662_subdivisions_expanded <- expand_abbreviations(iso_31662_subdivisions)
#'
#' }
expand_abbreviations <- function(adf, merge = TRUE){

  out <- adf %>%
    dplyr::mutate(
      subdivision_name_old = subdivision_name,
      subdivision_name = gsub("St\\.", "Saint", subdivision_name),
    ) %>%
    dplyr::filter(subdivision_name != subdivision_name_old) %>%
    dplyr::select(-subdivision_name_old) %>%
    dplyr::mutate(subdivision_name_type = paste(subdivision_name_type, "cleaned", sep="_"))

  if(merge)
    out <- dplyr::bind_rows(adf, out)

  out

}
