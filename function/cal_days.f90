!
!     Modified Date: 03/16/2018
!     Description: Adjust the function
!
MODULE wm
  IMPLICIT NONE
  PRIVATE
  PUBLIC :: IsThisALeapYear, days_passed_of_this_year
CONTAINS
  FUNCTION IsThisALeapYear(year) RESULT(leap_day)
    IMPLICIT NONE
    INTEGER :: year
    INTEGER :: leap_day

    IF(MOD(year,400) == 0) THEN
       leap_day = 1
    ELSE IF(MOD(year,100) == 0) THEN
       leap_day = 0
    ELSE IF (MOD(year,4) == 0) THEN
       leap_day = 1
    ELSE
       leap_day = 0
    END IF

  END FUNCTION IsThisALeapYear

  FUNCTION days_passed_of_this_year(year, month, day) RESULT(day_of_year)
    IMPLICIT NONE
    INTEGER  :: year, month, day
    INTEGER :: day_of_year
    INTEGER :: i
    day_of_year = day
    DO i = 1, month - 1
       SELECT CASE(i)
       CASE(1, 3, 5, 7, 8, 10, 12)
          day_of_year = day_of_year + 31
       CASE(4, 6, 9, 11)
          day_of_year = day_of_year + 30
       CASE(2)
          day_of_year = day_of_year + 28 + IsThisALeapYear(year)
       END SELECT
    END DO
  END FUNCTION days_passed_of_this_year
END MODULE wm
PROGRAM doy
  USE wm

  IMPLICIT NONE

  INTEGER    :: i, z, days_accumulated
  INTEGER    :: month_begin, day_begin, year_begin, &
       month_end, day_end, year_end
  WRITE (*,*)'This program caculates the day of year given the '
  WRITE (*,*)'Begin date .Enter current month(1-12),day(1-31), year in that order'
  READ (*,*) month_begin, day_begin, year_begin
  WRITE (*,*)'End date .Enter current month(1-12),day(1-31), year in that order'
  READ (*,*) month_end, day_end, year_end

  days_accumulated = IsThisALeapYear(year_begin) + 365 - days_passed_of_this_year(year_begin, month_begin,day_begin)
  DO i = year_begin+1, year_end -1
     z = IsThisALeapYear(i)+365
     days_accumulated = days_accumulated + z
  END DO
  days_accumulated = days_accumulated + days_passed_of_this_year(year_end, month_end, day_end)

  WRITE (*,*)'Begin Day          =',day_begin
  WRITE (*,*)'Begin Month        =',month_begin
  WRITE (*,*)'Begin Year         =',year_begin
  WRITE (*,*)'End Day            =',day_end
  WRITE (*,*)'End Month          =',month_end
  WRITE (*,*)'End Year           =',year_end
  WRITE (*,*)'day passed =',days_accumulated
END PROGRAM doy
