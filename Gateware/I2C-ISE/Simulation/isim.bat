REM DES Simulation Batch File
REM $Rev$ $Date$

REM Edit path for settings32/64, depending on architecture
call %XILINX%\..\settings64.bat

fuse -intstyle ise ^
     -incremental ^
     -lib unisims_ver ^
     -lib unimacro_ver ^
     -lib xilinxcorelib_ver ^
     -i ./oksim ^
     -o tf_isim.exe ^
     -prj isim.prj ^
     work.tf work.glbl
tf_isim.exe -gui -tclbatch isim.tcl -wdb isim.wdb