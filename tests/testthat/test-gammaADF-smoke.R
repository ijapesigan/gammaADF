## ---- test-gammaADF-smoke
# The one test file that runs on CRAN: fast; checks that the package loads.
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::test_that(
      desc = paste(text, "the package loads"),
      code = {
        testthat::expect_true(
          object = requireNamespace(package = "gammaADF", quietly = TRUE)
        )
      }
    )
  },
  text = "test-gammaADF-smoke"
)
