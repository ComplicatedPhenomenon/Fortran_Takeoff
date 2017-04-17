      program test_vectors
      use vector_module
      implicit none
      
      type(vector)::v1
      type(vector)::v2
      write (*,*)'Enter the first vector (x,y,z)'
      read (*,*) v1%x,v1%y,v1%z
      write (*,*)'Enter the first vector (x,y,z)'
      read (*,*) v2%x,v2%y,v2%z
      
      write(*,*) add_vector(v1,v2)

      end program test_vectors
