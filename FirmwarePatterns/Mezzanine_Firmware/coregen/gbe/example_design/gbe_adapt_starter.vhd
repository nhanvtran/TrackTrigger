--////////////////////////////////////////////////////////////////////////////////
--//   ____  ____ 
--//  /   /\/   / 
--// /___/  \  /    Vendor: Xilinx 
--// \   \   \/     Version : 2.4
--//  \   \         Application : 7 Series FPGAs Transceivers Wizard 
--//  /   /         Filename :gbe_adapt_starter.vhd
--// /___/   /\     
--// \   \  /  \ 
--//  \___\/\___\ 
--//
--//
--  Description :     This module performs TX reset and initialization.
--                     
--
--
-- Module gbe_adapt_starter
-- Generated by Xilinx 7 Series FPGAs Transceivers Wizard
-- 
-- 
-- (c) Copyright 2010-2012 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES. 


--*****************************************************************************

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;

library unisim;
use unisim.vcomponents.all;

entity gbe_adapt_starter is
generic(
	WAIT_CYC :integer range 0 to 16 := 10
);
port (
RST       	            :  in  STD_LOGIC;  
CLK       	            :  in  STD_LOGIC;  
DO 	                  :  in  STD_LOGIC_VECTOR(15 downto 0);  
DRDY      	            :  in  STD_LOGIC;  
DADDR	                  :  out STD_LOGIC_VECTOR(8 downto 0);  
DEN       	            :  out STD_LOGIC;  
DWE       	            :  out STD_LOGIC;  
READY 	               :  out STD_LOGIC;  
curr_state_debug	      :  out STD_LOGIC_VECTOR(3 downto 0);
counter_debug	         :  out STD_LOGIC_VECTOR(2 downto 0);
rst_int_debug	         :  out STD_LOGIC
);
end gbe_adapt_starter;

architecture Behavioral of gbe_adapt_starter is

constant DLY : time := 1 ns;    
constant DFE_RSTB_ADDR : std_logic_vector(8 downto 0) := "100000001"; --GTX
constant DFE_RSTB_BIT  : integer := 14; --GTX

constant IDLE        : std_logic_vector(3 downto 0) := "0001";
constant NOT_IN_RST  : std_logic_vector(3 downto 0) := "0011";
constant READ1       : std_logic_vector(3 downto 0) := "0010";
constant WAIT1       : std_logic_vector(3 downto 0) := "0110";
constant DONE        : std_logic_vector(3 downto 0) := "0100";

signal curr_state    : std_logic_vector(3 downto 0) := IDLE;
signal next_state    : std_logic_vector(3 downto 0) := IDLE;
signal rst_s         : std_logic_vector(1 downto 0);
signal dfe_rst_b_s   : std_logic;
signal drdy_s        : std_logic;
signal counter       : std_logic_vector(3 downto 0);
signal rst_int_b     : std_logic;

signal rst_int       : std_logic;
signal done_state    : std_logic;
signal enable        : std_logic;
signal enable_b      : std_logic;

signal den_pre       : std_logic;
signal daddr_pre     : std_logic_vector(8 downto 0);
signal ready_pre     : std_logic;
signal rst_b_latch_b : std_logic;

begin

rst_b_latch_b <= (rst_s(1) and enable);
rst_int_debug <= rst_int;
curr_state_debug <= curr_state;
counter_debug <= counter(2 downto 0);

enable <= not(enable_b);
DEN <= den_pre;
DADDR <= daddr_pre;
done_state <= '1' when (curr_state = DONE) else '0';

DWE <= '0';
rst_int <= not(rst_int_b);


process(CLK)
begin
 if rising_edge(CLK) then    
   if(rst_int='1') then
	  ready_pre <= '0' after DLY;
	  READY <= '0'after DLY; 
	else
	  ready_pre <= done_state after DLY;
	  READY <= ready_pre after DLY; 
   end if;
 end if;
end process;


--Logic runs when RST is 0. It runs until hits DONE state and stays there.
--When user resets RXRESET, etc, state machine starts again from beginning.
--Thus there's an issue for first RST. We don't want logic to start until RST goes high then low.
--To circumvent, add another SR latch to detect first RST pulse. This latch's output remains HIGH after first RST pulse.
--Before first RST, the latch output is low and gates the set of the 2nd latch


--SR latch to guarantee width of reset. CLR dominant.
--rst asserted immediately by RST.  Deasserted 2 CLK cycles later if RST width is less than DCLK cycle.  Deasserted when RST goes low when RST width greater than DCLK cycle.

--Logic not enabled until first pulse of RST detected
first_pulse_latch : LDCE 
generic map ( INIT => '1'
)
port map (
	 Q    => enable_b,
	 CLR  => RST,
	 D    => '1',
	 G    => '0',
	 GE   => '1'
 );

rst_b_latch : LDCE 
generic map ( INIT => '0'
)
port map (
	 Q    => rst_int_b,
	 CLR  => RST,
	 D    => '1',
	 G    => rst_b_latch_b, --(rst_s(1) and enable),
	 GE   => '1'
 );

process(CLK)
begin
 if rising_edge(CLK) then    
	rst_s(0) <= not(rst_int_b) after DLY;
	rst_s(1) <= rst_s(0) after DLY;
	
	drdy_s <= DRDY after DLY;
	
	dfe_rst_b_s <= DO(DFE_RSTB_BIT) after DLY;

	curr_state <= next_state after DLY;
   end if;
end process;

process(CLK)
begin
  if rising_edge(CLK) then
     case curr_state is
		when IDLE =>
			counter <= (others =>'0') after DLY;

		when NOT_IN_RST =>
			counter <= counter + 1 after DLY;

		when others =>
			counter <= counter after DLY;
	end case;
 end if;
end process;

--Counter
process(curr_state)
begin
  case curr_state is
	 when IDLE =>
		den_pre <= '0' after DLY;
      daddr_pre <= (others =>'0') after DLY;

	 when READ1 =>
		den_pre <= '1' after DLY;
      daddr_pre <= DFE_RSTB_ADDR;
		
	 when WAIT1 =>
		den_pre <= '0' after DLY;
      daddr_pre <= DFE_RSTB_ADDR;
		
	 when	NOT_IN_RST =>
		den_pre <= '0' after DLY;
      daddr_pre <= DFE_RSTB_ADDR;
		
	 when	DONE =>
		den_pre <= '0' after DLY;
      daddr_pre <= (others => '0');
		
	 when others =>
		den_pre <= '0' after DLY;
      daddr_pre <= (others => '0');
		
	end case;	

end process;

--State Machine
process(curr_state,drdy_s,counter,rst_int,dfe_rst_b_s)
begin
   if(rst_int = '1') then
		next_state <= IDLE after DLY;
	else
     case curr_state is
		 when IDLE =>
           next_state <= READ1 after DLY;
			
		 when READ1 =>
				next_state <= WAIT1 after DLY;
			
		 when	WAIT1 =>
           if(drdy_s = '1') then
               if(dfe_rst_b_s = '1') then --Out of DFE reset
						next_state <= NOT_IN_RST after DLY;
					else
						next_state <= IDLE after DLY; --Reset counter if see 0 in midst of 1's.  Keep reading until see in reset state
               end if;
				else
					next_state <= WAIT1 after DLY;
            end if;
			
		 when NOT_IN_RST =>          --Wait for WAIT_CYC+1 reads non-reset since counter delayed by 1 cyc
           if(counter = WAIT_CYC) then
					next_state <= DONE after DLY;
			  else
					next_state <= READ1 after DLY;
           end if;

		 when DONE =>
				next_state <= DONE after DLY;
			
		 when	others =>
				next_state <= IDLE after DLY;
			
		end case;
  end if;
end process;

end Behavioral;

--For sim: LDCE as SR latch
----module LDCE #(
----  parameter INIT = 1'b0
----)
----(
----  output reg Q,
----  input CLR,
----  input D,
----  input G,
----  input GE
----);
----
----  initial
----  begin
----    Q <= `DLY INIT;
----  end
----
----  always @ (CLR or G)
----  begin
----    if(CLR)
----      Q <= `DLY 1'b0;
----    else if(G)
----      Q <= `DLY 1'b1;
----  end
----
----endmodule 

