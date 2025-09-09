REM DES Simulation Batch File
REM $Rev$ $Date$

REM Edit path for settings32/64, depending on architecture
call %XILINX%\..\settings64.bat

fuse -intstyle ise ^
     -incremental ^
     -lib unisims_ver ^
     -lib unimacro_ver ^
     -lib xilinxcorelib_ver ^
     -L secureip ^
     -i ./oksim ^
     -o tf_isim.exe ^
     -prj isim.prj ^
     work.tf work.glbl
     
REM fuse work.tf work.glbl -prj sim_oktb_isim.prj -L unisims_ver -L xilinxcorelib_ver -L secureip -o isim.exe


