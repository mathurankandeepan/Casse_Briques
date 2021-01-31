----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.12.2020 14:33:49
-- Design Name: 
-- Module Name: Timer_Game - Behavioral
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
use IEEE.STD_LOGIC_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Timer_Game is
    Port ( clk25,reset : in STD_LOGIC;
           Load_Timer_Game : in STD_LOGIC;
           Update_Timer_Game : in STD_LOGIC;
           Timer_Game : out STD_LOGIC_VECTOR (7 downto 0));
end Timer_Game;

architecture Behavioral of Timer_Game is

signal Timer_Game_local : STD_LOGIC_VECTOR(7 downto 0);
signal Clk: std_logic;

begin

clk1Hz : entity work.clk1Hz
    port map ( 
        clk25 => clk25,
        reset => reset,
        clk_timer => Clk);
        
process (clk, reset, Load_Timer_Game, Update_Timer_Game)
    
    begin
        
         if reset = '0' or Load_Timer_Game = '1' 
            then Timer_Game_local <= "01111000"; --120 sec
            --then Timer_Game_local <= "00001000"; -- 8 sec pour tester
        elsif rising_edge(clk)  then
            if Update_Timer_Game = '1' then 
                Timer_Game_local <= Timer_Game_local - 1;
            end if;
        end if;
        
        
    end process;

    Timer_Game<= Timer_Game_local ;


end Behavioral;
