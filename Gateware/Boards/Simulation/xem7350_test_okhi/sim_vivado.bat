REM Simulation Sample Batch File (Vivado)

call xelab work.tf work.glbl -prj isim.prj -L unisims_ver -L unimacro_ver -L secureip -s sim_vivado -debug typical
xsim -g -t vivado_sim_waveforms.tcl -wdb sim_vivado.wdb sim_vivado
