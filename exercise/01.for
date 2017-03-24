      block data bd
          real :: x = 0.123
          common / c / x
      end block data

      program common_blocks
          interface   !?
              function x_plus_y(y)
                  real::x_plus_y,y
              end function
           end interface

          real::y=0.564
          print"(a,f5.3)","x_plus_y=",x_plus_y(y)
     
          stop
      end
 
      real function x_plus_y(y)
          real::x,y !don't need to pass 'x' as argument
          common / c / x !'x' is shared via common block 'c'
          x_plus_y=x+y
          return
 
       end



!      real function quadf (x,a,b,c)
!      implicit none
!      real,intent(in) :: x
!      real,intent(in) :: a
!      real,intent(in) :: b
!      real,intent(in) :: c
!      quadf=a*x**2+b*x+c
!      end function quadf

!      program test_quadf
!      implicit none
!      real :: quadf
!      real :: a,b,c,x
!      write (*,*) 'enter quadratic coefficients a,b,and c:'
!      read (*,*) a,b,c
!      write (*,*)'enter x'
!      read (*,*) x
!      write (*,*)'quadf =',quadf(x,a,b,c)
!      end program test_quadf
