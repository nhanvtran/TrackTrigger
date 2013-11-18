-- ltc3447.vhd
-- A I2C controllable switching regulator (generic I2C slave model)
-- Jamieson Olsen <jamieson@fnal.gov>
-- 6 May 2013

-- this device has only one 8-bit register, which is write only.  
-- This slave responds to address 0xCC.
-- input signals should have a value of 0 for low
-- '1' or 'Z' for high

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

use STD.textio.all;
use work.image_pkg.all; -- ben cohen's image utilities

entity ltc3447 is
    port(scl, sda : inout std_logic);
end ltc3447;

architecture ltc3447_arch of ltc3447 is

    constant vrefl: real := 0.69;
    constant vrefh: real := 2.05;

begin

    process
        variable data_reg : std_logic_vector(7 downto 0) := X"00";
        variable addr_reg : std_logic_vector(7 downto 0) := X"00";
        variable i : integer;
        variable dac_int : integer;
        variable vout : real := 1.38;

    begin

        scl <= 'Z';
        sda <= 'Z';

        report "I2CSlave: idle" severity warning;

        wait until ((scl='1' or scl='H') and sda'event and sda='0');  -- start condition

        report "I2CSlave: start" severity warning;

        for i in 7 downto 0 loop
            wait until (scl'event and (scl='1' or scl='H'));
            if (sda='0') then 
                addr_reg(i) := '0';
            else
                addr_reg(i) := '1';
            end if;
         end loop;

        -- ack pulse
        report "I2CSlave: got addr byte 0x"  & HexImage(addr_reg) severity warning;
        wait until (scl'event and scl='0');
        report "I2CSlave: assert ACK" severity warning;
        sda <= '0';
        wait until (scl'event and scl='0');
        report "I2CSlave: release ACK" severity warning;
        sda <= 'Z';

        for i in 7 downto 0 loop
            wait until (scl'event and (scl='1' or scl='H'));
            if (sda='0') then 
                data_reg(i) := '0';
            else
                data_reg(i) := '1';
            end if;
         end loop;

        -- ack pulse
        
        report "I2CSlave: got data byte 0x" & HexImage(data_reg) severity warning;
        dac_int := TO_INTEGER(unsigned(data_reg(5 downto 0)));
        vout := (real(dac_int)/real(64))*(vrefh-vrefl)+vrefl;
        
        wait until (scl'event and scl='0');
        report "I2CSlave: assert ACK" severity warning;
        sda <= '0';
        wait until (scl'event and scl='0');
        report "I2CSlave: release ACK" severity warning;
        sda <= 'Z';

        wait until ((scl='1' or scl='H') and sda'event and (sda='1' or sda='H'));  -- stop condition
        report "I2CSlave: stop detected" severity warning;

    end process;


end ltc3447_arch;










