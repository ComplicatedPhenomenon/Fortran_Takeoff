program kindCheck
implicit none

integer     :: i
real        :: r
complex     :: cp
character   :: c
logical     :: lg

print *,'The different data type '
print *,'Real     ', kind(r)
print *,'Complex  ', kind(cp)
print *,'Character', kind(c)
print *,'Logical  ', kind(lg)
!Fortran is not blank space sensitive 
end program kindCheck
