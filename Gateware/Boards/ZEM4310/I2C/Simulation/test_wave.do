onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -noupdate -divider  {Toplevel}
add wave -noupdate -format Logic /tf/clk
add wave -noupdate -format Logic /tf/reset
add wave -noupdate -format Logic /tf/start
add wave -noupdate -format Logic /tf/done
add wave -noupdate -format Literal -radix unsigned   /tf/divclk
add wave -noupdate -format Logic /tf/memclk
add wave -noupdate -format Logic /tf/memstart
add wave -noupdate -format Logic /tf/memwrite
add wave -noupdate -format Logic /tf/memread
add wave -noupdate -format Literal -radix hexadecimal   /tf/memdin
add wave -noupdate -format Literal -radix hexadecimal   /tf/memdout
add wave -noupdate -format Logic /tf/i2c_sdat
add wave -noupdate -format Logic /tf/i2c_sdat_out
add wave -noupdate -format Logic /tf/i2c_drive
add wave -noupdate -format Logic /tf/i2c_sclk


add wave -noupdate -divider  {I2C Controller}
add wave -noupdate -format Logic /tf/go

add wave -noupdate -divider  {Clock}
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/divcount
add wave -noupdate -format Logic /tf/dut/divenable
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/phase

add wave -noupdate -divider  {Memory}
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/cmem_addr
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/cmem_dout
add wave -noupdate -format Logic /tf/dut/rmem_write
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/rmem_addr
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/rmem_din
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/mem_addr

add wave -noupdate -divider  {Transmit}
add wave -noupdate -format Literal -radix unsigned /tf/dut/state
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/tcount
add wave -noupdate -format Logic /tf/dut/twrite
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/dev_addr
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/reg_addr

add wave -noupdate -format Literal -radix hexadecimal /tf/dut/tx_tok;
add wave -noupdate -format Logic /tf/dut/tx_start;
add wave -noupdate -format Logic /tf/dut/tx_done
add wave -noupdate -format Logic /tf/dut/tx_enable
add wave -noupdate -format Logic /tf/dut/tx_rack
add wave -noupdate -format Logic /tf/dut/tx_wack
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/tx_count
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/tx_word
add wave -noupdate -format Literal -radix hexadecimal /tf/dut/tx_shift

add wave -noupdate -divider  {IO}
add wave -noupdate -format Logic /tf/dut/i2c_sclk
add wave -noupdate -format Logic /tf/dut/i2c_sdat_in
add wave -noupdate -format Logic /tf/dut/i2c_sdat_out
add wave -noupdate -format Logic /tf/dut/i2c_drive


add wave -noupdate -divider  {I2C Slave Emulation}
add wave -noupdate -format Logic       /tf/i2c_start
add wave -noupdate -format Logic       /tf/i2c_stop
add wave -noupdate -format Logic       /tf/i2c_dir
add wave -noupdate -format Literal -radix unsigned /tf/i2c_bitcursor
add wave -noupdate -format Literal -radix hexadecimal /tf/i2c_wordcap
add wave -noupdate -format Literal -radix hexadecimal /tf/i2c_devaddr
add wave -noupdate -format Logic       /tf/i2c_sdout
add wave -noupdate -format Logic       /tf/i2c_writing
add wave -noupdate -format Literal -radix hexadecimal /tf/i2c_readmem
add wave -noupdate -format Literal -radix hexadecimal /tf/i2c_readout
add wave -noupdate -format Literal -radix unsigned /tf/i2c_readptr
add wave -noupdate -format Logic       /tf/i2c_sclk_setup
add wave -noupdate -format Logic       /tf/i2c_sclk_intent
add wave -noupdate -format Logic       /tf/i2c_clk_stretch
add wave -noupdate -format Logic       /tf/i2c_clk_stretch_count

