% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/udm_credentials.R
\name{udm_credentials}
\alias{udm_credentials}
\alias{set_udm_credentials}
\alias{get_udm_username}
\alias{get_udm_password}
\title{Set and retrieve 'UDM' API credentials}
\usage{
set_udm_credentials(UDM_API_USERNAME = NULL, UDM_API_PASSWORD = NULL)

get_udm_username()

get_udm_password()
}
\arguments{
\item{UDM_API_USERNAME}{Your email address registered with UDM}

\item{UDM_API_PASSWORD}{Your UDM password}
}
\description{
Set your 'UDM' API username and password and retrieve them for use in API pulls.
In order to access the 'UDM' API you must have an account registered with 'UDM'.
Visit \url{https://commoditymarkets.com/} for more information.
}
\details{
The \code{set_udm_credentials()} function provides one option for telling R your 'UDM' credentials
to use within the current session. Executing the \code{set_udm_credentials()} function without
specifying arguments will prompt you to enter your 'UDM' username/email and password using
the \code{\link[askpass:askpass]{askpass::askpass()}} function. You may also specify your 'UDM' username/email and password as
arguments in \code{set_udm_credentials()}, but it is more secure to avoid entering credentials
into the R console as they will appear in the .Rhistory file.

If you use the 'UDM' API regularly, a better option is to use environmental variables to
permanently set your credentials. Open or create a .Renviron file using
\code{\link[usethis:edit]{usethis::edit_r_environ()}} and add UDM_API_USERNAME="<your UDM email/username>" and
UDM_API_PASSWORD="\if{html}{\out{<your UDM password>}}" on separate lines. Save the file (ensuring there
is a blank line at the end of the file) and restart R. Your 'UDM' API credentials will
now be available to \code{\link[=udmpullr]{udmpullr()}} across R sessions.

The \code{get_udm_username()} and \code{get_udm_password()} functions will retrieve your 'UDM' API
username and password from the environmental variables (either set using the
\code{set_udm_credentials()} function or set in a .Renviron file), but these functions are
primarily used as default arguments in the \code{\link[=udmpullr]{udmpullr()}} function.
}
\examples{
\dontrun{
# Set your UDM credentials
set_udm_credentials("<your UDM email/username>", "<your UDM password>")

# Retrieve UDM credentials
get_udm_username() # Will return an error if not set.
get_udm_password() # Will return an error if not set.
}
}
