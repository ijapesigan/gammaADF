# gammaADF: Asymptotic Distribution-Free Covariance Matrix of the Sample Covariance Matrix

## Description

Asymptotic covariance matrix of the half-vectorization of the sample
covariance matrix in R (R Core Team, 2026) without a distributional
assumption (asymptotic distribution free): the consistent estimator and
its unbiased version. The functions are internal; other projects can
copy them.

## Installation

You can install the development version of `gammaADF` from
[GitHub](https://github.com/ijapesigan/gammaADF) with:

\
`if`` ``(``!`[`require`](https://rdrr.io/r/base/library.html)`(`[`"pak"`](https://pak.r-lib.org/)`)``)`` `[`install.packages`](https://rdrr.io/r/utils/install.packages.html)`(``"pak"``)`\
`pak``::`[`pkg_install`](https://pak.r-lib.org/reference/pkg_install.html)`(``"ijapesigan/gammaADF"``)`

## Example

The functions are internal: call them with `gammaADF:::` or copy them
into your project.

\
[`set.seed`](https://rdrr.io/r/base/Random.html)`(``seed ``=`` ``42``)`\
`x`` ``<-`` `[`matrix`](https://rdrr.io/r/base/matrix.html)`(``data ``=`` ``stats``::`[`rnorm`](https://rdrr.io/r/stats/Normal.html)`(``n ``=`` ``60``)``, nrow ``=`` ``20``)`\
`n`` ``<-`` `[`nrow`](https://rdrr.io/r/base/nrow.html)`(``x ``=`` ``x``)`\
`d`` ``<-`` `[`scale`](https://rdrr.io/r/base/scale.html)`(``x ``=`` ``x``, center ``=`` ``TRUE``, scale ``=`` ``FALSE``)`\
`sigma`` ``<-`` `[`crossprod`](https://rdrr.io/r/base/crossprod.html)`(``x ``=`` ``d``)`` ``/`` ``n`\
`vechsigma`` ``<-`` ``sigma``[`[`lower.tri`](https://rdrr.io/r/base/lower.tri.html)`(``x ``=`` ``sigma``, diag ``=`` ``TRUE``)``]`

The consistent estimate.

\
`gamma_consistent`` ``<-`` ``gammaADF``:::``.GammaADFConsistent``(`\
`  d ``=`` ``d``,`\
`  vechsigmacap_consistent ``=`` ``vechsigma``,`\
`  n ``=`` ``n`\
`)`\
[`dim`](https://rdrr.io/r/base/dim.html)`(``x ``=`` ``gamma_consistent``)`\
`#> [1] 6 6`

The unbiased estimate needs the normal-theory matrix (see `gammaN`); the
identity stands in for it here.

\
`gamma_unbiased`` ``<-`` ``gammaADF``:::``.GammaADFUnbiased``(`\
`  gammacapadf_consistent ``=`` ``gamma_consistent``,`\
`  gammacapmvn_consistent ``=`` `[`diag`](https://rdrr.io/r/base/diag.html)`(``x ``=`` `[`nrow`](https://rdrr.io/r/base/nrow.html)`(``x ``=`` ``gamma_consistent``)``)``,`\
`  vechsigmacap_consistent ``=`` ``vechsigma``,`\
`  n ``=`` ``n`\
`)`\
[`dim`](https://rdrr.io/r/base/dim.html)`(``x ``=`` ``gamma_unbiased``)`\
`#> [1] 6 6`

## Documentation

See [GitHub Pages](https://ijapesigan.github.io/gammaADF) for package
documentation.

## References

R Core Team. (2026). *R: A language and environment for statistical
computing*. R Foundation for Statistical Computing.
<https://www.R-project.org/>
