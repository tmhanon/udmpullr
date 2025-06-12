#' Set 'UDM' API credentials
#'
#' In order to access the 'UDM' API you must have an account registered with 'UDM'.
#' Visit (https://commoditymarkets.com/) for more information.
#'
#' This function provides one option for telling R your UDM credentials to use
#' within your current session. If you use the 'UDM' API regularly, a better option
#' is to use environmental variables to permanently set your credentials. Open or
#' create a .Renviron file using `usethis::edit_r_environ` and add
#' UDM_API_USERNAME="<your UDM email/username>" and UDM_API_PASSWORD="<your UDM password>"
#' on separate lines. Save the file (ensuring there is a blank line at the end of the
#' file) and restart R. Your 'UDM' API credentials will now be available to `udmpullr`
#' across R sessions.
#'
#' @param UDM_API_USERNAME Your email address registered with UDM
#' @param UDM_API_PASSWORD Your UDM password
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Set your UDM credentials
#' udm_credentials("<your UDM email/username>", "<your UDM password")
#'
#' # Retrieve UDM credentials
#' Sys.getenv("UDM_API_USERNAME")
#' Sys.getenv("UDM_API_PASSWORD")
#' }
udm_credentials <- function(UDM_API_USERNAME, UDM_API_PASSWORD){

  Sys.setenv("UDM_API_USERNAME" = UDM_API_USERNAME,
             "UDM_API_PASSWORD" = UDM_API_PASSWORD)

}
