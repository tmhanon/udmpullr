udmpullr <- function(table_name,
                     product_name = NULL,
                     start_date = NULL,
                     end_date = NULL,
                     company_feed = "Universal") {

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
        adjusted_start_date <- ymd(start_date) - days(x = 1)

        reformat_start_date <- format(as.Date(adjusted_start_date), "%Y-%m-%dT%H:%M:%OSZ")

        query <- paste0(basic_query,
                        "$format=json&$filter=",
                        "Product_Name eq '", product_name, "'",
                        " and Report_Period gt ", reformat_start_date)

        # If both a start date and an end date are given:
      } else if (!is.null(start_date) & !is.null(end_date)) {
        adjusted_start_date <- ymd(start_date) - days(x = 1)

        reformat_start_date <- format(as.Date(adjusted_start_date), "%Y-%m-%dT%H:%M:%OSZ")

        adjusted_end_date <- ymd(end_date) + days(x = 1)

        reformat_end_date <- format(as.Date(adjusted_end_date), "%Y-%m-%dT%H:%M:%OSZ")

        query <- paste0(basic_query,
                        "$format=json&$filter=",
                        "Product_Name eq '", product_name, "'",
                        " and Report_Period gt ", reformat_start_date,
                        " and Report_Period lt ", reformat_end_date)

        # If an end date is given but the start date is null:
      } else if (is.null(start_date) & ! is.null(end_date)) {
        adjusted_end_date <- ymd(end_date) + days(x = 1)

        reformat_end_date <- format(as.Date(adjusted_end_date), "%Y-%m-%dT%H:%M:%OSZ")

        query <- paste0(basic_query,
                        "$format=json&$filter=",
                        "Product_Name eq '", product_name, "'",
                        " and Report_Period lt ", reformat_end_date)
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
        adjusted_start_date <- ymd(start_date) - days(x = 1)

        reformat_start_date <- format(as.Date(adjusted_start_date), "%Y-%m-%dT%H:%M:%OSZ")

        query <- paste0(basic_query,
                        "$format=json&$filter=",
                        "Report_Period gt ", reformat_start_date)

        # If both a start date and an end date are given:
      } else if (!is.null(start_date) & !is.null(end_date)) {
        adjusted_start_date <- ymd(start_date) - days(x = 1)

        reformat_start_date <- format(as.Date(adjusted_start_date), "%Y-%m-%dT%H:%M:%OSZ")

        adjusted_end_date <- ymd(end_date) + days(x = 1)

        reformat_end_date <- format(as.Date(adjusted_end_date), "%Y-%m-%dT%H:%M:%OSZ")

        query <- paste0(basic_query,
                        "$format=json&$filter=",
                        "Report_Period gt ", reformat_start_date,
                        " and Report_Period lt ", reformat_end_date)

        # If an end date is given but the start date is null:
      } else {
        adjusted_end_date <- ymd(end_date) + days(x = 1)

        reformat_end_date <- format(as.Date(adjusted_end_date), "%Y-%m-%dT%H:%M:%OSZ")

        query <- paste0(basic_query,
                        "$format=json&$filter=",
                        "Report_Period lt ", reformat_end_date)
      }
    }

  }

  url <- GET(URLencode(query),
             authenticate(user = Sys.getenv("UDM_API_USERNAME"),Sys.getenv("UDM_API_PASSWORD")))

  content <- fromJSON(content(url, "text", encoding = "UTF-8"))

  data <- content$value

}
