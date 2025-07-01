#' Set and retrieve 'UDM' API credentials
#'
#' Set your 'UDM' API username and password and retrieve them for use in API pulls.
#' In order to access the 'UDM' API you must have an account registered with 'UDM'.
#' Visit <https://commoditymarkets.com/> for more information.
#'
#' The `set_udm_credentials()` function provides one option for telling R your 'UDM' credentials
#' to use within the current session. Executing the `set_udm_credentials()` function without
#' specifying arguments will prompt you to enter your 'UDM' username/email and password using
#' the [askpass::askpass()] function. You may also specify your 'UDM' username/email and password as
#' arguments in `set_udm_credentials()`, but it is more secure to avoid entering credentials
#' into the R console as they will appear in the .Rhistory file.
#'
#' If you use the 'UDM' API regularly, a better option is to use environmental variables to
#' permanently set your credentials. Open or create a .Renviron file using
#' [usethis::edit_r_environ()] and add UDM_API_USERNAME="<your UDM email/username>" and
#' UDM_API_PASSWORD="<your UDM password>" on separate lines. Save the file (ensuring there
#' is a blank line at the end of the file) and restart R. Your 'UDM' API credentials will
#' now be available to [udmpullr()] across R sessions.
#'
#' The `get_udm_username()` and `get_udm_password()` functions will retrieve your 'UDM' API
#' username and password from the environmental variables (either set using the
#' `set_udm_credentials()` function or set in a .Renviron file), but these functions are
#' primarily used as default arguments in the [udmpullr()] function.
#'
#' @param UDM_API_USERNAME A character. Your email address registered with UDM.
#' @param UDM_API_PASSWORD A character. Your UDM password.
#'
#' @export
#'
#' @name udm_credentials
#'
#' @examples
#' \dontrun{
#' # Set your UDM credentials
#' set_udm_credentials("<your UDM email/username>", "<your UDM password>")
#'
#' # Retrieve UDM credentials
#' get_udm_username() # Will return an error if not set.
#' get_udm_password() # Will return an error if not set.
#' }
set_udm_credentials <- function(UDM_API_USERNAME = NULL, UDM_API_PASSWORD = NULL){

  # If username is not specified, prompt the user to enter it:
  if (is.null(UDM_API_USERNAME)) {
    UDM_API_USERNAME <- askpass::askpass("Please enter your UDM API username/email")
    Sys.setenv("UDM_API_USERNAME" = UDM_API_USERNAME)
  } else if (is.character(UDM_API_USERNAME)) {
    Sys.setenv("UDM_API_USERNAME" = UDM_API_USERNAME)
  } else {
    cli::cli_abort(c("{.arg UDM_API_USERNAME} must be a character vector.",
                     "x" = "You've supplied a {.cls {class(UDM_API_USERNAME)}} vector."))
  }

  # If password is not specified, prompt the user to enter it:
  if (is.null(UDM_API_PASSWORD)) {
    UDM_API_PASSWORD <- askpass::askpass("Please enter your UDM API password")
    Sys.setenv("UDM_API_PASSWORD" = UDM_API_PASSWORD)
  } else if (is.character(UDM_API_PASSWORD)) {
    Sys.setenv("UDM_API_PASSWORD" = UDM_API_PASSWORD)
  } else {
    cli::cli_abort(c("{.arg UDM_API_PASSWORD} must be a character vector.",
                     "x" = "You've supplied a {.cls {class(UDM_API_USERNAME)}} vector."))
  }

}


#' @export
#' @rdname udm_credentials
get_udm_username <- function() {
  # Retrieve username from environmental variables if already set
  username <- Sys.getenv("UDM_API_USERNAME")

  if (identical(Sys.getenv("TESTTHAT"), "true")) {
    return(httr2::secret_decrypt("rZDs3tqcTToVAuIVmJwHj-G7dFk8u2odlrmYpF0Uh1r-oc2_zQY",
                                 "UDMPULLR_KEY"))
  } else if (!identical(username, "")) {
    return(username)
  } else {
    cli::cli_abort(c("Can't find UDM API username.",
                     "i" = "Please supply with {.arg UDM_username} argument, set using the {.fun set_udm_credentials} function, or define a {.var UDM_API_USERNAME} environmental variable."))
  }

}

#' @export
#' @rdname udm_credentials
get_udm_password <- function() {
  # Retrieve password from environmental variables if already set
  password <- Sys.getenv("UDM_API_PASSWORD")

  if (identical(Sys.getenv("TESTTHAT"), "true")) {
    return(httr2::secret_decrypt("1oLFr_3eTNUd4-G_w8QrIX7WK-mKyD4q--KIyyO3",
                                 "UDMPULLR_KEY"))
  } else if (!identical(password, "")) {
    return(password)
  } else {
    cli::cli_abort(c("Can't find UDM API username.",
                     "i" = "Please supply with {.arg UDM_password} argument, set using the {.fun set_udm_credentials} function, or define a {.var UDM_API_PASSWORD} environmental variable."))
  }

}
