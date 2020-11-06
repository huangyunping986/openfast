!**********************************************************************************************************************************
!> ## SC
!! The SuperController  module implements a super controller for the FAST.Farm code.
!! SuperController_Types will be auto-generated by the FAST registry program, based on the variables specified in the
!! SuperController_Registry.txt file.
!!
! ..................................................................................................................................
!! ## LICENSING
!! Copyright (C) 2017  National Renewable Energy Laboratory
!!
!!    This file is part of FAST_Farm.
!!
!! Licensed under the Apache License, Version 2.0 (the "License");
!! you may not use this file except in compliance with the License.
!! You may obtain a copy of the License at
!!
!!     http://www.apache.org/licenses/LICENSE-2.0
!!
!! Unless required by applicable law or agreed to in writing, software
!! distributed under the License is distributed on an "AS IS" BASIS,
!! WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
!! See the License for the specific language governing permissions and
!! limitations under the License.
!**********************************************************************************************************************************
module SuperController

   use SuperController_Types
   use NWTC_Library

   implicit none
   private

   type(ProgDesc), parameter    :: SC_Ver = ProgDesc( 'Super Controller', '', '' )

      !> Definition of the DLL Interface for the SuperController
      !!
   abstract interface
      subroutine SC_DLL_Init_PROC ( nTurbines, nInpGlobal, NumCtrl2SC, NumParamGlobal, NumParamTurbine, NumStatesGlobal, NumStatesTurbine, NumSC2CtrlGlob, NumSC2Ctrl, errStat, errMsg )  BIND(C)
         use, intrinsic :: ISO_C_Binding
         integer(C_INT),         intent(in   ) :: nTurbines         !< number of turbines connected to this supercontroller
         integer(C_INT),         intent(  out) :: nInpGlobal          !< number of global inputs to supercontroller
         integer(C_INT),         intent(  out) :: NumCtrl2SC          !< number of turbine controller outputs [inputs to supercontroller]
         integer(C_INT),         intent(  out) :: NumParamGlobal      !< number of global parameters
         integer(C_INT),         intent(  out) :: NumParamTurbine     !< number of parameters per turbine
         integer(C_INT),         intent(  out) :: NumStatesGlobal       !< number of global states
         integer(C_INT),         intent(  out) :: NumStatesTurbine      !< number of states per turbine
         integer(C_INT),         intent(  out) :: NumSC2CtrlGlob      !< number of global controller inputs [from supercontroller]
         integer(C_INT),         intent(  out) :: NumSC2Ctrl          !< number of turbine specific controller inputs [output from supercontroller]
         integer(C_INT),         intent(  out) :: errStat             !< error status code (uses NWTC_Library error codes)
         character(kind=C_CHAR), intent(inout) :: errMsg          (*) !< Error Message from DLL to simulation code
      end subroutine SC_DLL_Init_PROC
   end interface

#ifdef STATIC_DLL_LOAD
   interface
      subroutine SC_DLL_Init ( nTurbines, nInpGlobal, NumCtrl2SC, NumParamGlobal, NumParamTurbine, NumStatesGlobal, NumStatesTurbine, NumSC2CtrlGlob, NumSC2Ctrl, errStat, errMsg )  BIND(C)
         use, intrinsic :: ISO_C_Binding
         integer(C_INT),         intent(in   ) :: nTurbines         !< number of turbines connected to this supercontroller
         integer(C_INT),         intent(  out) :: nInpGlobal          !< number of global inputs to supercontroller
         integer(C_INT),         intent(  out) :: NumCtrl2SC          !< number of turbine controller outputs [inputs to supercontroller]
         integer(C_INT),         intent(  out) :: NumParamGlobal      !< number of global parameters
         integer(C_INT),         intent(  out) :: NumParamTurbine     !< number of parameters per turbine
         integer(C_INT),         intent(  out) :: NumStatesGlobal       !< number of global states
         integer(C_INT),         intent(  out) :: NumStatesTurbine      !< number of states per turbine
         integer(C_INT),         intent(  out) :: NumSC2CtrlGlob      !< number of global controller inputs [from supercontroller]
         integer(C_INT),         intent(  out) :: NumSC2Ctrl          !< number of turbine specific controller inputs [output from supercontroller]
         integer(C_INT),         intent(  out) :: errStat             !< error status code (uses NWTC_Library error codes)
         character(kind=C_CHAR), intent(inout) :: errMsg          (*) !< Error Message from DLL to simulation code
      end subroutine SC_DLL_Init
   end interface
#endif

   abstract interface
      subroutine SC_DLL_GetInitData_PROC (nTurbines, NumParamGlobal, NumParamTurbine, ParamGlobal, ParamTurbine, NumSC2CtrlGlob, from_SCglob, NumSC2Ctrl, from_SC, nStatesGlobal, StatesGlob, nStatesTurbine, StatesTurbine, errStat, errMsg )  BIND(C)
         use, intrinsic :: ISO_C_Binding
         integer(C_INT),            intent(in   ) :: nTurbines         !< number of turbines connected to this supercontroller
         integer(C_INT),            intent(in   ) :: NumParamGlobal      !< number of global parameters
         integer(C_INT),            intent(in   ) :: NumParamTurbine     !< number of parameters per turbine
         real(C_FLOAT),             intent(inout) :: ParamGlobal     (*) !< global parameters
         real(C_FLOAT),             intent(inout) :: ParamTurbine    (*) !< turbine-based parameters
         integer(C_INT),            intent(in   ) :: NumSC2CtrlGlob    !< number of global controller inputs [from supercontroller]
         real(C_FLOAT),             intent(inout) :: from_SCglob  (*)  !< global outputs of the super controller (to the turbine controller)
         integer(C_INT),            intent(in   ) :: NumSC2Ctrl        !< number of turbine specific controller inputs [output from supercontroller]
         real(C_FLOAT),             intent(inout) :: from_SC      (*)  !< turbine specific outputs of the super controller (to the turbine controller)
         integer(C_INT),         intent(in   ) :: nStatesGlobal     !< number of global states
         real(C_FLOAT),          intent(inout) :: StatesGlob   (*)  !< global states at time increment, n (total of nStatesGlobal of these states)
         integer(C_INT),         intent(in   ) :: nStatesTurbine    !< number of states per turbine
         real(C_FLOAT),          intent(inout) :: StatesTurbine(*)  !< turbine-dependent states at time increment, n (total of nTurbines*nStatesTurbine of these states)
         integer(C_INT),            intent(inout) :: errStat             !< error status code (uses NWTC_Library error codes)
         character(kind=C_CHAR),    intent(inout) :: errMsg          (*) !< Error Message from DLL to simulation code
      end subroutine SC_DLL_GetInitData_PROC
   end interface

#ifdef STATIC_DLL_LOAD
   interface
      subroutine SC_DLL_GetInitData ( nTurbines, NumParamGlobal, NumParamTurbine, ParamGlobal, ParamTurbine, NumSC2CtrlGlob, from_SCglob, NumSC2Ctrl, from_SC, nStatesGlobal, StatesGlob, nStatesTurbine, StatesTurbine, errStat, errMsg )  BIND(C)
         use, intrinsic :: ISO_C_Binding
         integer(C_INT),            intent(in   ) :: nTurbines         !< number of turbines connected to this supercontroller
         integer(C_INT),            intent(in   ) :: NumParamGlobal      !< number of global parameters
         integer(C_INT),            intent(in   ) :: NumParamTurbine     !< number of parameters per turbine
         real(C_FLOAT),             intent(inout) :: ParamGlobal     (*) !< global parameters
         real(C_FLOAT),             intent(inout) :: ParamTurbine    (*) !< turbine-based parameters
         integer(C_INT),            intent(in   ) :: NumSC2CtrlGlob    !< number of global controller inputs [from supercontroller]
         real(C_FLOAT),             intent(inout) :: from_SCglob  (*)  !< global outputs of the super controller (to the turbine controller)
         integer(C_INT),            intent(in   ) :: NumSC2Ctrl        !< number of turbine specific controller inputs [output from supercontroller]
         real(C_FLOAT),             intent(inout) :: from_SC      (*)  !< turbine specific outputs of the super controller (to the turbine controller)
         integer(C_INT),         intent(in   ) :: nStatesGlobal     !< number of global states
         real(C_FLOAT),          intent(inout) :: StatesGlob   (*)  !< global states at time increment, n (total of nStatesGlobal of these states)
         integer(C_INT),         intent(in   ) :: nStatesTurbine    !< number of states per turbine
         real(C_FLOAT),          intent(inout) :: StatesTurbine(*)  !< turbine-dependent states at time increment, n (total of nTurbines*nStatesTurbine of these states)
         integer(C_INT),            intent(inout) :: errStat             !< error status code (uses NWTC_Library error codes)
         character(kind=C_CHAR),    intent(inout) :: errMsg          (*) !< Error Message from DLL to simulation code
      end subroutine SC_DLL_GetInitData
   end interface
#endif


   abstract interface
      subroutine SC_DLL_CalcOutput_PROC ( t, nTurbines, NumParamGlobal, ParamGlobal, NumParamTurbine, ParamTurbine, nInpGlobal, to_SCglob, NumCtrl2SC, to_SC, &
                        nStatesGlobal, StatesGlob, nStatesTurbine, StatesTurbine, NumSC2CtrlGlob, from_SCglob, &
                        NumSC2Ctrl, from_SC, errStat, errMsg )  BIND(C)
         use, intrinsic :: ISO_C_Binding
         real(C_DOUBLE),         INTENT(IN   ) :: t                 !< time (s)
         integer(C_INT),         intent(in   ) :: nTurbines         !< number of turbines connected to this supercontroller
         integer(C_INT),         intent(in   ) :: NumParamGlobal      !< number of global parameters
         real(C_FLOAT),          intent(in   ) :: ParamGlobal     (*) !< global parameters
         integer(C_INT),         intent(in   ) :: NumParamTurbine     !< number of parameters per turbine
         real(C_FLOAT),          intent(in   ) :: ParamTurbine    (*) !< turbine-based parameters
         integer(C_INT),         intent(in   ) :: nInpGlobal        !< number of global inputs to supercontroller
         real(C_FLOAT),          intent(in   ) :: to_SCglob    (*)  !< global inputs to the supercontroller
         integer(C_INT),         intent(in   ) :: NumCtrl2SC        !< number of turbine controller outputs [inputs to supercontroller]
         real(C_FLOAT),          intent(in   ) :: to_SC        (*)  !< inputs to the super controller (from the turbine controller)
         integer(C_INT),         intent(in   ) :: nStatesGlobal     !< number of global states
         real(C_FLOAT),          intent(in   ) :: StatesGlob   (*)  !< global states at time increment, n (total of nStatesGlobal of these states)
         integer(C_INT),         intent(in   ) :: nStatesTurbine    !< number of states per turbine
         real(C_FLOAT),          intent(in   ) :: StatesTurbine(*)  !< turbine-dependent states at time increment, n (total of nTurbines*nStatesTurbine of these states)
         integer(C_INT),         intent(in   ) :: NumSC2CtrlGlob    !< number of global controller inputs [from supercontroller]
         real(C_FLOAT),          intent(inout) :: from_SCglob  (*)  !< global outputs of the super controller (to the turbine controller)
         integer(C_INT),         intent(in   ) :: NumSC2Ctrl        !< number of turbine specific controller inputs [output from supercontroller]
         real(C_FLOAT),          intent(inout) :: from_SC      (*)  !< turbine specific outputs of the super controller (to the turbine controller)
         integer(C_INT),         intent(inout) :: errStat           !< error status code (uses NWTC_Library error codes)
         character(kind=C_CHAR), intent(inout) :: errMsg       (*)  !< Error Message from DLL to simulation code
      end subroutine SC_DLL_CalcOutput_PROC
   end interface

#ifdef STATIC_DLL_LOAD
   interface
      subroutine SC_DLL_CalcOutput ( t, nTurbines, NumParamGlobal, ParamGlobal, NumParamTurbine, ParamTurbine, nInpGlobal, to_SCglob, NumCtrl2SC, to_SC, &
                        nStatesGlobal, StatesGlob, nStatesTurbine, StatesTurbine, NumSC2CtrlGlob, from_SCglob, &
                        NumSC2Ctrl, from_SC, errStat, errMsg )  BIND(C)
         use, intrinsic :: ISO_C_Binding
         real(C_DOUBLE),         INTENT(IN   ) :: t                 !< time (s)
         integer(C_INT),         intent(in   ) :: nTurbines         !< number of turbines connected to this supercontroller
         integer(C_INT),         intent(in   ) :: NumParamGlobal      !< number of global parameters
         real(C_FLOAT),          intent(in   ) :: ParamGlobal     (*) !< global parameters
         integer(C_INT),         intent(in   ) :: NumParamTurbine     !< number of parameters per turbine
         real(C_FLOAT),          intent(in   ) :: ParamTurbine    (*) !< turbine-based parameters
         integer(C_INT),         intent(in   ) :: nInpGlobal        !< number of global inputs to supercontroller
         real(C_FLOAT),          intent(in   ) :: to_SCglob    (*)  !< global inputs to the supercontroller
         integer(C_INT),         intent(in   ) :: NumCtrl2SC        !< number of turbine controller outputs [inputs to supercontroller]
         real(C_FLOAT),          intent(in   ) :: to_SC        (*)  !< inputs to the super controller (from the turbine controller)
         integer(C_INT),         intent(in   ) :: nStatesGlobal     !< number of global states
         real(C_FLOAT),          intent(in   ) :: StatesGlob   (*)  !< global states at time increment, n (total of nStatesGlobal of these states)
         integer(C_INT),         intent(in   ) :: nStatesTurbine    !< number of states per turbine
         real(C_FLOAT),          intent(in   ) :: StatesTurbine(*)  !< turbine-dependent states at time increment, n (total of nTurbines*nStatesTurbine of these states)
         integer(C_INT),         intent(in   ) :: NumSC2CtrlGlob    !< number of global controller inputs [from supercontroller]
         real(C_FLOAT),          intent(inout) :: from_SCglob  (*)  !< global outputs of the super controller (to the turbine controller)
         integer(C_INT),         intent(in   ) :: NumSC2Ctrl        !< number of turbine specific controller inputs [output from supercontroller]
         real(C_FLOAT),          intent(inout) :: from_SC      (*)  !< turbine specific outputs of the super controller (to the turbine controller)
         integer(C_INT),         intent(inout) :: errStat           !< error status code (uses NWTC_Library error codes)
         character(kind=C_CHAR), intent(inout) :: errMsg       (*)  !< Error Message from DLL to simulation code
      end subroutine SC_DLL_CalcOutput
   end interface
#endif

abstract interface
      subroutine SC_DLL_UpdateStates_PROC ( t, nTurbines, NumParamGlobal, ParamGlobal, NumParamTurbine, ParamTurbine, nInpGlobal, to_SCglob, NumCtrl2SC, to_SC, &
                        nStatesGlobal, StatesGlob, nStatesTurbine, StatesTurbine, errStat, errMsg )  BIND(C)
         use, intrinsic :: ISO_C_Binding
         real(C_DOUBLE),         INTENT(IN   ) :: t                 !< time (s)
         integer(C_INT),         intent(in   ) :: nTurbines         !< number of turbines connected to this supercontroller
         integer(C_INT),         intent(in   ) :: NumParamGlobal      !< number of global parameters
         real(C_FLOAT),          intent(in   ) :: ParamGlobal     (*) !< global parameters
         integer(C_INT),         intent(in   ) :: NumParamTurbine     !< number of parameters per turbine
         real(C_FLOAT),          intent(in   ) :: ParamTurbine    (*) !< turbine-based parameters
         integer(C_INT),         intent(in   ) :: nInpGlobal        !< number of global inputs to supercontroller
         real(C_FLOAT),          intent(in   ) :: to_SCglob    (*)  !< global inputs to the supercontroller
         integer(C_INT),         intent(in   ) :: NumCtrl2SC        !< number of turbine controller outputs [inputs to supercontroller]
         real(C_FLOAT),          intent(in   ) :: to_SC        (*)  !< inputs to the super controller (from the turbine controller)
         integer(C_INT),         intent(in   ) :: nStatesGlobal     !< number of global states
         real(C_FLOAT),          intent(inout) :: StatesGlob   (*)  !< global states at time increment, n (total of nStatesGlobal of these states)
         integer(C_INT),         intent(in   ) :: nStatesTurbine    !< number of states per turbine
         real(C_FLOAT),          intent(inout) :: StatesTurbine(*)  !< turbine-dependent states at time increment, n (total of nTurbines*nStatesTurbine of these states)
         integer(C_INT),         intent(inout) :: errStat           !< error status code (uses NWTC_Library error codes)
         character(kind=C_CHAR), intent(inout) :: errMsg       (*)  !< Error Message from DLL to simulation code
      end subroutine SC_DLL_UpdateStates_PROC
   end interface

#ifdef STATIC_DLL_LOAD
   interface
      subroutine SC_DLL_UpdateStates ( t, nTurbines, NumParamGlobal, ParamGlobal, NumParamTurbine, ParamTurbine, nInpGlobal, to_SCglob, NumCtrl2SC, to_SC, &
                        nStatesGlobal, StatesGlob, nStatesTurbine, StatesTurbine, errStat, errMsg )  BIND(C)
         use, intrinsic :: ISO_C_Binding
         real(C_DOUBLE),         INTENT(IN   ) :: t                 !< time (s)
         integer(C_INT),         intent(in   ) :: nTurbines         !< number of turbines connected to this supercontroller
         integer(C_INT),         intent(in   ) :: NumParamGlobal      !< number of global parameters
         real(C_FLOAT),          intent(in   ) :: ParamGlobal     (*) !< global parameters
         integer(C_INT),         intent(in   ) :: NumParamTurbine     !< number of parameters per turbine
         real(C_FLOAT),          intent(in   ) :: ParamTurbine    (*) !< turbine-based parameters
         integer(C_INT),         intent(in   ) :: nInpGlobal        !< number of global inputs to supercontroller
         real(C_FLOAT),          intent(in   ) :: to_SCglob    (*)  !< global inputs to the supercontroller
         integer(C_INT),         intent(in   ) :: NumCtrl2SC        !< number of turbine controller outputs [inputs to supercontroller]
         real(C_FLOAT),          intent(in   ) :: to_SC        (*)  !< inputs to the super controller (from the turbine controller)
         integer(C_INT),         intent(in   ) :: nStatesGlobal     !< number of global states
         real(C_FLOAT),          intent(inout) :: StatesGlob   (*)  !< global states at time increment, n (total of nStatesGlobal of these states)
         integer(C_INT),         intent(in   ) :: nStatesTurbine    !< number of states per turbine
         real(C_FLOAT),          intent(inout) :: StatesTurbine(*)  !< turbine-dependent states at time increment, n (total of nTurbines*nStatesTurbine of these states)
         integer(C_INT),         intent(inout) :: errStat           !< error status code (uses NWTC_Library error codes)
         character(kind=C_CHAR), intent(inout) :: errMsg       (*)  !< Error Message from DLL to simulation code
      end subroutine SC_DLL_UpdateStates
   end interface
#endif

   abstract interface
      subroutine SC_DLL_End_PROC ( errStat, errMsg )  BIND(C)
         use, intrinsic :: ISO_C_Binding
         integer(C_INT),         intent(inout) :: errStat           !< error status code (uses NWTC_Library error codes)
         character(kind=C_CHAR), intent(inout) :: errMsg       (*)  !< Error Message from DLL to simulation code
      end subroutine SC_DLL_End_PROC
   end interface

#ifdef STATIC_DLL_LOAD
   interface
      subroutine SC_DLL_End ( errStat, errMsg )  BIND(C)
         use, intrinsic :: ISO_C_Binding
         integer(C_INT),         intent(inout) :: errStat           !< error status code (uses NWTC_Library error codes)
         character(kind=C_CHAR), intent(inout) :: errMsg       (*)  !< Error Message from DLL to simulation code
      end subroutine SC_DLL_End
   end interface
#endif
   public :: SC_Init                           ! Initialization routine
   public :: SC_End                            ! Ending routine (includes clean up)
   public :: SC_UpdateStates                   ! Loose coupling routine for solving for constraint states, integrating
                                               !   continuous states, and updating discrete states
   public :: SC_CalcOutput                     ! Routine for computing outputs
   !public :: SC_CalcContStateDeriv             ! Tight coupling routine for computing derivatives of continuous states


   contains

   SUBROUTINE SC_End( u, p, x, xd, z, OtherState, y, m, ErrStat, ErrMsg )

      TYPE(SC_InputType),           INTENT(INOUT)  :: u           !< System inputs
      TYPE(SC_ParameterType),       INTENT(INOUT)  :: p           !< Parameters
      TYPE(SC_ContinuousStateType), INTENT(INOUT)  :: x           !< Continuous states
      TYPE(SC_DiscreteStateType),   INTENT(INOUT)  :: xd          !< Discrete states
      TYPE(SC_ConstraintStateType), INTENT(INOUT)  :: z           !< Constraint states
      TYPE(SC_OtherStateType),      INTENT(INOUT)  :: OtherState  !< Other states
      TYPE(SC_OutputType),          INTENT(INOUT)  :: y           !< System outputs
      TYPE(SC_MiscVarType),         INTENT(INOUT)  :: m           !< Initial misc (optimization) variables
      INTEGER(IntKi),               INTENT(  OUT)  :: ErrStat     !< Error status of the operation
      CHARACTER(*),                 INTENT(  OUT)  :: ErrMsg      !< Error message if ErrStat /= ErrID_None


         ! local variables
      character(*), parameter                        :: routineName = 'SC_End'
      integer(IntKi)                                 :: errStat2       ! The error status code
      character(ErrMsgLen)                           :: errMsg2        ! The error message, if an error occurred
      procedure(SC_DLL_End_PROC),  pointer           :: DLL_SC_Subroutine              ! The address of the supercontroller sc_end procedure in the DLL

      errStat = ErrID_None
      errMsg= ''

#ifdef STATIC_DLL_LOAD

      ! if we're statically loading the library (i.e., OpenFOAM), we can just call DISCON();
      ! I'll leave some options for whether the supercontroller is being used

      call SC_DLL_End ( errStat, errMsg )

#else

         ! Call the DLL (first associate the address from the procedure in the DLL with the subroutine):
      call C_F_PROCPOINTER( p%DLL_Trgt%ProcAddr(5), DLL_SC_Subroutine)
      call DLL_SC_Subroutine ( errStat, errMsg )

#endif


      call FreeDynamicLib( p%DLL_Trgt, errStat2, errMsg2 )  ! this doesn't do anything #ifdef STATIC_DLL_LOAD  because p%DLL_Trgt is 0 (NULL)
         call SetErrStat( errStat2, errMsg2, errStat, errMsg, routineName )

   end subroutine SC_End

   subroutine SC_Init(InitInp, u, p, x, xd, z, OtherState, y, m, interval, InitOut, errStat, errMsg )
      type(SC_InitInputType),       intent(in   )  :: InitInp     !< Input data for initialization routine
      type(SC_InputType),           intent(  out)  :: u           !< An initial guess for the input; input mesh must be defined
      type(SC_ParameterType),       intent(  out)  :: p           !< Parameters
      type(SC_ContinuousStateType), intent(  out)  :: x           !< Initial continuous states
      type(SC_DiscreteStateType),   intent(  out)  :: xd          !< Initial discrete states
      type(SC_ConstraintStateType), intent(  out)  :: z           !< Initial guess of the constraint states
      type(SC_OtherStateType),      intent(  out)  :: OtherState  !< Initial other states
      type(SC_OutputType),          intent(  out)  :: y           !< Initial system outputs (outputs are not calculated;
                                                                  !!   only the output mesh is initialized)
      type(SC_MiscVarType),         intent(  out)  :: m           !< Misc variables for optimization (not copied in glue code)
      real(DbKi),                   intent(in   )  :: interval    !< Coupling interval in seconds
      type(SC_InitOutputType),      intent(  out)  :: InitOut     !< Output for initialization routine
      integer(IntKi),               intent(  out)  :: errStat     !< Error status of the operation
      character(1024),              intent(  out)  :: errMsg      !< Error message if ErrStat /= ErrID_None


         ! local variables
      character(*), parameter                 :: routineName = 'SC_Init'
      integer(IntKi)                          :: errStat2                ! The error status code
      character(ErrMsgLen)                    :: errMsg2                 ! The error message, if an error occurred
      procedure(SC_DLL_Init_PROC),pointer     :: DLL_SC_Init_Subroutine       ! The address of the supercontroller sc_init procedure in the DLL
      procedure(SC_DLL_GetInitData_PROC),pointer     :: DLL_SC_GetInitData_Subroutine

      integer(IntKi)                          :: nParams


      errStat2 = ErrID_None
      errMsg2  = ''

      call DispNVD( SC_Ver )  ! Display the version of this interface

      ! p%UseSC           = InitInp%UseSC
      ! if ( p%UseSC ) then

         ! The Glue code needs to tell the super controller how many turbines are in the plant/farm.
      p%nTurbines      = InitInp%nTurbines



         ! The following parameters are determined by the super controller implementation, which is done inside the shared
         ! library, so first load the library.
#ifdef STATIC_DLL_LOAD
            ! because OpenFOAM needs the MPI task to copy the library, we're not going to dynamically load it; it needs to be loaded at runtime.
      p%DLL_Trgt%FileName = ''
      p%DLL_Trgt%ProcName = ''
#else

         ! Define and load the DLL:

      p%DLL_Trgt%FileName = InitInp%DLL_FileName

      p%DLL_Trgt%ProcName = "" ! initialize all procedures to empty so we try to load only one
      p%DLL_Trgt%ProcName(1) = 'SC_Init'
      p%DLL_Trgt%ProcName(2) = 'SC_GetInitData'
      p%DLL_Trgt%ProcName(3) = 'SC_UpdateStates'
      p%DLL_Trgt%ProcName(4) = 'SC_CalcOutputs'
      p%DLL_Trgt%ProcName(5) = 'SC_End'

      call LoadDynamicLib ( p%DLL_Trgt, errStat2, errMsg2 )
         call SetErrStat( errStat2, errMsg2, errStat, errMsg, routineName )
      if (errStat > AbortErrLev ) return
#endif

         ! Now that the library is loaded, call SC_Init() to obtain the user-specified inputs/output/states

      p%nInpGlobal = 0
      p%NumParamGlobal = 0
      p%NumParamTurbine = 0
      p%NumSC2CtrlGlob = 0
      p%NumSC2Ctrl = 0
      p%NumCtrl2SC = 0
      p%NumStatesGlobal = 0
      p%NumStatesTurbine = 0

#ifdef STATIC_DLL_LOAD

         ! if we're statically loading the library (i.e., OpenFOAM), we can just call SC_INIT();
      call SC_DLL_INIT( p%nTurbines, p%nInpGlobal, p%NumCtrl2SC, p%NumParamGlobal, p%NumParamTurbine, p%NumStatesGlobal, p%NumStatesTurbine, p%NumSC2CtrlGlob, p%NumSC2Ctrl, errStat, errMsg )
      ! TODO: Check errors
#else

         ! Call the DLL (first associate the address from the procedure in the DLL with the subroutine):
      call C_F_PROCPOINTER( p%DLL_Trgt%ProcAddr(1), DLL_SC_Init_Subroutine)
      !call DLL_SC_Subroutine ( p%nTurbines, p%nInpGlobal, p%NumCtrl2SC, p%NumParamGlobal, ParamGlobal, p%NumParamTurbine, ParamTurbine, p%NumStatesGlobal, p%NumStatesTurbine, p%NumSC2CtrlGlob, p%NumSC2Ctrl, errStat, errMsg )
      call DLL_SC_Init_Subroutine ( p%nTurbines, p%nInpGlobal, p%NumCtrl2SC, p%NumParamGlobal,  p%NumParamTurbine,  p%NumStatesGlobal, p%NumStatesTurbine, p%NumSC2CtrlGlob, p%NumSC2Ctrl, errStat, errMsg )
      ! TODO: Check errors

#endif

      ! NOTE: For now we have not implemented the global super controller inputs in any of the openfast glue codes,
      !       so the number must be set to zero
      if (p%nInpGlobal        /= 0) call SetErrStat( ErrID_Fatal, "nInpGlobal must to be equal to zero."     , errStat, errMsg, RoutineName )
      if (p%NumSC2CtrlGlob     < 0) call SetErrStat( ErrID_Fatal, "NumSC2CtrlGlob must to be greater than or equal to zero."     , errStat, errMsg, RoutineName )
      if (p%NumSC2Ctrl         < 0) call SetErrStat( ErrID_Fatal, "NumSC2Ctrl must to be greater than or equal to zero."     , errStat, errMsg, RoutineName )
      if (p%NumCtrl2SC         < 0) call SetErrStat( ErrID_Fatal, "NumCtrl2SC must to be greater than or equal to zero."     , errStat, errMsg, RoutineName )
      if (p%NumStatesGlobal      < 0) call SetErrStat( ErrID_Fatal, "NumStatesGlobal must to be greater than or equal to zero."  , errStat, errMsg, RoutineName )
      if (p%NumStatesTurbine     < 0) call SetErrStat( ErrID_Fatal, "NumStatesTurbine must to be greater than or equal to zero." , errStat, errMsg, RoutineName )

      if (errStat > AbortErrLev ) return

          ! allocate state arrays
      ! TODO Fix allocations for error handling
      allocate(xd%Global(p%NumStatesGlobal))
            !CALL AllocAry( xd%Global,   p%nStatesGlobal, 'xd%Global', errStat2, errMsg2 )
            !   call SetErrStat( errStat2, errMsg2, errStat, errMsg, routineName )
      allocate(xd%Turbine(p%NumStatesTurbine*p%nTurbines) )
            ! CALL AllocAry( xd%Turbine,   p%nStatesTurbine, 'xd%Turbine', errStat2, errMsg2 )
            !   call SetErrStat( errStat2, errMsg2, errStat, errMsg, routineName )
      
          ! allocate output arrays
      allocate(y%fromSCglob(p%NumSC2CtrlGlob))
      allocate(y%fromSC    (p%NumSC2Ctrl*p%nTurbines    ))

         ! allocate input arrays
      allocate(u%toSCglob(p%nInpGlobal))
      allocate(u%toSC    (p%NumCtrl2SC*p%nTurbines))

         ! Copy the Parameter and Output data created by the SuperController library into the FAST-framework parameters data structure
      if ( (p%NumParamGlobal > 0) .or. (p%NumParamTurbine > 0) .or. (p%NumSC2CtrlGlob > 0) .or. (p%NumSC2Ctrl > 0) ) then
         allocate(p%ParamGlobal(p%NumParamGlobal))
         nParams = p%NumParamTurbine*p%nTurbines
         allocate(p%ParamTurbine(nParams))

#ifdef STATIC_DLL_LOAD

            ! if we're statically loading the library (i.e., OpenFOAM), we can just call SC_INIT();
         call SC_DLL_GetInitData( p%nTurbines, p%NumParamGlobal, p%NumParamTurbine, p%ParamGlobal,  p%ParamTurbine, p%NumSC2CtrlGlob, y%fromSCglob, p%NumSC2Ctrl, y%fromSC, &
              p%NumStatesGlobal, xd%Global, p%NumStatesTurbine, xd%Turbine, errStat, errMsg )
      ! TODO: Check errors
#else

            ! Call the DLL (first associate the address from the procedure in the DLL with the subroutine):
         call C_F_PROCPOINTER( p%DLL_Trgt%ProcAddr(2), DLL_SC_GetInitData_Subroutine)
         !call DLL_SC_Subroutine ( p%nTurbines, p%nInpGlobal, p%NumCtrl2SC, p%NumParamGlobal, ParamGlobal, p%NumParamTurbine, ParamTurbine, p%NumStatesGlobal, p%NumStatesTurbine, p%NumSC2CtrlGlob, p%NumSC2Ctrl, errStat, errMsg )
         call DLL_SC_GetInitData_Subroutine ( p%nTurbines, p%NumParamGlobal, p%NumParamTurbine, p%ParamGlobal,  p%ParamTurbine, p%NumSC2CtrlGlob, y%fromSCglob, p%NumSC2Ctrl, y%fromSC, &
              p%NumStatesGlobal, xd%Global, p%NumStatesTurbine, xd%Turbine, errStat, errMsg )
         ! TODO: Check errors

#endif

      end if          !IDEALLY THROW AN ERROR AND QUIT HERE IF THIS CRITERIA IS NOT MET

      p%DT          = interval


         ! Set the initialization output data for the glue code so that it knows
         ! how many inputs/outputs there are
      InitOut%nInpGlobal       = p%nInpGlobal
      InitOut%NumSC2CtrlGlob   = p%NumSC2CtrlGlob
      InitOut%NumSC2Ctrl       = p%NumSC2Ctrl
      InitOut%NumCtrl2SC       = p%NumCtrl2SC
      !

   end subroutine SC_Init

   subroutine SC_CalcOutput(t, u, p, x, xd, z, OtherState, y, m, errStat, errMsg )
      real(DbKi),                   intent(in   )  :: t           !< Current simulation time in seconds
      type(SC_InputType),           intent(in   )  :: u           !< Inputs at Time t
      type(SC_ParameterType),       intent(in   )  :: p           !< Parameters
      type(SC_ContinuousStateType), intent(in   )  :: x           !< Continuous states at t
      type(SC_DiscreteStateType),   intent(in   )  :: xd          !< Discrete states at t
      type(SC_ConstraintStateType), intent(in   )  :: z           !< Constraint states at t
      type(SC_OtherStateType),      intent(in   )  :: OtherState  !< Other states
      type(SC_OutputType),          intent(inout)  :: y           !< Outputs computed at t (Input only so that mesh con-
                                                                  !!   nectivity information does not have to be recalculated)
      type(SC_MiscVarType),         intent(inout)  :: m           !< Misc variables for optimization (not copied in glue code)
      integer(IntKi),               intent(  out)  :: errStat     !< Error status of the operation
      character(*),                 intent(  out)  :: errMsg      !< Error message if ErrStat /= ErrID_None


      character(*), parameter                        :: routineName = 'SC_CalcOutput'
      integer(IntKi)                                 :: errStat2       ! The error status code
      character(ErrMsgLen)                           :: errMsg2        ! The error message, if an error occurred
      procedure(SC_DLL_CalcOutput_PROC),pointer :: DLL_SC_Subroutine              ! The address of the supercontroller sc_calcoutputs procedure in the DLL


      errStat2 = ErrID_None
      errMsg2  = ''


#ifdef STATIC_DLL_LOAD

      ! if we're statically loading the library (i.e., OpenFOAM), we can just call DISCON();
      ! I'll leave some options for whether the supercontroller is being used

   call SC_DLL_CalcOutput ( REAL(t,C_DOUBLE), p%nTurbines, p%NumParamGlobal, p%ParamGlobal, p%NumParamTurbine, p%ParamTurbine, p%nInpGlobal, u%toSCglob, p%NumCtrl2SC, u%toSC, &
                        p%nStatesGlobal, xd%Global, p%nStatesTurbine, xd%Turbine, p%NumSC2CtrlGlob, y%fromSCglob, &
                        p%NumSC2Ctrl, y%fromSC, errStat, errMsg )

#else

         ! Call the DLL (first associate the address from the procedure in the DLL with the subroutine):
      call C_F_PROCPOINTER( p%DLL_Trgt%ProcAddr(4), DLL_SC_Subroutine)
      call DLL_SC_Subroutine ( REAL(t,C_DOUBLE), p%nTurbines, p%NumParamGlobal, p%ParamGlobal, p%NumParamTurbine, p%ParamTurbine, p%nInpGlobal, u%toSCglob, p%NumCtrl2SC, u%toSC, &
                        p%NumStatesGlobal, xd%Global, p%NumStatesTurbine, xd%Turbine, p%NumSC2CtrlGlob, y%fromSCglob, &
                        p%NumSC2Ctrl, y%fromSC, errStat, errMsg )

#endif

   end subroutine SC_CalcOutput

!----------------------------------------------------------------------------------------------------------------------------------
!> This is a loose coupling routine for solving constraint states, integrating continuous states, and updating discrete and other
!! states. Continuous, constraint, discrete, and other states are updated to values at t + Interval.
   subroutine SC_UpdateStates( t, n, u, utimes, p, x, xd, z, OtherState, m, ErrStat, ErrMsg )
!..................................................................................................................................

      real(DbKi),                         intent(in   ) :: t          !< Current simulation time in seconds
      integer(IntKi),                     intent(in   ) :: n          !< Current simulation time step n = 0,1,...
      type(SC_InputType),                 intent(inout) :: u          !< Inputs at utimes (out only for mesh record-keeping in ExtrapInterp routine)
      real(DbKi),                         intent(in   ) :: utimes(:)  !< Times associated with u(:), in seconds
      type(SC_ParameterType),             intent(in   ) :: p          !< Parameters
      type(SC_ContinuousStateType),       intent(inout) :: x          !< Input: Continuous states at t;
                                                                      !!   Output: Continuous states at t + Interval
      type(SC_DiscreteStateType),         intent(inout) :: xd         !< Input: Discrete states at t;
                                                                      !!   Output: Discrete states at t + Interval
      type(SC_ConstraintStateType),       intent(inout) :: z          !< Input: Constraint states at t;
                                                                      !!   Output: Constraint states at t + Interval
      type(SC_OtherStateType),            intent(inout) :: OtherState !< Other states: Other states at t;
                                                                      !!   Output: Other states at t + Interval
      type(SC_MiscVarType),               intent(inout) :: m          !< Misc variables for optimization (not copied in glue code)
      integer(IntKi),                     intent(  out) :: ErrStat    !< Error status of the operation
      character(*),                       intent(  out) :: ErrMsg     !< Error message if ErrStat /= ErrID_None

         ! local variables
      character(*), parameter                   :: routineName = 'SC_UpdateStates'
      integer(IntKi)                            :: errStat2       ! The error status code
      character(ErrMsgLen)                      :: errMsg2        ! The error message, if an error occurred

      procedure(SC_DLL_UpdateStates_PROC),pointer :: DLL_SC_Subroutine              ! The address of the supercontroller sc_updatestates procedure in the DLL

      errStat2 = ErrID_None
      errMsg2  = ''

#ifdef STATIC_DLL_LOAD

      ! if we're statically loading the library (i.e., OpenFOAM), we can just call DISCON();
      ! I'll leave some options for whether the supercontroller is being used

   !CALL DISCON( dll_data%avrSWAP, filt_fromSCglob, filt_fromSC, dll_data%toSC, aviFAIL, accINFILE, avcOUTNAME, avcMSG )
   call SC_DLL_UpdateStates ( REAL(t,C_DOUBLE), p%nTurbines, p%NumParamGlobal, p%ParamGlobal, p%NumParamTurbine, p%ParamTurbine, p%nInpGlobal, u%toSCglob, p%NumCtrl2SC, u%toSC, &
                        p%NumStatesGlobal, xd%Global, p%NumStatesTurbine, xd%Turbine, errStat, errMsg )

#else

         ! Call the DLL (first associate the address from the procedure in the DLL with the subroutine):
      call C_F_PROCPOINTER( p%DLL_Trgt%ProcAddr(3), DLL_SC_Subroutine)
      call DLL_SC_Subroutine ( REAL(t,C_DOUBLE), p%nTurbines, p%NumParamGlobal, p%ParamGlobal, p%NumParamTurbine, p%ParamTurbine, p%nInpGlobal, u%toSCglob, p%NumCtrl2SC, u%toSC, &
                        p%NumStatesGlobal, xd%Global, p%NumStatesTurbine, xd%Turbine, errStat, errMsg )

#endif

   end subroutine SC_UpdateStates


end module SuperController
