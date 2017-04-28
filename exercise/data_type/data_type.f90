program testingInt
implicit none

!two byte integer
integer(kind=2) :: shortval

!four byte integer
integer(kind=4) :: longval

!eight byte integer
integer(kind=8) :: verylongval

!sixteen byte integer
integer(kind=16) :: veryverylongval

!default integer
integer :: defval

print *,"The largest number of integer with kind=2 is  :",huge(shortval)
print *,"The largest number of integer with kind=4 is  :",huge(longval)
print *,"The largest number of integer with kind=8 is  :",huge(verylongval)
print *,"The largest number of integer with kind=16 is :",huge(veryverylongval)
print *,"The largest number of integer with default kind is :",huge(defval)

end program testingInt
