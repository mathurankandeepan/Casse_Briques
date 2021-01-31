----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.11.2020 19:17:40
-- Design Name: 
-- Module Name: Move_simu - Behavioral
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

entity Mode_simu is

end Mode_simu;

architecture Behavioral of Mode_simu is

signal clk25 : std_logic := '0' ;
signal reset : std_logic := '0' ;
signal Pause_rqt, lost, No_brick, endframe : std_logic := '0' ;
signal brick_win, game_lost, pause : std_logic ;

begin
    
-- Instanciation du module move
My_mode : entity work.mode
			port map (
				clk25			=> clk25,				-- Horloge 25 MHz
				reset			=> reset,				-- Reset Asynchrone
                Pause_rqt       => pause_rqt,
                Endframe        => endframe,
                Lost            => lost,
                No_Brick        => no_brick,
                Game_Lost       => game_lost,
                Brick_Win       => brick_win,
                Pause           => pause);


clk25 <=  not clk25 after 20 ns;
reset <= '1' after 100 ns;
--pause_rqt <= '1' after 100 ns, '0' after 10000 ns ;
endframe <= not endframe after 300 ns ;
lost <= '1' after 1000 ns ;



end Behavioral;
