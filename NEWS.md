# gammaADF 0.0.3

## Other changes

- The linearAlgebra copy refreshed from linearAlgebra 0.0.5 (`.Vech()`: named example; same code).

# gammaADF 0.0.2

## Efficiency

- `.GammaADFConsistent()` builds the `vech(d_i d_i')` rows for all observations at once and uses `crossprod()`,
  instead of `Reduce()` over `lapply()` of `n` outer products: 250 times faster at n = 5000, k = 9
  (0.505 s to 0.002 s); differences below 1e-13.

# gammaADF 0.0.1

## Initial release

- The rProject template; private `jeksterslab-psu/gammaADF`, public `ijapesigan/gammaADF`.
- `.GammaADFConsistent()` and `.GammaADFUnbiased()`: complete roxygen (`@noRd`), tests.
- `.Vech()` is a locked copy from `linearAlgebra` (`.setup/r-dependencies/linearAlgebra/`).
