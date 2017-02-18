      Program CT14Demo

C     A simple test program for CT14 standalone interpolation interface.
C     To compile and run on a typical Unix system with the installed
C     gfortran compiler:
C 
C        gfortran -o ct14demo CT14Demo.f CT14Pdf.f
C        ./ct14demo
C
C     The tables with available PDF files are available at 
C     http://hep.pa.msu.edu/cteq/public/index.html


      IMPLICIT DOUBLE PRECISION (A-H, O-Z)
      Character Tablefile*40

      double precision QAry(5), xAry(9) 
      data QAry/ 1.5d0, 4.5d0, 10d0, 91.187d0, 200d0/,
     >  xAry /1d-5,1d-4,1d-3,1d-2,1d-1,0.3d0,0.5d0,0.7d0,0.9d0/

      data Tablefile /'CT14LL.pds'/

      print *, 'This is a demo of the CT14 PDF interpolation interface'
      print *,'Usage: ct14demo [pds_file]'
      print *,
     >  'pds_file is the optional file with an interpolation table.\n', 
     >  ' of PDF values. If left blank, pdf.pds will be used.\n'

cpn12 Read the name of the table from the command line (if provided)
      if (iargc().gt.0)
     >  call getarg(1,Tablefile)

cpn12 Read in the table with the PDFs
      Call SetCT14(Tablefile)

cpn12 Print out the minimal x, initial Q, maximal Q, number of QCD loops,
c     maximal number of quark flavors
      call CT14GetPars(xmin,Qini,Qmax,Nloops,Nfl)
      print *
      write(*,'(" This PDF grid is for ",es12.5," < x < 1 and")') xmin
      write(*,'(f12.4," < Q < ",f12.4," GeV")') Qini, Qmax
      write (*,*) 'The number of QCD loops is ',Nloops
      write (*,*) 'The maximal number of quark flavors is ',Nfl

cpn12 Print out quark masses
       print *
      print *,  
     >  ' Flavor ID         :   1     2     3      4      5      6'
      print *,  
     >  ' Flavor            :   u     d     s      c      b      t'
      write(*,'("Quark masses (GeV):",5(1X,f6.3),1X,f7.3)') 
     >  (CT14mass(iq), iq=1,6)

cpn12 Print out the QCD coupling at select Q values
      print *
      print *, 'The values of the QCD coupling ',
     >  'from the built-in interpolation are'
      print *,'  Q, GeV   alpha_s(Q) '
      do iq=1,5
        alstmp=CT14alphas(Qary(Iq))
        write(*,'(1X,f9.3,2x,f9.4)') Qary(iq), alstmp
      enddo 

cpn12 Print out the PDFs 
      Q = 1.2d0!1d2
      print *
      print *, 'The values of the PDFs at Q = ', Q, ' GeV are'

      print *,
     >'   x      u-ubar     d-dbar     2(ubr+dbr)     c+cbar     gluon'
       Do ix = 1, 9
         x=xAry(ix)
         write(6,'(e7.1,5e12.4)') x,
     &     CT14Pdf( 1, x, Q) - CT14Pdf(-1, x, Q),
     &     CT14Pdf( 2, x, Q) - CT14Pdf(-2, x, Q),
     &     2*(CT14Pdf(-1, x, Q)+CT14Pdf(-2, x, Q)),
     &     (CT14Pdf(-4, x, Q)+CT14Pdf(4, x, Q)),
     &     CT14Pdf(0, x, Q)
       enddo

       print *
       print *,'This is the end of the demo'
       END

