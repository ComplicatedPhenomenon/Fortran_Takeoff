      program doy
      !aim
      !	
      !         date            programmer           description
      !	       =======		==========	     ===========
      !        28/12/16   	 WangMiao 	     original code
      !
      implicit none
      integer::day
      integer::day_of_year
      integer::i
      integer::leap_day
      integer::month
      integer::year
      write (*,*)'This program caculates the day of year given the '
      write (*,*)'current date .Enter current month(1-12),day(1-31),'
      write (*,*)'and year in that order'
      read (*,*) month,day,year   !美式写法
      if (mod(year,400)==0) then 
         leap_day=1
      else if(mod(year,100)==0) then 
         leap_day=0
      else if (mod(year,4)==0) then
         leap_day=1
      else
         leap_day=0
      end if
      day_of_year=day
      do i=1,month-1
         select case(i)
	 case(1,3,5,7,8,10,12)
	    day_of_year=day_of_year+31
	 case(4,6,9,11)
	    day_of_year=day_of_year+30
	 case(2)
	    day_of_year=day_of_year+28+leap_day
	 end select
      end do
      write (*,*)'Day          =',day
      write (*,*)'Month        =',month
      write (*,*)'Year         =',year
      write (*,*)'day of year  =',day_of_year
      end program doy
      
