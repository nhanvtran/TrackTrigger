library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

use STD.textio.all;
use work.image_pkg.all;

entity testbench is
end testbench;

architecture testbench_arch of testbench is
      
    signal clock_p : std_logic := '1';
    signal clock_n : std_logic := '0';

    signal scl, sda : std_logic_vector(2 downto 0);

    component top is
        port(
            clock_p, clock_n : in  std_logic;  -- 200mhz, lvds
            MC_A, MC_B : out std_logic; -- constant clocks to the VIPRAM device
            A, B, C, D : out std_logic_vector(15 downto 0);
            RowAddr    : out std_logic_vector(6 downto 0);
            ColAddr    : out std_logic_vector(4 downto 0);
            Miss       : out std_logic_vector(2 downto 0);
            LatchData  : out std_logic;
            EventReArm : out std_logic;
            RunMode    : out std_logic;
            ReqLayerA  : out std_logic;
            Primary    : out std_logic;
            Data       : in  std_logic_vector(31 downto 0);
            --Data       : in  std_logic_vector(31 downto 0);
            VPWR_en    : out std_logic;  -- power control I2C devices
            sda        : inout std_logic_vector(2 downto 0);
            scl        : inout std_logic_vector(2 downto 0);
            led : out std_logic_vector (3 downto 0));
    end component;   
    
    component ltc3447
        port(scl, sda : inout std_logic);
    end component;
   
begin
          
    clock_p <= not clock_p after 2.5ns;
    clock_n <= not clock_p;
        
    DUT: top 
    port map(
        clock_p => clock_p,
        clock_n => clock_n,
        data    => X"00000000",
        sda => sda,
        scl => scl);

dvdd_inst: ltc3447
    port map (scl => scl(0), sda => sda(0));

vdd_inst: ltc3447
    port map (scl => scl(1), sda => sda(1));

vprech_inst: ltc3447
    port map (scl => scl(2), sda => sda(2));  -- there is also LTC2991 on this bus

scl(0) <= 'H';
sda(0) <= 'H';

scl(1) <= 'H';
sda(1) <= 'H';

scl(2) <= 'H';
sda(2) <= 'H';

end testbench_arch;
