## ---- test-gammaADF-gamma-adf-unbiased-dot
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    message(text)

    testthat::test_that(
      desc = paste(text, "k = 1 known value"),
      code = {
        n <- 10
        # Worked by hand from the formula.
        testthat::expect_equal(
          object = gammaADF:::.GammaADFUnbiased(
            gammacapadf_consistent = matrix(data = 2),
            gammacapmvn_consistent = matrix(data = 3),
            vechsigmacap_consistent = 0.5,
            n = n
          ),
          expected = matrix(
            data = (90 / 56) * 2 - (10 / 56) * (3 - (2 / 9) * 0.25)
          )
        )
      }
    )

    testthat::test_that(
      desc = paste(text, "the normal-theory part cancels at its expectation"),
      code = {
        lapply(
          X = 2:3,
          FUN = function(k) {
            set.seed(seed = k)
            n <- 30
            q <- k * (k + 1) / 2
            d <- .GammaADFDeviation(n = n, k = k)
            sigma <- crossprod(x = d) / n
            vechsigma <- sigma[lower.tri(x = sigma, diag = TRUE)]
            adf <- gammaADF:::.GammaADFConsistent(
              d = d,
              vechsigmacap_consistent = vechsigma,
              n = n
            )
            mvn <- (2 / (n - 1)) * tcrossprod(x = vechsigma)
            out <- gammaADF:::.GammaADFUnbiased(
              gammacapadf_consistent = adf,
              gammacapmvn_consistent = mvn,
              vechsigmacap_consistent = vechsigma,
              n = n
            )
            testthat::expect_equal(
              object = out,
              expected = (n * (n - 1) / ((n - 2) * (n - 3))) * adf
            )
            testthat::expect_equal(
              object = dim(x = out),
              expected = c(q, q)
            )
          }
        )
      }
    )

    testthat::test_that(
      desc = paste(text, "n <= 3 is not finite"),
      code = {
        out <- gammaADF:::.GammaADFUnbiased(
          gammacapadf_consistent = matrix(data = 1),
          gammacapmvn_consistent = matrix(data = 1),
          vechsigmacap_consistent = 1,
          n = 3
        )
        testthat::expect_false(
          object = is.finite(x = out)
        )
      }
    )
  },
  text = "test-gammaADF-gamma-adf-unbiased-dot"
)
