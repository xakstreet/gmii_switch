
set DEVICE "xcvu095-ffva2104-2-e"
set BOARD "xilinx.com:vcu108:part0:1.2"
set PRJ_NAME       "gmii_switch"
set DIR_SOURCES    "./src"
set DIR_SCRIPTS    "./script"
set DIR_CONSTR    "./src/constr"
set DIR_RTL    "./src/rtl"
set DIR_IP    "./src/ip"
set DIR_BITSTREAMS "./bitstreams"
set NUMBER_OF_PROCESSOR_CORES "8"

set PROJECT_HEAP "./xproject"

set RUN_SYNTH "TRUE"
set RUN_IMPL "TRUE"
set RUN_SDK "TRUE"
#check that the correct version of Vivado is being used
set CUR_VIVADO_VER [version -short]
set EXP_VIVADO_VER "2017.1"
if { [string compare $EXP_VIVADO_VER $CUR_VIVADO_VER] != 0 } {
   puts ""
   puts "ERROR: This script is for Vivado <$EXP_VIVADO_VER> and is being run in <$CUR_VIVADO_VER> of Vivado. Please use Vivado <$EXP_VIVADO_VER>"

   return 1
}

puts "SCRIPT_INFO: Building for $BOARD using $DEVICE"

create_project $PRJ_NAME -force $PROJECT_HEAP -part $DEVICE
set_property board_part $BOARD [current_project]

add_files "$DIR_RTL"
add_files [glob $DIR_IP/*/*.xci]
                                                                                                                                     
add_files "$DIR_CONSTR"
add_files -fileset constrs_1 -norecurse $DIR_CONSTR

