
-- vipram_rom.vhd
-- 7 May 2013
-- Modified by Siddhartha Joshi sidjos@gmail.com

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity vipram_rom is
    port(
        clock : in  std_logic;
        en    : in  std_logic;
        addr  : in  std_logic_vector(12 downto 0);
        data  : out std_logic_vector(84 downto 0));
end vipram_rom;

architecture vipram_rom_arch of vipram_rom is

signal data_reg : std_logic_vector(84 downto 0);

type rom_type is array(0 to 8191) of std_logic_vector(84 downto 0);
constant ROM : rom_type := (
//ReplaceMe
"0000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
);

begin

process(clock)
begin
  if rising_edge(clock) then
    if (en='1') then
        data_reg <= ROM(conv_integer(addr));    
    end if;
  end if;
end process;

data <= data_reg;

end vipram_rom_arch;

