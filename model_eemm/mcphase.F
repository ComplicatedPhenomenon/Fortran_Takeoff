* vegas_v3.F
* Vegas Monte-Carlo integration of a scalar either with ordinary random
* numbers or with quasi-random numbers
* based on code by M. Martinez, J. Illana, J. Bossert, and A. Vicini
* and modifed by Junjie Cao.
* last modified on May 1, 2005.

* NDIM is the maximum number of dimensions the integrand may have.
* Note: if your Fortran compiler allows, replace NDIM by ndim
* (i.e. #define NDIM ndim) to dimension the arrays dynamically.
c#define NDIM 3

* NCOMP is the number of components of the vector whose distribution 
**will be generated.
c#define NCOMP 2

* If DEBUG is defined, the error is printed out after each iteration
* so that one can tune the parameters for a particular integral.
#define DEBUG

* RNG determines which random-number generator is used:
* - 1 uses a subtractive Mitchell-Moore generator,
* - 2 uses a Faure quasi-random sequence,
* - 3 uses a Sobol quasi-random sequence (default).
#define RNG 3


**********************************************************************
** Vegas integrates a scalar function (fun) in the ndim-dimensional 
** unit hypercube using the Monte-Carlo method. If required (by setting
** the value for option), it can also generate both the distribution 
** for a arbitary  NCOMP-dimensional vector (fun1) and  unweighted 
** events which are useful for experimental simulation. 
**       option=0, only the integration is to be calculated. 
**       option=1, the distribution will generated. The distribution 
**          is stored in dis.
**       option=2, unweighted events will be generated. The events are 
**          stored in file "unweighted.dat".  
** After sampling ncall points, the grid is refined.  This is called 
** one iteration.  The iterations loop terminates if the absolute value
** of the integral is below absacc or the relative error is below
** relacc, or after maxiter iterations.
** integrand:  a subroutine which will call for the integration 
** funtion (fun) and the physical quantity (fun1) whose distribution 
** will be generated.
** result: the integration result.
** ndim: the varable dimension for the integration function.
** absacc: required absolute error.
** relacc: required relative error.
** ncall: number of sampling per iteration.
** maxiter: maximum iteration.
** neval: number of evaluations.
** ncomp: the dimension of the vector fun1.
** bin_min, bin_max, wid_bin: the distribution within the range 
** between bin_min and bin_max with interval wid_bin will be generated. 
** The results are stored in dis with the relative error are stored 
** in err_dis.
 
       subroutine mcphase(ni,pi,ndis,nf,m,result, absacc, relacc, ncall, 
     &       maxiter, neval, option, ncomp, bin_min,
     &       bin_max, wid_bin, dis, err_dis,iter0)

**********************************************************************
* The following is essential for n-body phase space
**********************************************************************
       integer ni,nf,ndis,idim
       double precision m(nf),wps,pf(nf,4),pi(ni,4),y1(ndis),y2(3*nf-4)
       double precision pip(ni,4),finidis
       double precision amps,amps1
       common /kin/wps
***********************************************************************
*********************************************************************** 
       integer ndim, ncomp,ncall,maxiter,neval
       double precision result, relacc, absacc
       double precision fun, sfun, sfun2
       double precision sint, sint2, sweight
       double precision fun2, weight
       double precision r, dr, xo, xn, err
       integer iter, calls, dim, grid, g, c, cmax

       integer ngrid,max_bin,n_bin
       parameter (ngrid = 100,n_bin=1000)

       double precision xi(ngrid, 3*nf+ndis-4), d(ngrid, 3*nf+ndis-4)
       double precision x(3*nf+ndis-4), imp(ngrid), tmp(ngrid - 1)
       integer pos(3*nf+ndis -4)

******************************************************************
** The following is modified by Junjie Cao.
** nev_bin(kk,c) stored the number of events in kkth bin, c dentes 
** which component of fun1 .
** fun1(ncomp) is the varable whose distribution will be presented.
** sdiff(kk,c) is to store the sumed weight in kk bin for c component 
** of fun1 in one run.
** sdiff2(kk,c) is to store the summed weight square in one run.
** bin_st, bin_st2,bin_swt is used to calulate the final result. 
** Their values will be changed after one run.   
******************************************************************
       integer option, nbin, nev_bin(n_bin,ncomp),kk
       double precision bin_min(ncomp),bin_max(ncomp),wid_bin(ncomp)
       double precision sdiff(n_bin,ncomp),sdiff2(n_bin,ncomp),
     &    r_bin(n_bin,ncomp),err_dis(n_bin,ncomp),dis(n_bin,ncomp)
       double precision bin_st(n_bin,ncomp), bin_st2(n_bin,ncomp),
     &    bin_swt(n_bin,ncomp),bin_wgt(n_bin,ncomp)
       double precision fun1(ncomp),diff
***********************************************************************
       integer nevent,nover,iter0,rndim,count,norm
c       integer n_event(100)
       integer i,j,v(40,30),lastq(40)
       integer cv(40,30,maxiter+1),clastq(40,maxiter+1),
     &        cmix(3,maxiter+1)
       double precision fun2max(maxiter+1), scale,
     &             array(ncall),cxi(ngrid,3*nf+ ndis-4,maxiter+1)
       common /rngdata/v,lastq,rndim,count,norm
       OPEN (UNIT=10, FILE='data.out', STATUS='UNKNOWN')
       rewind 10            
       OPEN (UNIT=11, FILE='event.out', STATUS='UNKNOWN')
       rewind 11            
*********************************************************************

       ndim = 3*nf + ndis - 4
       call IniRandom(maxiter*ncall, ndim)
       iter = 0
       neval = 0
       sint = 0
       sint2 = 0
       sweight = 0

****************************************************************
** The following items is added by Junjie Cao.
** It is necessary to set the initial values of bin_st, bin_st2, 
** bin_swt and dis. These varables depend on whole iteration.
*****************************************************************
       if(option.eq.1) then
       do c=1,ncomp
        nbin=(bin_max(c)-bin_min(c))/wid_bin(c)
        if(nbin.gt.n_bin) then
        print *, "the bin number for ", c, "component exceeds the 
     &   maximum default bin number"
        print *, "change the value of n_bin"
        return
        endif 
          do kk=1,n_bin
          bin_st(kk,c)=0.
          bin_st2(kk,c)=0.
          bin_swt(kk,c)=0.
          dis(kk,c)=0.
          err_dis(kk,c)=0.
         enddo
       enddo
       endif

*********************************************************************
********************************************************************
        if(option.eq.2) then
        nevent=0.
        nover=0.
        do i=1,maxiter
          fun2max(i)=0.
        enddo
c        do i=1,100
c           n_event(i)=0
c        enddo
        endif
********************************************************************

* define the initial distribution of intervals
       do grid = 1, ngrid
	 r = dble(grid)/ngrid
	 do dim = 1, ndim
	   xi(grid, dim) = r
	 enddo
       enddo


* iterations loop
1	continue
	iter = iter + 1
********************************************************************
*Copy useful information for every interation
********************************************************************
        if(option.eq.2) then
            do i=1,40
               clastq(i,iter)=lastq(i)
               do j=1,30
               cv(i,j,iter)=v(i,j)
               enddo
            enddo
            cmix(1,iter)=rndim
            cmix(2,iter)=count
            cmix(3,iter)=norm
            do dim=1,ndim
               do grid=1,ngrid
               cxi(grid,dim,iter)=xi(grid,dim)
               enddo
            enddo
         endif

********************************************************************
* initialize iteration variables
********************************************************************
	sfun = 0
	sfun2 = 0
	do dim = 1, ndim
	   do grid = 1, ngrid
	   d(grid, dim) = 0
	   enddo
	enddo

*******************************************************************
** The following item is added by Junjie Cao.
** It is necessary to set the initial values of bin_sum, sdiff, 
** sdiff2 and nev_bin.
** These varables depend on a certain iteration.
*********************************************************************
	 if(option.eq.1) then
	  do c=1,ncomp
	     do nbin=1,n_bin
	     sdiff(nbin,c)=0.
	     sdiff2(nbin,c)=0.
	     nev_bin(nbin,c)=0
	     enddo
	   enddo
	  endif
*******************************************************************

       	do calls = 1, ncall
	  weight = 1D0/ncall

* compute the point position
          call GetRandom(x)
	  do dim = 1, ndim
	    r = x(dim)*ngrid + 1
	    grid = int(r)
	    xo = 0
	    if( grid .gt. 1 ) xo = xi(grid - 1, dim)
	    xn = xi(grid, dim) - xo
	    x(dim) = xo + (r - grid)*xn
	    pos(dim) = grid
	    weight = weight*xn*ngrid
	  enddo

* compute the integrand

          if(ndis.eq.0) then
          call event(ni,pi,nf,m,x,pf)
********************************************************************
* The squared amplitude can be added here.
********************************************************************

          fun=wps*amps(ni,nf,pi,pf)
          else

           do idim=1,ndis
              y1(idim) = x(idim)
           enddo
           do idim=ndis+1,3*nf+ndis-4
              y2(idim-ndis)=x(idim)
           enddo
           call inidis(ni,ndis,y1,pi,pip,finidis)
           call event(ni,pip,nf,m,y2,pf)

********************************************************************
* The squared amplitude can be added here
********************************************************************

          fun=wps*finidis*amps(ni,nf,pip,pf)
          endif

          fun2 = fun*weight
          if(fun2.gt.fun2max(iter)) fun2max(iter)=fun2             
	  sfun = sfun + fun2         
	  fun2 = fun2**2
	  sfun2 = sfun2 + fun2	   
	  do dim = 1, ndim
	  d(pos(dim), dim) = d(pos(dim), dim) + fun2
	  enddo

*********************************************************************
**The following items are added by Junjie Cao.
**They will determin the relevant values of kk bin.
********************************************************************* 
            if(option.eq.1) then
            call disfun(ni,pi,nf,m,pf,ncomp,fun1)
	    do c=1,ncomp
	    diff=fun1(c)
	    kk=(diff - bin_min(c))/wid_bin(c)+1
	    sdiff(kk,c)=sdiff(kk,c)+fun*weight
            sdiff2(kk,c)=sdiff2(kk,c)+(fun*weight)**2            
	    nev_bin(kk,c)=nev_bin(kk,c)+1
	    enddo
	    endif
        
*********************************************************************
	enddo
	neval = neval + ncall

* compute the integral and error values

**********************************************************************
** The following items are added by Junjie Cao
** They will determine the dis(kk) and err_dis(kk). Their explicit 
** formula can  be seen from the paper by Lepage.
***********************************************************************

	if(option.eq.1) then
          do c=1,ncomp
             do kk=1,n_bin
             if(nev_bin(kk,c).gt.0) then
                  r_bin(kk,c)= ncall*sdiff2(kk,c)- sdiff(kk,c)**2
                  if(r_bin(kk,c).ne.0) then
	        bin_wgt(kk,c)=sdiff(kk,c)**2*(ncall-1)/abs(r_bin(kk,c))
                  bin_swt(kk,c)=bin_swt(kk,c)+bin_wgt(kk,c)
                  bin_st2(kk,c)=bin_st2(kk,c)+sdiff(kk,c)**2
                  bin_st(kk,c)=bin_st(kk,c)+sdiff(kk,c)*bin_wgt(kk,c)
	          endif
             endif

                if(bin_swt(kk,c).lt.0.00001) then
                dis(kk,c)=0.
                err_dis(kk,c)=0.
 	        else
                dis(kk,c)=bin_st(kk,c)/bin_swt(kk,c)
                err_dis(kk,c)=sqrt(bin_st2(kk,c)/(bin_st(kk,c)*
     &               dis(kk,c))/iter)
	        endif
             enddo
         enddo
	endif


**********************************************************************
	
      
          err = 0
	  fun2 = sfun**2
	  sint2 = sint2 + fun2
	  r = sfun2*ncall - fun2
	  if( r .ne. 0 ) then
	    weight = fun2/abs(r)*(ncall - 1)
	    sweight= sweight + weight
	    sint = sint + sfun*weight
	  endif
	  if( sweight .lt. 0.00001 ) then
	    result = 0.
            err=0.
	  else
	    r = sint/sweight
	    result = r
* if the integrand is very close to zero, it is pointless (and costly)
* to insist on a certain relative accuracy
	    if( abs(r) .gt. absacc ) then
              r = sint2/(sint*r)
	      if( r .gt. err ) then
	        err = r
	      endif
	    endif
	  endif
          err = sqrt(err/iter)




#ifdef DEBUG
	print *, "iteration ", iter, "  error ", err
#endif
	if( err .lt. relacc ) then
           if(option.eq.2) then
           goto 40
           else 
           return
           endif
        endif

	if( iter .gt. maxiter ) then
	  print *, "VEGAS failed to reach the desired accuracy."
	  print *, "Remaining relative error: ", err
          if(option.eq.2) then
	  goto 40
          else
          return
          endif
     	endif

* redefine the grid (importance sampling)
* - smooth the f^2 value stored for each interval
	do dim = 1, ndim
	  xo = d(1, dim)
	  xn = d(2, dim)
	  d(1, dim) = .5D0*(xo + xn)
	  x(dim) = d(1, dim)
	  do grid = 2, ngrid - 1
	    r = xo + xn
	    xo = xn
	    xn = d(grid + 1, dim)
	    d(grid, dim) = (r + xn)/3D0
	    x(dim) = x(dim) + d(grid, dim)
	  enddo
	  d(ngrid, dim) = .5D0*(xo + xn)
	  x(dim) = x(dim) + d(ngrid, dim)
	enddo

* - compute the importance function of each interval
       	do dim = 1, ndim
	  r = 0
	  do grid = 1, ngrid
	    imp(grid) = 0
	    if( d(grid, dim) .gt. 0 ) then
	      xo = x(dim)/d(grid, dim)
	      imp(grid) = ((xo - 1)/xo/log(xo))**1.5D0
	    endif
	    r = r + imp(grid)
	  enddo
	  r = r/ngrid

* - redefine the size of each interval
          dr = 0
	  xn = 0
	  g = 0
	  do grid = 1, ngrid - 1
	    do while( dr .lt. r )
	      g = g + 1
	      dr = dr + imp(g)
	      xo = xn
	      xn = xi(g, dim)
	    enddo
	    dr = dr - r
	    tmp(grid) = xn - (xn - xo)*dr/imp(g)
	  enddo
	  do grid = 1, ngrid - 1
	    xi(grid, dim) = tmp(grid)
	  enddo
	  xi(ngrid, dim) = 1
	enddo

	goto 1

********************************************************************** 
* If we donot want to generate unweighted events, we may mark out    * 
* the following lines.                                               *
*                                                                    *
*************************************************************        *
* Copy useful information                                            * 
*************************************************************        *
*                                                                    *
* 40     do i=1,40                                                   *
*           lastq(i)=clastq(i,iter0)                                 *
*           do j=1,30
*           v(i,j)=cv(i,j,iter0)
*           enddo
*        enddo
*           rndim=cmix(1,iter0)
*           count=cmix(2,iter0)
*           norm=cmix(3,iter0)
*
*        do dim=1,ndim
*            do grid=1,ngrid
*            xi(grid,dim)=cxi(grid,dim,iter0)
*            enddo
*        enddo
*******************************************************************
*                                                                 *
*       do calls = 1, ncall                                       *
*	  weight = 1D0/ncall                                      *

* compute the point position                                      *
*	call GetRandom(x)                                         *
*	  do dim = 1, ndim                                        *
*	    r = x(dim)*ngrid + 1                                  *
*	    grid = int(r)                                         * 
*	    xo = 0                                                *
*	    if( grid .gt. 1 ) xo = xi(grid - 1, dim)              *
*	    xn = xi(grid, dim) - xo                               *
*	    x(dim) = xo + (r - grid)*xn                           *  
*	    weight = weight*xn*ngrid                              *
*	  enddo                                                   *
*                                                                 *
* compute the integrand                                           *
*          call event(ni,pi,nf,m,x,pf)                            *
*******************************************************************
*If there are initial state distribution, we sholud add the       *
* distribution function here.                                     *
*******************************************************************
*          fun = wps*amps(ni,nf,pi,pf)                            *
*******************************************************************
*                                                                 * 
*	   fun2 = fun*weight                                      *
*          scale=fun2/fun2max(iter0)                              * 
*          if(scale.gt.1) nover=nover+1                           *
*          if(random(0).le.scale) then                            *
*******************************************************************
*We may get distribution here                                     *
*******************************************************************
c          kk=x(1)*x(2)/0.01+1                                    *
c          n_event(kk)=n_event(kk)+1                              *
********************************************************          *
*nevent here denotes generated unweighted event number.           *
********************************************************          *
*          nevent=nevent+1                                        *
*          write(11,*)(x(dim),dim=1,ndim),fun2                    *
*          endif                                                  *
*	enddo                                                     *
c        do i=1,100
c           print*,i, n_event(i)
c        enddo

c        print *, 'nevent', fun2max(iter0), nevent,nover
 40      return
        end


#if RNG == 1

************************************************************************
** IniRandom sets up the random-number generator to produce at most
** max dims-dimensional quasi-random vectors

	subroutine IniRandom(max, dims)
	implicit none
	integer max, dims

	integer ndim
	common /rngdata/ ndim

	ndim = dims
	end


************************************************************************
** GetRandom is a subtractive Mitchell-Moore random-number generator.
** The algorithm is n(i) = (n(i - 24) - n(i - 55)) mod m, implemented
** as a circular array with n(i + 55) = n(i) and m = 2^30 in this
** version.  The array n has been initialized by setting n(i) = i and
** running the algorithm 100,000 times.  Code by Ronald Kleiss.

	subroutine GetRandom(array)
	implicit none
	double precision array(*)

	integer ndim
	common /rngdata/ ndim

	integer dim, a, b, j, m, n(55)
	parameter (m = 2**30)
	data a /55/, b /31/
	data n /
     &    980629335, 889272121, 422278310,1042669295, 531256381,
     &    335028099,  47160432, 788808135, 660624592, 793263632,
     &    998900570, 470796980, 327436767, 287473989, 119515078,
     &    575143087, 922274831,  21914605, 923291707, 753782759,
     &    254480986, 816423843, 931542684, 993691006, 343157264,
     &    272972469, 733687879, 468941742, 444207473, 896089285,
     &    629371118, 892845902, 163581912, 861580190,  85601059,
     &    899226806, 438711780, 921057966, 794646776, 417139730,
     &    343610085, 737162282,1024718389,  65196680, 954338580,
     &    642649958, 240238978, 722544540, 281483031,1024570269,
     &    602730138, 915220349, 651571385, 405259519, 145115737 /

	do dim = 1, ndim
	  a = mod(a, 55) + 1
	  b = mod(b, 55) + 1
	  j = n(b) - n(a)
	  if( j .lt. 0 ) j = j + m
	  n(a) = j
	  array(dim) = dble(j)/m
	enddo
	end

#elif RNG == 2

************************************************************************
** IniRandom sets up the random-number generator to produce a Faure
** sequence of at most max dims-dimensional quasi-random vectors.
** Adapted from ACM TOMS algorithm 659, see
** http://www.acm.org/pubs/citations/journals/toms/1988-14-1/p88-bratley

	subroutine IniRandom(max, dims)
	implicit none
	integer max, dims

	integer coeff(0:19, 0:19)
	integer ndim, prime, nextn, testn, digits
	common /rngdata/ coeff, ndim, prime, nextn, testn, digits

	integer i, j, h

	integer primes(40)
	save primes

	data primes /
     &    1, 2, 3, 5, 5, 7, 7, 11, 11, 11, 11,
     &    13, 13, 17, 17, 17, 17, 19, 19,
     &    23, 23, 23, 23, 29, 29, 29, 29,
     &    29, 29, 31, 31, 37, 37, 37, 37,
     &    37, 37, 41, 41, 41 /

	ndim = dims
	prime = primes(dims)
	testn = prime**4
	nextn = testn - 1
	digits = 3

	h = nint(log(dble(max + testn))/log(dble(prime)))
	coeff(0, 0) = 1
	do j = 1, h
	  coeff(j, 0) = 1
	  coeff(j, j) = 1
	enddo
	do j = 1, h
	  do i = j + 1, h
	    coeff(i, j) =
     &        mod(coeff(i - 1, j) + coeff(i - 1, j - 1), prime)
	  enddo
	enddo
	end


************************************************************************
** GetRandom generates a vector of random numbers

	subroutine GetRandom(array)
	implicit none
	double precision array(*)

	integer coeff(0:19, 0:19)
	integer ndim, prime, nextn, testn, digits
	common /rngdata/ coeff, ndim, prime, nextn, testn, digits

	integer y(0:19), digit, dim, d, j, p
	double precision r

	p = testn
	j = nextn
	do digit = digits, 0, -1
	  p = p/prime
	  d = mod(j, p)
	  y(digit) = (j - d)/p
	  j = d
	enddo

	r = 0
	do digit = digits, 0, -1
	  r = (r + y(digit))/prime
	enddo
	array(1) = r

	do dim = 2, ndim
	  r = 0
	  p = 1
	  do digit = 0, digits
	    j = 0
	    do d = digit, digits
	      j = j + coeff(d, digit)*y(d)
	    enddo
	    y(digit) = mod(j, prime)
	    p = p*prime
	    r = r + dble(y(digit))/p
	  enddo
	  array(dim) = r
	enddo

	nextn = nextn + 1
	if( nextn .eq. testn ) then
	   testn = testn*prime
	   digits = digits + 1
	endif
	end

#else

************************************************************************
** IniRandom sets up the random-number generator to produce a Sobol
** sequence of at most max dims-dimensional quasi-random vectors.
** Adapted from ACM TOMS algorithm 659, see
** http://www.acm.org/pubs/citations/journals/toms/1988-14-1/p88-bratley

	subroutine IniRandom(max, dims)
	implicit none
	integer max, dims

	integer v(40, 30), lastq(40)
	integer ndim, count, norm
	common /rngdata/ v, lastq, ndim, count, norm

	integer bits, powers, degree, newv, dim, bit, deg, j

	integer poly(2:40), vinit(2:40, 1:8)
	save poly, vinit

	data poly / 3, 7, 11, 13, 19, 25, 37, 59, 47,
     &    61, 55, 41, 67, 97, 91, 109, 103, 115, 131,
     &    193, 137, 145, 143, 241, 157, 185, 167, 229, 171,
     &    213, 191, 253, 203, 211, 239, 247, 285, 369, 299 /

	data (vinit(dim, 1), dim = 2, 40) / 39*1 /
	data (vinit(dim, 2), dim = 3, 40) /
     &          1, 3, 1, 3, 1, 3, 3, 1,
     &    3, 1, 3, 1, 3, 1, 1, 3, 1, 3,
     &    1, 3, 1, 3, 3, 1, 3, 1, 3, 1,
     &    3, 1, 1, 3, 1, 3, 1, 3, 1, 3 /
	data (vinit(dim, 3), dim = 4, 40) /
     &             7, 5, 1, 3, 3, 7, 5,
     &    5, 7, 7, 1, 3, 3, 7, 5, 1, 1,
     &    5, 3, 3, 1, 7, 5, 1, 3, 3, 7,
     &    5, 1, 1, 5, 7, 7, 5, 1, 3, 3 /
	data (vinit(dim, 4), dim = 6, 40) /
     &                  1, 7, 9, 13, 11,
     &    1, 3, 7, 9, 5, 13, 13, 11, 3, 15,
     &    5, 3, 15, 7, 9, 13, 9, 1, 11, 7,
     &    5, 15, 1, 15, 11, 5, 3, 1, 7, 9 /
	data (vinit(dim, 5), dim = 8, 40) /
     &                            9, 3, 27,
     &    15, 29, 21, 23, 19, 11, 25, 7, 13, 17,
     &    1, 25, 29, 3, 31, 11, 5, 23, 27, 19,
     &    21, 5, 1, 17, 13, 7, 15, 9, 31, 9 /
	data (vinit(dim, 6), dim = 14, 40) /
     &            37, 33, 7, 5, 11, 39, 63,
     &    27, 17, 15, 23, 29, 3, 21, 13, 31, 25,
     &    9, 49, 33, 19, 29, 11, 19, 27, 15, 25 /
	data (vinit(dim, 7), dim = 20, 40) /
     &                                  13,
     &    33, 115, 41, 79, 17, 29, 119, 75, 73, 105,
     &    7, 59, 65, 21, 3, 113, 61, 89, 45, 107 /
	data (vinit(dim, 8), dim = 38, 40) / 7, 23, 39 /

	j = max
	bits = 0
	do while( j .ne. 0 )
	  bits = bits + 1
	  j = ishft(j, -1)
	enddo

	do bit = 1, bits
	  v(1, bit) = 1
	enddo

	do dim = 2, dims
	  powers = poly(dim)

	  j = powers
	  degree = -1
	  do while( j .ne. 0 )
	    degree = degree + 1
	    j = ishft(j, -1)
	  enddo

	  do bit = 1, degree
	    v(dim, bit) = vinit(dim, bit)
	  enddo

	  do bit = degree + 1, bits
	    newv = v(dim, bit - degree)
	    j = powers
	    do deg = degree, 1, -1
	      if( btest(j, 0) )
     &          newv = ieor(newv, ishft(v(dim, bit - deg), deg))
	      j = ishft(j, -1)
	    enddo
	    v(dim, bit) = newv
	  enddo
	enddo

	do bit = 1, bits - 1
	  do dim = 1, dims
	    v(dim, bit) = ishft(v(dim, bit), bits - bit)
	  enddo
	enddo
	norm = ishft(1, bits)

	count = 0
	ndim = dims
	do dim = 1, dims
	  lastq(dim) = 0
	enddo
	end


************************************************************************
** GetRandom generates a vector of random numbers

	subroutine GetRandom(array)
	implicit none
	double precision array(*)

	integer v(40, 30), lastq(40)
	integer ndim, count, norm
	common /rngdata/ v, lastq, ndim, count, norm

	integer c, zerobit, dim

	c = count
	zerobit = 1
	do while( btest(c, 0) )
	  zerobit = zerobit + 1
	  c = ishft(c, -1)
	enddo

	do dim = 1, ndim
	  lastq(dim) = ieor(lastq(dim), v(dim, zerobit))
	  array(dim) = dble(lastq(dim))/norm
	enddo

	count = count + 1
	end

#endif


************************************************************************
* This subroutine is to generate n-body physical momenta.
************************************************************************ 

      subroutine event(ni,pi,nf,m,x,pf)
      integer ni,nf,i,j
      double precision x(3*nf-4),wps,m(nf),mt(nf),ms(nf),y(3*nf-4),pie,
     &     ms_ini,k(nf,4),pf(nf,4),sum(4),pi(ni,4),weight,weight1
      common /kin/wps
      common /result/weight, weight1


      pie=3.14159
      ms(1) = 0
      
      do j=1,4
         sum(j)=0.
         k(1,j)=0.
      enddo


      do j = 1,4
          do i=1, ni
            k(1,j) = k(1,j) + pi(i,j)
          enddo
      enddo

      do j=1,nf
         ms(1) = ms(1) + m(j)
      enddo

      ms_ini = k(1,4)**2 - k(1,1)**2 - k(1,2)**2 - k(1,3)**2
      if(ms_ini.lt.ms(1)**2) then
      print*, 'the initial invariant mass is too small'
      return
      else
      mt(1) = sqrt(ms_ini)
      endif

*******************************************************************
* Generate event
*******************************************************************
      wps = (( mt(1) - ms(1))/(4*pie**2))**(nf-2)/(4*pie*mt(1))

      do j=1,nf-1
         ms( j + 1 ) = ms( j ) - m( j )

         call gen(nf,j,m,mt,ms,x,y,pf)
         call boost(nf,j,k,pf)
      enddo

**********************************************************************
* The following is useful to check whether energy-momentum is conserved.
***********************************************************************
      do j=1 , nf
        sum(1) = sum(1) + pf(j,1)
        sum(2) = sum(2) + pf(j,2)
        sum(3) = sum(3) + pf(j,3)
        sum(4) = sum(4) + pf(j,4)
      enddo
c      print*,sum(1)-k(1,1),sum(2)-k(1,2),sum(3)-k(1,3),sum(4)-k(1,4)
      end
      
      


*****************************************************************
*This subroutine is to generate the momentum of ith particle
* For detail, see V. Barger "Collider Physics"
*****************************************************************

      subroutine gen(n,i,m,mt,ms,x,y,p)
      integer n,i,j
      double precision m(n),mt(n),ms(n),x(3*n-4),p(n,4),y(3*n-4)
      double precision psq, pi,pie, phi,wps,cost,sint,alam
      external alam
      common /kin/wps

      pie=3.14159
          
      if(i.gt.1.and.i.lt.n-1)  then
      y(3*i)=y(3*(i-1))*x(3*i)
      else
      y(3)=x(3)
      endif


      if(i.eq.n-1) then
          mt( i + 1 ) = m(n)
      else
          mt( i+1 ) = ms( i+1 ) + ( mt(1) - ms(1) )*y(3*i)
      endif

      psq = alam( mt(i)**2, m(i)**2, mt(i+1)**2 )/(4*mt(i)**2)

      if(psq.gt.0.) then
      pi = sqrt(psq)
      else
      psq = 0.
      pi = 0.
      endif

      p(i,4) = sqrt( psq + m(i)**2 )

      cost = 1 - 2*x( 3*i-1 )
      sint  =sqrt( 1 - cost**2 )
      phi = 2*pie*x( 3*i - 2 )
**********************************************************************
* The definition of phi  may be different from the usual definition.
********************************************************************** 

      p(i,1) = pi*sint*sin(phi)
      p(i,2) = pi*sint*cos(phi)
      p(i,3) = pi*cost

      
      if(i.gt.1.and.i.lt.(n-1)) then
      wps = wps*pi*y(3*(i-1))
      else
      wps=wps*pi
      endif

      return 
      end


******************************************************************
* The definition of lambda function
*******************************************************************
      function alam(x,y,z)
      double precision alam, x,y,z
      alam = x**2 + y**2 + z**2 - 2*x*y - 2*y*z - 2*x*z
      end

*******************************************************************
* This programe is to boost momentum p in frame k  to  lab frame 
* and then generate new k frame. 
******************************************************************* 

      subroutine boost(n,i,k,p)
      integer n,i,j
      double precision k(n,4),p(n,4),mp,bg,g,ct,cps,sps,rz,ms,rx,ry

      ms = k(i,4)**2 - k(i,1)**2 - k(i,2)**2 - k(i,3)**2

      if( ms.lt.0) then 
      print*, 'the boost is invalid'
      return
      else
      mp = sqrt(ms)
      endif

      bg = sqrt( k(i,1)**2 + k(i,2)**2 + k(i,3)**2 )/mp
      if(bg.gt.0) then
      g = sqrt( 1 + bg**2 )
      ct = k(i,3)/( mp*bg )
      cps = k(i,2)/( mp*bg )
      sps = k(i,1)/( mp*bg )
      rz = p(i,1)*sps + p(i,2)*cps + p(i,3)*ct
      p(i,4) = p(i,4)*g + rz*bg
      rz = p(i,4)*bg/g + rz/g
      rx = p(i,1)*( 1 - sps**2 ) - p(i,2)*sps*cps - p(i,3)*sps*ct
     &       + rz*sps 
      ry  = -p(i,1)*sps*cps + p(i,2)*(1 - cps**2 ) - p(i,3)*cps*ct
     &       + rz*cps 
      p(i,3) = -p(i,1)*sps*ct - p(i,2)*cps*ct + p(i,3)*( 1 - ct**2)
     &       + rz*ct
      p(i,1) = rx
      p(i,2) = ry
      endif
      if(i.eq.n-1) goto 2
      do j=1,4
      k( i+1 , j ) = k( i , j ) - p( i , j ) 
      enddo
 2    do j=1,4
      p( n , j ) = k( i , j ) - p( i , j )
      enddo
      end

