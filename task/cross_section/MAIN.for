      program main
      implicit none 
      external  FXN_qq,FXN_gg
      double precision FXN_qq,FXN_gg
      integer NDIM
      double precision avgi_qq,avgi_gg,sd,chi2a, sigma_qq,sigma_gg
      Character Tablefile*40
      NDIM=3
      data Tablefile/'CT14LL.pds'/
      Call SetCT14(Tablefile)
      open(1,file = 'DATA.txt', status='unknown')
      call vegas(NDIM,FXN_qq,avgi_qq,sd,chi2a)
      call vegas(NDIM,FXN_gg,avgi_gg,sd,chi2a)
      sigma_qq=avgi_qq*3.894*10**8
      sigma_gg=avgi_gg*3.894*10**8
      write(1,*)'TEST',avgi_qq ,'Mev'
      write(1,*) avgi_gg ,'Mev'
      write(1,*) sigma_qq ,'pb'
      write(1,*) sigma_gg ,'pb'
      close(1)
c     WRITE(*,*) avgi_qq 
       print *, 'The cross section of the ppbar to ttbar is sigma_qq=',
     <avgi_qq,'Mev'
      print *, 'The cross section of the gg to ttbar is sigma_gg=',
     <avgi_gg,'Mev'
      print *, 'The cross section of the ppbar to ttbar is sigma_qq=',
     <sigma_qq,'pb'
      print *, 'The cross section of the gg to ttbar is sigma_gg=',
     <sigma_gg,'pb'
      end
      
      include "FXN.for"
      include "vegas.for"
      include "vegasset.for"
      include "randa.for"
      include "CT14Pdf.for"
