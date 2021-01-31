----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.12.2020 21:49:18
-- Design Name: 
-- Module Name: Tempo_Pause - Behavioral
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

entity Tempo_Pause is
    Port ( clk25,reset : in std_logic;
           RAZ_Tempo_Pause : in STD_LOGIC;
           Update_Tempo_Pause : in STD_LOGIC;
           Fin_Tempo_Pause : out STD_LOGIC);
end Tempo_Pause;


architecture Behavioral of Tempo_Pause is

signal Tempo_Pause : std_logic_vector (9 downto 0);

begin

    process ( clk25, reset, Raz_Tempo_Pause, Update_Tempo_Pause)
    begin
    
        if reset = '0' or Raz_Tempo_Pause = '1' 
            then Tempo_Pause <= (others => '0');
        elsif rising_edge(clk25) then
            if Update_Tempo_Pause = '1' 
                    then Tempo_Pause <= Tempo_Pause + 1 ;
            end if;
        end if;
    
    end process ; 
    
    Fin_Tempo_Pause <= '1' when Tempo_Pause = "1111111111" else '0';

end Behavioral;
