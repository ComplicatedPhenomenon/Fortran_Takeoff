! what's the advantages of this deisgn? what basic principles are implied here?
module decorator_pattern
    implicit none
    !Abstract Base Type with a procedure 'do_it' which MUST be implemented by derived types
    type, abstract :: I
        contains
            procedure(do_it_interface), deferred :: do_it
    end type I
    
    abstract interface
        subroutine do_it_interface(self)
            import :: I
            class(I), intent(in) :: self
        end subroutine do_it_interface
    end interface
    
    !! This is the type 'A' which we wish to extend. In particular, the procedure
    !! 'do_it' must be implemented by all derived types
    type, extends(I) :: A
        contains
            procedure :: do_it => do_it_A
    end type A
    
    !! This is an "inner" class not needed by client
    type, extends(I) :: D
        class(I), pointer, private :: m_wrappee     !! Object composition ('I' inside 'D')
        contains
            procedure :: ctor_D
            procedure :: do_it => do_it_D
    end type D
    
    !! Types X, Y, Z are used by client
    type, extends(D) :: X
        contains
            procedure :: ctor => ctor_X
            procedure :: do_it => do_it_X
    end type X
    
    type, extends(D) :: Y
        contains
            procedure :: ctor => ctor_Y
            procedure :: do_it => do_it_Y
    end type Y
    
    type, extends(D) :: Z
        contains
            procedure :: ctor => ctor_Z
            procedure :: do_it => do_it_Z
    end type Z
    
    contains
    
        subroutine do_it_A(self)
            class(A), intent(in) :: self
            write(*,'(A)', advance='no') 'A'
        end subroutine do_it_A
    
        subroutine ctor_D(self, inner)
            class(D), intent(inout) :: self
            class(I), pointer, intent(in) :: inner
            self%m_wrappee => inner
        end subroutine ctor_D
    
        subroutine do_it_D(self)
            class(D), intent(in) :: self
            call self%m_wrappee%do_it()
        end subroutine do_it_D
    
        subroutine ctor_X(self, inner)
            class(X), intent(inout) :: self
            class(I), pointer, intent(in) :: inner
            call self%ctor_D(inner)     !! Call base class constructor
        end subroutine ctor_X
    
        subroutine do_it_X(self)
            class(X), intent(in) :: self
            call self%m_wrappee%do_it()
            write(*,'(A)', advance='no') 'X'
        end subroutine do_it_X
    
        subroutine ctor_Y(self, inner)
            class(Y), intent(inout) :: self
            class(I), pointer, intent(in) :: inner
            call self%ctor_D(inner)     !! Call base class constructor
        end subroutine ctor_Y
    
        subroutine do_it_Y(self)
            class(Y), intent(in) :: self
            call self%m_wrappee%do_it()
            write(*,'(A)', advance='no') 'Y'
        end subroutine do_it_Y
    
        subroutine ctor_Z(self, inner)
            class(Z), intent(inout) :: self
            class(I), pointer, intent(in) :: inner
            call self%ctor_D(inner)     !! Call base class constructor
        end subroutine ctor_Z
    
        subroutine do_it_Z(self)
            class(Z), intent(in) :: self
            call self%m_wrappee%do_it()
            write(*,'(A)', advance='no') 'Z'
        end subroutine do_it_Z
    
    end module decorator_pattern
    
    program main
    use decorator_pattern
    implicit none 
    
        type(A), target :: an_A
        type(X), target :: an_X
        type(Y), target :: an_Y
        type(Z), target :: an_Z
        class(I), pointer :: ptr    !! Generic base class pointer
    
        call an_A%do_it()
        write (*,*)                 !! New line
    
        ptr => an_A
        call an_X%ctor(ptr)         !! Initialize an_X
        call an_X%do_it()
        write(*,*)                  !! New line
    
        ptr => an_X
        call an_Y%ctor(ptr)         !! Initialize an_Y
        call an_Y%do_it()
        write(*,*)                  !! New line
    
        ptr => an_Y
        call an_Z%ctor(ptr)         !! Initialize an_Z
        call an_Z%do_it()
        write(*,*)                  !! New line
    
    end program main