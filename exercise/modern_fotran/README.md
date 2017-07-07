#### [Differences between Subroutine and Function](https://stackoverflow.com/questions/27521521/what-are-the-differences-between-functions-and-subroutines-in-fortran)
 A function must not change a global variable or a variable declared outside of the function's body. 

 A subroutine doesn't return anything and usually is impure as it has to change some global state or variable otherwise there is no point in calling it.

