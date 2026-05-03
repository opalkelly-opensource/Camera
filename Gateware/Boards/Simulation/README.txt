These are the simulation testbenches and do-files for the XEM6110 - EVB1005.
Note that all tests use the MIG-generated core which performs an IDELAY 
calibration at system startup.  This calibration cycle can take over 50 us
to complete before the core is ready to use and can extend simulation time
considerably.


test_okhi.do
------------
This is a testbench that exercises XEM6110 - EVB1005 interface from simulated host
interface inputs.  This will need to run for at least 100 us. Frames are streamed
from the sensor into the DDR2 and then piped out of the XEM6110.

