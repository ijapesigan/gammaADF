# Shared test helpers (testthat sources helper-*.R before the tests).
# rProject writes this file once; it is yours after that.

# Slow tests: run on CI and on request, skipped in local builds and on CRAN.
.SkipSlow <- function() {
  testthat::skip_on_cran()
  testthat::skip_if_not(
    condition = Sys.getenv(x = "CI") == "true" ||
      Sys.getenv(x = "RPROJECT_SLOW_TESTS") == "true",
    message = "set RPROJECT_SLOW_TESTS=true to run slow tests"
  )
}

# Proprietary software: never on CI or CRAN, and only where it is found.
.SkipIfMissing <- function(program) {
  testthat::skip_on_cran()
  testthat::skip_on_ci()
  testthat::skip_if(
    condition = Sys.which(names = program) == "",
    message = paste0(program, " is not installed")
  )
}

# Deviation scores of n draws of k standard normal variables.
.GammaADFDeviation <- function(n,
                               k) {
  scale(
    x = matrix(
      data = stats::rnorm(n = n * k),
      nrow = n
    ),
    center = TRUE,
    scale = FALSE
  )
}

# Reference: fourth moments minus products of second moments, with loops.
.GammaADFReference <- function(d) {
  k <- ncol(x = d)
  pairs <- which(
    x = lower.tri(x = diag(x = k), diag = TRUE),
    arr.ind = TRUE
  )
  q <- nrow(x = pairs)
  out <- matrix(data = 0, nrow = q, ncol = q)
  for (a in seq_len(length.out = q)) {
    for (b in seq_len(length.out = q)) {
      ia <- pairs[a, 1]
      ja <- pairs[a, 2]
      ib <- pairs[b, 1]
      jb <- pairs[b, 2]
      out[a, b] <- mean(x = d[, ia] * d[, ja] * d[, ib] * d[, jb]) -
        mean(x = d[, ia] * d[, ja]) * mean(x = d[, ib] * d[, jb])
    }
  }
  out
}
