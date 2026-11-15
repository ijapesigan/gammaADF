## ---- test-benchmark-gammaADF-gamma-adf-consistent
# Run by hand: bench is not part of the unit tests.
stopifnot(requireNamespace(package = "bench", quietly = TRUE))
lapply(
  X = c(3, 10, 20),
  FUN = function(k) {
    n <- 200
    d <- scale(
      x = matrix(data = stats::rnorm(n = n * k), nrow = n),
      center = TRUE,
      scale = FALSE
    )
    sigma <- crossprod(x = d) / n
    v <- sigma[lower.tri(x = sigma, diag = TRUE)]
    print(
      x = bench::mark(
        gammaADF:::.GammaADFConsistent(
          d = d,
          vechsigmacap_consistent = v,
          n = n
        ),
        iterations = 10
      )
    )
  }
)
