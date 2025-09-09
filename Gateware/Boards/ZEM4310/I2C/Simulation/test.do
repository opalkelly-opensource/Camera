#------------------------------------------------------------------------
# test.do
#
# Modelsim simulation script for loopback testing of frontpanel simulations
# for distribution. 
#
#------------------------------------------------------------------------
# Copyright (c) 2005-2014 Opal Kelly Incorporated
# $Id$
#------------------------------------------------------------------------

# Paths

# Aliases
alias c   "do test.do"

transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

#Megafunctions
vlog -vlog01compat -work work  ../../Megafunctions/ram16x8.v

#Altera I2C 
vlog -vlog01compat -work work  ../i2cController.v

#Test Fixture
vlog -vlog01compat -work work  ./i2c_tf.v

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L cycloneiii_ver -L rtl_work -L work -voptargs="+acc"  tf

# Waves
do test_wave.do

#add wave *
#view structure
#view signals
#run -all

run 1500us

#WaveRestoreZoom 0 50us
