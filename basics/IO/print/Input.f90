PROGRAM Decoding
  IMPLICIT NONE

  INTEGER   :: salesno, phone, amount
  INTEGER   :: sn_1, sn_2, sn_3
  INTEGER   :: phone_1, phone_2
  INTEGER   :: number
  INTEGER   :: status
  LOGICAL   :: problem

  WRITE (*,'(A,A)') " ","   sales amount table"
  WRITE (*,'(A,A)') " ","   =================="
  WRITE (*,*)
  WRITE (*,'(A,A)') " ","Sales No. Phone No. Amount"
  WRITE (*,'(A,A)') " ","--------- --------- ------"
  problem = .FALSE.
  number = 0
  DO
     READ(*,"(I10,I10,I5)", IOSTAT = status) salesno, phone, amount
     IF (status > 0) THEN
        WRITE(*,*) "Something wrong with your data"
        problem = .TRUE.
        EXIT
     ELSE IF (status < 0) THEN
        EXIT
     ELSE
        sn_3 = MOD(salesno, 1000)
        sn_2 = MOD(salesno/1000, 100)
        sn_1 = salesno/100000

        phone_2 = MOD(phone, 10000)
        phone_1 = phone/ 10000
        WRITE(*,'(A, I2.2, A, I2.2, A, I3.3, I6.3, A, I4.4, I10)') &
             " ", sn_1, "-", "sn_2", "-", sn_3, phone_1, "-", phone_2, amount
        number = number +1
     END IF
  END DO
  IF (.NOT. problem)THEN
     WRITE(*,*)
     WRITE(*,'(A, A, I3, A)') " ", "Total", number, "person(s) proceed."
  END IF
END PROGRAM Decoding
