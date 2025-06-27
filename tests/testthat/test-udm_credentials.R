test_that("Can set and retrieve credentials", {

  set_udm_credentials(UDM_API_USERNAME = httr2::secret_decrypt("rZDs3tqcTToVAuIVmJwHj-G7dFk8u2odlrmYpF0Uh1r-oc2_zQY",
                                                               "UDMPULLR_KEY"),
                      UDM_API_PASSWORD = httr2::secret_decrypt("1oLFr_3eTNUd4-G_w8QrIX7WK-mKyD4q--KIyyO3",
                                                               "UDMPULLR_KEY"))

  expect_equal(Sys.getenv("UDM_API_USERNAME"), httr2::secret_decrypt("rZDs3tqcTToVAuIVmJwHj-G7dFk8u2odlrmYpF0Uh1r-oc2_zQY",
                                                                     "UDMPULLR_KEY"))
  expect_equal(Sys.getenv("UDM_API_PASSWORD"), httr2::secret_decrypt("1oLFr_3eTNUd4-G_w8QrIX7WK-mKyD4q--KIyyO3",
                                                                     "UDMPULLR_KEY"))

  user <- get_udm_username()

  expect_equal(user, httr2::secret_decrypt("rZDs3tqcTToVAuIVmJwHj-G7dFk8u2odlrmYpF0Uh1r-oc2_zQY",
                                           "UDMPULLR_KEY"))

  pass <- get_udm_password()

  expect_equal(pass, httr2::secret_decrypt("1oLFr_3eTNUd4-G_w8QrIX7WK-mKyD4q--KIyyO3",
                                           "UDMPULLR_KEY"))


})

test_that("set_udm_credentials errors if a non-character argument is supplied", {

  expect_error(set_udm_credentials(UDM_API_USERNAME = 1234,
                                   UDM_API_PASSWORD = 4567),
               regexp = "`UDM_API_USERNAME` must be a character vector.")

})
