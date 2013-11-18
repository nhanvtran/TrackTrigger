-------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 2.4
--  \   \         Application : 7 Series FPGAs Transceivers Wizard
--  /   /         Filename : gbe_gt_frame_gen.vhd
-- /___/   /\      
-- \   \  /  \ 
--  \___\/\___\ 
--
--
-- Module gbe_GT_FRAME_GEN
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


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

--***********************************Entity Declaration************************

entity gbe_GT_FRAME_GEN is
generic
(
    WORDS_IN_BRAM : integer    :=   512
);    
port
(
    -- User Interface
    TX_DATA_OUT             : out   std_logic_vector(79 downto 0);
    TXCTRL_OUT              : out   std_logic_vector(7 downto 0); 
    -- System Interface
    USER_CLK            : in    std_logic;      
    SYSTEM_RESET        : in    std_logic
); 


end gbe_GT_FRAME_GEN;

architecture RTL of gbe_GT_FRAME_GEN is

--***********************************Parameter Declarations********************

    constant DLY : time := 1 ns;

--********************************* Wire Declarations************************** 

    signal  tx_ctrl_i               :   std_logic_vector(7 downto 0);
    signal  tx_data_bram_i          :   std_logic_vector(63 downto 0);
    signal  tx_data_ram_r           :   std_logic_vector(79 downto 0);
    signal  tied_to_ground_vec_i    :   std_logic_vector(31 downto 0);
    signal  tied_to_ground_i        :   std_logic;
    signal  tied_to_vcc_i           :   std_logic;
    signal  tied_to_vcc_vec_i       :   std_logic_vector(15 downto 0);

--***************************Internal signalister Declarations******************** 

    signal  read_counter_i          :   unsigned(8 downto 0);    
    signal  read_counter_conv       :   std_logic_vector(8 downto 0);    
    signal  system_reset_r          :   std_logic;
    attribute keep: string;
    attribute keep of system_reset_r : signal is "true";

--*********************************User Defined Attribute*****************************

    type RomType is array(0 to 511) of std_logic_vector(79 downto 0);

    impure function InitRomFromFile (RomFileName : in string) return RomType is

         FILE RomFile : text open read_mode is RomFileName;
         variable RomFileLine : line;
         variable ROM : RomType;
    begin
         for i in RomType'range loop
           readline (RomFile, RomFileLine);
           hread (RomFileLine, ROM(i));
         end loop;
         return ROM;
    end function;

    signal ROM : RomType := InitRomFromFile("gt_rom_init_tx.dat");

--*********************************Main Body of Code***************************
begin

    tied_to_ground_vec_i    <=   (others=>'0');
    tied_to_ground_i        <=   '0';
    tied_to_vcc_i           <=   '1';

    --___________ synchronizing the async reset for ease of timing simulation ________
    process( USER_CLK )
    begin
        if(USER_CLK'event and USER_CLK = '1') then
            system_reset_r <= SYSTEM_RESET after DLY; 
        else
            system_reset_r <= system_reset_r after DLY; 
        end if;
    end process;

    --__________________________ Counter to read from BRAM ____________________    
    
    process( USER_CLK )
    begin
        if(USER_CLK'event and USER_CLK = '1') then
            if((system_reset_r='1') or (read_counter_i = (WORDS_IN_BRAM-1)))then
                read_counter_i <= (others => '0') after DLY;
            else
                read_counter_i <= read_counter_i + 1 after DLY;
            end if;
        end if;
    end process;

    -- Assign TX_DATA_OUT to BRAM output

    process( USER_CLK )
    begin
        if(USER_CLK'event and USER_CLK = '1') then
            if(system_reset_r='1') then
                TX_DATA_OUT      <= (others => '0') after DLY;
            else
                TX_DATA_OUT      <= (tx_data_bram_i & tx_data_ram_r(15 downto 0))  after DLY; 
            end if;
        end if;
    end process;

    -- Assign TXCTRL_OUT to BRAM output
    process( USER_CLK )
    begin
        if(USER_CLK'event and USER_CLK = '1') then
            if(system_reset_r='1') then
                TXCTRL_OUT    <= (others => '0') after DLY;
            else
                TXCTRL_OUT    <= tx_ctrl_i after DLY; 
            end if;
        end if;
    end process;


    --______________________________ BRAM Inference Logic_______________________    

    tx_data_bram_i      <= tx_data_ram_r(79 downto 16);
    tx_ctrl_i           <= tx_data_ram_r(15 downto 8);

    read_counter_conv   <= std_logic_vector(read_counter_i);
    
    process (USER_CLK)
    begin
       if(USER_CLK'event and USER_CLK='1') then
          tx_data_ram_r <= ROM(conv_integer(read_counter_conv)) after DLY;
       end if;
    end process;


end RTL;


