```bash
Error: Variable 'i' at (1) cannot be redefined inside loop beginning at (2)
test.f90:4:6:

  do i = 1. , 2. 
        1
Warning: Deleted feature: Loop variable at (1) must be integer
```
**problem1**

As I set attribute of `i` in module `my_fxn` as `public`, when I realize the `do loop`, printing `i` as well,`i` is `6` and never change , However, I print it in the unit of `do loop`, and it is from `1` to `2`, so there must be a mistake. I guess the value of `i` is inherited from the module.

**problem2**
Compare the loop control outside the module `my_fxn` with directly giving value to the variable.
```bash
public :: cos_theta
real(kind(0d0)) :: cos_theta !(assignment from outside)
```
```
public :: cos_theta 
real(kind(0d0)), parameter :: cos_theta=-0.996d0
```
There did exist a problem, There always is a result in the second way, in the first way, after certain point `i = 3`
```bash
Program received signal SIGSEGV: Segmentation fault - invalid memory reference.

Backtrace for this error:
#0  0x7F2626E7FE08
#1  0x7F2626E7EF90
#2  0x7F26265B04AF
#3  0x40BA9D in __mc_vegas_MOD_vegas
#4  0x40135E in MAIN__ at MAINqq.f90:?
Segmentation fault (core dumped)
```
It is confusing, I am working on it. I have a feeling that it can be solved with the aid of anwsers from `Google`
```bash
wm@MARVEL:~/playground/Fortran/exercise/differentialqq$ gfortran -g -fcheck=all -Wall FXNqq.f90 
FXNqq.f90:95:61:
          real(kind(0d0)) :: p3_0_max, p4_0_max, cos_theta_max, eta_max, gm_max, x1_max, x2_max, &
                                                        1
Warning: Unused variable ‘cos_theta_max’ declared at (1) [-Wunused-variable]
FXNqq.f90:96:61:
                             p3_0_min, p4_0_min, cos_theta_min, eta_min, gm_min, x1_min, x2_min
			                                1
Warning: Unused variable ‘cos_theta_min’ declared at (1) [-Wunused-variable]
......
```
**problem3**
Take a close look into code below.
```f90
s12 = z(3)*z(4) * S
if (sqrt(s12) < 2*m)then
   fxn_qq = 0d0 
   return
   else
 end if
 ```
