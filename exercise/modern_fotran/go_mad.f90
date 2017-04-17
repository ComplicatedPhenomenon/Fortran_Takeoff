program go_mad
use mad_science

type(scientist) :: you, u
type(scientist), dimension(10) :: we

you%name = 'John Doe'
call set_mad(you)
you%height = 6.

call set_crazy(u)
u%height = 5.

print *,you
print *,u

end program go_mad
