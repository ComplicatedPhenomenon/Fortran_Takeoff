# Ways to produce random number
* `random_number()`
* `rand()`
`RANDOM_NUMBER()` is preferable to `RAND()`. `RANDOM_NUMBER()` offers better statistical properties, a long period, and good performance.

The intrinsic `random_number(u)` returns a real number u (or an array of such) from the uniform distribution over the interval [0,1). [That is, it includes 0 but not 1.]
