      program main
      implicit none
      double precision, external :: f, g
      integer NDIM
      double precision avgi_f, avgi_g, sd, chi2a
      NDIM=3
      open(1,file = 'DATA.txt', status='unknown')
      call vegas(NDIM,f,avgi_f,sd,chi2a)
      call vegas(NDIM,g,avgi_g,sd,chi2a)
      write(1,*)'TEST',avgi_f,avgi_g
      close(1)
      print *, 'avgi_f = ', avgi_f
      print *, 'avgi_g = ', avgi_g
      end program main
      
      double precision function f(x)
      implicit none

      double precision x
      f = x ** 2
      end function 

      double precision function g(x)
      implicit none

      double precision  x
      g = x ** 3
      end function 

      include "vegas.for"
      include "vegasset.for"
      include "randa.for"
