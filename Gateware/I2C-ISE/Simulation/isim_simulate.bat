REM DES Simulation Batch File
REM $Rev$ $Date$

REM Edit path for settings32/64, depending on architecture
call %XILINX%\..\settings64.bat

tf_isim.exe -gui -tclbatch isim.tcl -wdb isim.wdb