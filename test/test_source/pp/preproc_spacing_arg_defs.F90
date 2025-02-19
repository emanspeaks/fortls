program preprocessor_spacing_arg_defs
  implicit none

  #include "indent.h"

  type :: test_type
    private
      integer, public :: test_int

    contains
      generic, public :: set_test => MAYBEWRAP(test_type_set_test)
      procedure :: MAYBEWRAP(test_type_set_test)

  end type test_type

  type(test_type) :: the_test
  integer :: argtest

  !DEC$ IF DEFINED(SPACING_TEST).AND.DEFINED(MACROARGS)
    INTEGER (KIND=4), PARAMETER :: C_LONG = 4
  !DEC$ ELSE
    INTEGER (KIND=4), PARAMETER :: C_LONG = 8
  !DEC$ ENDIF

  call the_test%set_test()

  argtest = MACROARGS(the_test%test_int, C_LONG)

contains
  subroutine test_type_set_test(me)
    implicit none

    class(test_type), intent(inout) :: me

    me%test_int = 3
  end subroutine test_type_set_test

  subroutine wrap_test_type_set_test(me)
    implicit none

    class(test_type), intent(inout) :: me

    me%test_int = 5
  end subroutine wrap_test_type_set_test

end program preprocessor_spacing_arg_defs
