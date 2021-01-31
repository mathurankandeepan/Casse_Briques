----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.12.2020 21:20:15
-- Design Name: 
-- Module Name: Timer_Lost_simu - Behavioral
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

entity Timer_Lost_simu is
--  Port ( );
end Timer_Lost_simu;

architecture Behavioral of Timer_Lost_simu is

signal clk25 : std_logic := '0' ;
signal reset : std_logic := '0' ;
signal Load_Timer_Lost : std_logic := '0' ;
signal Update_Timer_Lost : std_logic := '0' ;
signal  Fin_Timer_Lost, game_lost : std_logic ;

begin
    
-- Instanciation du module move
    Lost_Game: entity work.Timer_Lost_module
			port map (
				clk25			    => clk25,				-- Horloge 25 MHz
				reset			    => reset,				-- Reset Asynchrone
                Load_Timer_Lost     => Load_Timer_Lost,     -- Chargement parallele à la valeur 63
                Update_Timer_Lost   => Update_Timer_Lost,   -- Decrementation du timer
              
                Fin_Timer_Lost          => Fin_Timer_Lost,          -- Timer
                Game_Lost           => Game_Lost            -- Sortie game_Lost
			);

clk25 <=  not clk25 after 20 ns;
reset <= '1' after 50 ns;
Update_Timer_Lost <= not Update_Timer_Lost after 300 ns ;


end Behavioral;
