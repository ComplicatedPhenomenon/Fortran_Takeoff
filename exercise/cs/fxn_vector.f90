program wz
   implicit none
   real, dimension(1:4) :: x, y ,z ,w
   x = [1, 2, 3, 4]
   y = [4, 8, 12, 16]
   w = [3, 6, 9, 12]
   z = x - y
   w = z * w + y 
   print *, z(1)
   print *, z
   print *, w
end program wz
