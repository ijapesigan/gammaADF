## ---- test-gammaADF-gamma-adf-consistent-dot
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    message(text)

    testthat::test_that(
      desc = paste(text, "k = 1 known value"),
      code = {
        d <- matrix(data = c(-1, 0, 1), ncol = 1)
        # The fourth moment 2 / 3 minus the squared variance (2 / 3)^2.
        testthat::expect_equal(
          object = gammaADF:::.GammaADFConsistent(
            d = d,
            vechsigmacap_consistent = 2 / 3,
            n = 3
          ),
          expected = matrix(data = 2 / 9)
        )
      }
    )

    testthat::test_that(
      desc = paste(text, "k = 2 and 3 agree with the fourth-moment formula"),
      code = {
        lapply(
          X = 2:3,
          FUN = function(k) {
            set.seed(seed = k)
            n <- 25
            d <- .GammaADFDeviation(n = n, k = k)
            sigma <- crossprod(x = d) / n
            vechsigma <- sigma[lower.tri(x = sigma, diag = TRUE)]
            out <- gammaADF:::.GammaADFConsistent(
              d = d,
              vechsigmacap_consistent = vechsigma,
              n = n
            )
            testthat::expect_equal(
              object = out,
              expected = .GammaADFReference(d = d)
            )
            q <- k * (k + 1) / 2
            testthat::expect_equal(
              object = dim(x = out),
              expected = c(q, q)
            )
            testthat::expect_true(
              object = isSymmetric(object = out)
            )
            eigenvalues <- eigen(
              x = out,
              symmetric = TRUE,
              only.values = TRUE
            )$values
            testthat::expect_true(
              object = all(eigenvalues > -1e-08)
            )
          }
        )
      }
    )

    testthat::test_that(
      desc = paste(text, "n = 1 gives zero"),
      code = {
        d <- matrix(data = c(1, 2), nrow = 1)
        v <- c(1, 2, 4)
        # the sum is vech(dd') vech(dd')', the subtraction the same: zero
        testthat::expect_equal(
          object = gammaADF:::.GammaADFConsistent(
            d = d,
            vechsigmacap_consistent = v,
            n = 1
          ),
          expected = matrix(data = 0, nrow = 3, ncol = 3)
        )
      }
    )
  },
  text = "test-gammaADF-gamma-adf-consistent-dot"
)
