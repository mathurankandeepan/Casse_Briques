----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.12.2020 14:44:38
-- Design Name: 
-- Module Name: Moving_colors_simu - Behavioral
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

entity Moving_colors_simu is
--  Port ( );
end Moving_colors_simu;

architecture Behavioral of Moving_colors_simu is
signal clk100 : std_logic := '0' ;
signal reset : std_logic := '0' ;
signal red, blue, green,red_pad, blue_pad, green_pad : std_logic_vector(3 downto 0);
begin

Moving_colors : entity work.Moving_Colors
    port map (
        clk100 => clk100,
        reset => reset, 
        RED_Out => red,
        GREEN_Out => green, 
        BLUE_Out => blue); 
        
Moving_Colors_Pad : entity work. Moving_Colors_pad
    port map (
        clk100 => clk100,
        reset => reset, 
        RED_Out => red_pad,
        GREEN_Out => green_pad, 
        BLUE_Out => blue_pad); 
        
clk100 <=  not clk100 after 20 ns;
reset <= '1' after 50 ns;
end Behavioral;
