#' Helper function to return error message to 'udmpullr'
#'
#' @param resp A httr2 response object
#'
#' @returns A message for use in `httr2::req_error`
udm_error_body <- function(resp) {
  type <- httr2::resp_content_type()

  if (type == "application/json") {
    resp %>%
      httr2::resp_body_json() %>%
      .$error %>%
      .$message
  } else if(type == "text/html") {
    resp %>%
      httr2::resp_body_html() %>%
      .$error %>%
      .$message
  } else {
    NULL
  }

}
