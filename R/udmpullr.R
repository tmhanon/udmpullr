#' Pull tables from 'UDM' API
#'
#' Use this function to pull tables from the 'UDM' API.
#'
#' @param table_name Name of the table you want to pull
#' @param product_name Name of a specific product to filter for (if Product_Name is a variable in the table)
#' @param start_date Earliest date to include in the dataset
#' @param end_date Latest date to include in the dataset
#' @param company_feed Your company feed for 'UDM' (if applicable). Default is "Universal"
#' @param UDM_username Your email address registered with UDM (will be retrieved by [get_udm_username()] by default)
#' @param UDM_password Your UDM password (will be retrieved by [get_udm_password()] by default)
#'
#' @return A tibble
#' @export
#'
#' @examples
#' \dontrun{
#' udmpullr(table_name = "UDM_Report_CME_Dairy_Spot_Market_Overview_Daily")
#' }
udmpullr <- function(table_name,
                     product_name = NULL,
                     start_date = NULL,
                     end_date = NULL,
                     company_feed = "Universal",
                     UDM_username = get_udm_username(),
                     UDM_password = get_udm_password()) {

  basic_query <- paste0("https://data.commoditymarkets.com/", company_feed, "/", table_name, "?")

  # This section of if-else statements checks whether the filter arguments have values and constructs the URL query accordingly.

  # First check whether all filter arguments are null. If so, use the basic query defined above.
  if (is.null(product_name) & is.null(start_date) & is.null(end_date)) {
    query <- basic_query
  } else {
    # Next check whether a product name is specified. If so, do the following:
    if (!is.null(product_name)) {
      # If a start date is given but the end date is null:
      if (!is.null(start_date) & is.null(end_date)) {
        reformat_start_date <- start_date %>%
          lubridate::parse_date_time(orders = c("ymd", "dmy")) %>%
          format("%Y-%m-%dT%H:%M:%OSZ")

        query <- paste0(basic_query,
                        "$format=json&$filter=",
                        "Product_Name eq '", product_name, "'",
                        " and Report_Period ge ", reformat_start_date)

        # If both a start date and an end date are given:
      } else if (!is.null(start_date) & !is.null(end_date)) {
        reformat_start_date <- start_date %>%
          lubridate::parse_date_time(orders = c("ymd", "dmy")) %>%
          format("%Y-%m-%dT%H:%M:%OSZ")

        reformat_end_date <- end_date %>%
          lubridate::parse_date_time(orders = c("ymd", "dmy")) %>%
          format("%Y-%m-%dT%H:%M:%OSZ")

        query <- paste0(basic_query,
                        "$format=json&$filter=",
                        "Product_Name eq '", product_name, "'",
                        " and Report_Period ge ", reformat_start_date,
                        " and Report_Period le ", reformat_end_date)

        # If an end date is given but the start date is null:
      } else if (is.null(start_date) & ! is.null(end_date)) {
        reformat_end_date <- end_date %>%
          lubridate::parse_date_time(orders = c("ymd", "dmy")) %>%
          format("%Y-%m-%dT%H:%M:%OSZ")

        query <- paste0(basic_query,
                        "$format=json&$filter=",
                        "Product_Name eq '", product_name, "'",
                        " and Report_Period le ", reformat_end_date)
        # If neither a start date or an end date is given:
      } else {
        query <- paste0(basic_query,
                        "$format=json&$filter=",
                        "Product_Name eq '", product_name, "'")
      }
      # If no product name is specified, do the following:
    } else {
      # If a start date is given but the end date is null:
      if (!is.null(start_date) & is.null(end_date)) {
        reformat_start_date <- start_date %>%
          lubridate::parse_date_time(orders = c("ymd", "dmy")) %>%
          format("%Y-%m-%dT%H:%M:%OSZ")

        query <- paste0(basic_query,
                        "$format=json&$filter=",
                        "Report_Period ge ", reformat_start_date)

        # If both a start date and an end date are given:
      } else if (!is.null(start_date) & !is.null(end_date)) {
        reformat_start_date <- start_date %>%
          lubridate::parse_date_time(orders = c("ymd", "dmy")) %>%
          format("%Y-%m-%dT%H:%M:%OSZ")

        reformat_end_date <- end_date %>%
          lubridate::parse_date_time(orders = c("ymd", "dmy")) %>%
          format("%Y-%m-%dT%H:%M:%OSZ")

        query <- paste0(basic_query,
                        "$format=json&$filter=",
                        "Report_Period ge ", reformat_start_date,
                        " and Report_Period le ", reformat_end_date)

        # If an end date is given but the start date is null:
      } else {
        reformat_end_date <- end_date %>%
          lubridate::parse_date_time(orders = c("ymd", "dmy")) %>%
          format("%Y-%m-%dT%H:%M:%OSZ")

        query <- paste0(basic_query,
                        "$format=json&$filter=",
                        "Report_Period le ", reformat_end_date)
      }
    }

  }

  # Construct request
  req <- utils::URLencode(query) %>%
    httr2::request() %>%
    httr2::req_auth_basic(username = UDM_username,
                          password = UDM_password)

  # Execute request
  resp <- req %>%
    httr2::req_perform()

  # Convert response to user-friendly data
  data <- resp %>%
    httr2::resp_body_json() %>%
    purrr::pluck("value") %>%
    purrr::map(~ purrr::modify_if(.x, is.null, ~ NA)) %>%
    dplyr::bind_rows()

  data

}
