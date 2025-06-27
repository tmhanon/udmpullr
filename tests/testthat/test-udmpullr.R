test_that("A warning is issued when more than 10,000 rows of data are pulled.", {

  expect_warning(udmpullr(table_name = "UDM_Report_Futures_Prices_Daily_Panel"),
                 regexp = "Your data contains 10,000 rows.")

})
