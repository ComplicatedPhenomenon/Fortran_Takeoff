* Step 1 problem
  * I'm stuck again. `MC_VEGAS.f90` and `CT14Pdf.for` both are  given programs. I only write `FXN.f90` and `MAIN.f90`. I don't know how the mistakes come into being except checking again and again. 

  * Gladly there is no unclear problem, no basic level mistakes.

  * Then the problems become less obvious, I print out the intermediate variables, no obvious mistakes have been found.
* Step 2 problem
```bash
lemonp1.m:2638:72:

 /(s12**2*(-gm**2 - 4*m**2 + s12 + s13 + s14 + s23 + s24)**2))/(3.*gm**4)
                                                                         1
Error: Expected a right parenthesis in expression at (1)
```
I figure out a way
  * 1.**Handle input file**, no need to adjust it manually.`%s/\\/\&/g`,`%s/&&/\&/g`is enough! No more mistakes appears as before like `Expected a right parenthesis in expression`. Before make it right, I begged to the air.
  * 2. Do average to initial state, it lower the result to a reasonable one. 
  * 3. Check `fxnqq` again, it's strange that `sigma_qq` is too small compare to `sigma_gg`
  * 4. Summing up the final state give a factor `16` which enhance the result. 

*skills*
* [vim Tips](http://vim.wikia.com/wiki/Ranges)
* [Delete all lines containing a pattern ](http://vim.wikia.com/wiki/Delete_all_lines_containing_a_pattern)
