REM DDR2 Controller Simulation Batch File
REM $Rev$ $Date$

REM fuse -intstyle ise ^
REM     -incremental ^
REM     -L unisims_ver ^
REM     -lib unimacro_ver ^
REM     -lib xilinxcorelib_ver ^
REM     -o isim.exe ^
REM     -prj isim.prj ^
REM     work.tf work.glbl
     
fuse work.tf work.glbl -prj sim_oktb_isim.prj -L unisims_ver -L xilinxcorelib_ver -L secureip -o isim.exe
isim.exe -gui -tclbatch isim.tcl -wdb isim.wdb