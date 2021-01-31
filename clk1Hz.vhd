----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.12.2020 14:07:45
-- Design Name: 
-- Module Name: clk1Hz - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clk1Hz is
    Port ( clk25,reset : in  STD_LOGIC;	-- Horloge 100 Mhz et Reset Asynchrone
			  clk_timer: out STD_LOGIC);			-- Horloge 1 Hz (pour Traiter le Timer)
end clk1Hz;

architecture Behavioral of clk1Hz is

-- Compteur pour Horloge 1 Hz
signal CPT_1: std_logic_vector(23 downto 0);

-- Signal Tampon pour l'horloge 1 Hz
signal Clk2: std_logic;

begin
-- Affectation Horloge 1 Hz
clk_timer <= Clk2;


--------------------------------------------
-- GESTION DES COMPTEURS DE DIVISION
--		ET GENERATION DE L'HORLOGE 1 Hz
process(clk25,reset)

	begin
	
		if reset = '0' then 
		
			Clk2 <= '0'; CPT_1 <= (others => '0');

		elsif rising_edge(clk25) then
			
			CPT_1 <= CPT_1+1;
			
			if (CPT_1 = 12499999) then
				CPT_1 <= (others => '0');
				Clk2 <= not Clk2;
			end if;
			
		end if;

end process;

end Behavioral;
