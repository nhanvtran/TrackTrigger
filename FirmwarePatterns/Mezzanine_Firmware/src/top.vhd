-- top.vhd
-- VIPRAM Test Mezzanine TOP LEVEL
-- Jamieson Olsen <jamieson@fnal.gov>
-- 9 May 2013

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

entity top is
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
        TP8        : out std_logic; -- testpoint

        vpwr_en : out std_logic;  -- power control I2C devices
        sda     : inout std_logic_vector(2 downto 0);
        scl     : inout std_logic_vector(2 downto 0);       
        led     : out std_logic_vector(3 downto 0));
end top;

architecture top_arch of top is

    component mezzclock is
    port(
        clk_in1_p : in     std_logic;
        clk_in1_n : in     std_logic;
        clk_out1  : out    std_logic;
        clk_out2  : out    std_logic;
        clk_out3  : out    std_logic;
        clk_out4  : out    std_logic;
        locked    : out    std_logic);
    end component;

    component vipram_rom is
    port(
        clock : in  std_logic;
        en    : in  std_logic;
        addr  : in  std_logic_vector(12 downto 0);
        data  : out std_logic_vector(84 downto 0));
    end component;

    component power is
    port(
        clock   : in std_logic;  -- 10MHz
        scl     : inout std_logic_vector(2 downto 0);
        sda     : inout std_logic_vector(2 downto 0));
    end component;

    signal divide_reg : std_logic_vector(23 downto 0) := (others=>'0');
    signal slow_clk, locked : std_logic;
    signal clock, clock_b : std_logic;
    signal addr_reg : std_logic_vector(12 downto 0) := (others=>'0');
    signal data_reg : std_logic_vector(31 downto 0);
    signal rom_dout, rom_dout_reg, rom_dout2_reg : std_logic_vector(84 downto 0);
    signal control_0 : std_logic_vector (35 downto 0);
    signal trig_0	 : std_logic_vector(118 downto 0);
    signal ila_clk : std_logic; -- 100MHz

    constant C_NUM_OF_TRIGPORTS : integer   := 1;
    constant C_TRIG0_SIZE       : integer	:= 116;

    attribute S: string;
    attribute S of data_reg : signal is "YES";

  component chipscope_icon
    port (
      CONTROL0	: inout std_logic_vector(35 downto 0)
      );
  end component;

  component chipscope_ila
    port (
      CONTROL : inout std_logic_vector(35 downto 0);
      CLK	  : in    std_logic;
      TRIG0	  : in    std_logic_vector(118 downto 0)
      );
  end component;

begin

    MezzClock_Inst: MezzClock
    port map(
      CLK_IN1_P => clock_p,     -- 200MHz extern osc.
      CLK_IN1_N => clock_n,
      CLK_OUT1  => clock,       -- used for VIPRAM clocking MC_A 
      CLK_OUT2  => clock_b,     -- phase shifted copy used for MC_B
      CLK_OUT3  => slow_clk,    -- 10MHz for power control, misc slow stuff
      CLK_OUT4  => ila_clk,     -- 200MHz for running chipscope
      LOCKED    => locked);

    addr_proc: process(clock)
    begin
        if rising_edge(clock) then
            addr_reg <= addr_reg + 1;
        end if;
    end process addr_proc;

--   Input Vector is [84..0] defined as:
--
--    -> D_D = input_pattern[15:0];
--    -> D_C = input_pattern[31:16];
--    -> D_B = input_pattern[47:32];
--    -> D_A = input_pattern[63:48];
--    -> colADR = input_pattern[68:64]; 
--    -> rowADR = input_pattern[75:69]; 
--    -> eventRearm = input_pattern[76]; 
--    -> latchData = input_pattern[77] ; 
--    -> Primary = input_pattern[78] ;
--    -> runMode = input_pattern[79] ; 
--    -> miss0 = input_pattern[80] ;
--    -> miss1 = input_pattern[81] ;
--    -> miss2 = input_pattern[82] ;
--    -> requireLayerA = input_pattern[83];
--    -> ReadMode = input_pattern[84];   -- testpoint

    rom_inst: vipram_rom
        port map(
            clock => clock,
            en    => '1',
            addr  => addr_reg,
            data  => rom_dout);

    -- clock forwarding outputs

    MC_A_inst : ODDR
    port map(
    	Q  => MC_A,
    	C  => clock,
        CE => '1',
    	D1 => '1', 
    	D2 => '0',
        R  => '0', 
        S  => '0');

    MC_B_inst : ODDR
    port map(
    	Q  => MC_B,
    	C  => clock_b,
        CE => '1',
    	D1 => '1', 
    	D2 => '0',
        R  => '0',
        S  => '0');

    -- register outputs to VIPRAM

    romout_proc: process(clock)
    begin
        if rising_edge(clock) then
            rom_dout_reg <= rom_dout;
            rom_dout2_reg <= rom_dout_reg;
        end if;
    end process romout_proc;

    -- assign outputs going to VPRAM

    D          <= rom_dout2_reg(15 downto  0);
    C          <= rom_dout2_reg(31 downto 16);
    B          <= rom_dout2_reg(47 downto 32);
    A          <= rom_dout2_reg(63 downto 48);
    ColAddr    <= rom_dout2_reg(68 downto 64);
    RowAddr    <= rom_dout2_reg(75 downto 69);
    EventReArm <= rom_dout2_reg(76);
    LatchData  <= rom_dout2_reg(77);
    Primary    <= rom_dout2_reg(78);
    RunMode    <= rom_dout2_reg(79);
    Miss(0)    <= rom_dout2_reg(80);
    Miss(1)    <= rom_dout2_reg(81);
    Miss(2)    <= rom_dout2_reg(82);
    ReqLayerA  <= rom_dout2_reg(83);
    TP8        <= rom_dout2_reg(84);  -- ReadMode brought out to testpoint TP8

    -- sample VIPRAM output bus @ 200MHz

    data_proc: process(ila_clk)
    begin
        if rising_edge(ila_clk) then
            data_reg <= data;
        end if;
    end process data_proc;

    -- Power control 
   
    power_inst: power
    port map(
        clock   => slow_clk,
        scl     => scl,
        sda     => sda);

    vpwr_en <= '1';  -- regulators must be enabled before setting output voltage

    -- blinky stuff
    --
    -- front panel LEDs are active HIGH
    --  ---------------------------------------
    -- | 3 1                                   |
    -- | 2 0                                   |
    --  ---------------------------------------

    blinker_proc: process(slow_clk)
    begin
        if rising_edge(slow_clk) then
            divide_reg <= divide_reg + 1;
        end if;
    end process blinker_proc;

    led(3) <= '1' when (divide_reg(23 downto 22)="00") else '0';  -- heartbeat
    led(1) <= '1' when (divide_reg(23 downto 22)="01") else '0';  -- heartbeat
    led(0) <= '1' when (divide_reg(23 downto 22)="10") else '0';  -- heartbeat
    led(2) <= '1' when (divide_reg(23 downto 22)="11") else '0';  -- heartbeat

    -- chipscope 

    trig_0(84 downto 0)   <= rom_dout_reg(84 downto 0);  -- input vector
    trig_0(116 downto 85) <= data_reg(31 downto 0);      -- sampled VIPRAM outputs
    trig_0(117)           <= clock;                      -- MC_A clock to the VIPRAM
    trig_0(118)           <= clock_b;                    -- MC_B clock to the VIPRAM

    ICON_inst : chipscope_icon  
    port map(CONTROL0 => control_0);

    ILA_inst : chipscope_ila
    port map(
      CONTROL => control_0,
      CLK	  => ila_clk,  -- oversampling @ 200MHz
      TRIG0	  => trig_0);

end top_arch;

