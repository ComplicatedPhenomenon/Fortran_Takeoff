PROGRAM task_2
  IMPLICIT NONE

  INTEGER :: a
  REAL :: pi = 3.1415926

  WRITE (*,110) pi
110 FORMAT(E12.5)
  WRITE (*,100) pi
100 FORMAT(E12.3)
  WRITE (*,90) pi
90 FORMAT(E12.3E4)
  WRITE (*,80) pi
80 FORMAT(ES12.3E4)
  WRITE (*,70) pi
70 FORMAT(ES12.4E4)
  WRITE (*,'("please input an integer?")')
  READ(*,*),a
  WRITE(*,*),a
  PRINT *,'The output format is wierd'
END PROGRAM task_2


!这里把一个用户自定义函数当作参数传递给子程序，所有的这些外部过程
!(external procedure)都可以被独立编译。
! 一个程 序单元 是fortran程序中的一个独立编译部分，主程序，子程序，函数子程序
!都可以看做是程序单元，fortunately,Fortran has provide a specific mechanism ,可以在构建最终程序前较容易开发和调试子任务
