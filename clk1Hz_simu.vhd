----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.12.2020 15:11:19
-- Design Name: 
-- Module Name: clk1Hz_simu - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clk1Hz_simu is
--  Port ( );
end clk1Hz_simu;

architecture Behavioral of clk1Hz_simu is
signal clk25 : std_logic := '0' ;
signal reset : std_logic := '0' ;
signal clk : std_logic := '0' ;
begin

clk1Hz : entity work.clk1Hz
    port map ( 
        clk25 => clk25,
        reset => reset,
        clk_timer => Clk);
        
clk25 <=  not clk25 after 20 ns;
reset <= '1' after 50 ns;

end Behavioral;
