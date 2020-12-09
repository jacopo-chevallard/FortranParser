!
! Copyright (c) 2000-2008, Roland Schmehl. All rights reserved.
!
! This software is distributable under the BSD license. See the terms of the
! BSD license in the documentation provided with this software.
!
MODULE FortranParser_parameters
  !--------- -------- --------- --------- --------- --------- --------- --------- -----
  ! Specify data types
  !--------- -------- --------- --------- --------- --------- --------- --------- -----
  use, intrinsic :: iso_fortran_env, only: REAL64, INT32
  IMPLICIT NONE
  
  INTEGER, PARAMETER :: rn = REAL64 ! Precision of real numbers
  INTEGER, PARAMETER :: is = INT32  ! Data type of bytecode
END MODULE FortranParser_parameters


