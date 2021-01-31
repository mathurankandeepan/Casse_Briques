----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.12.2020 17:11:04
-- Design Name: 
-- Module Name: clk20Hz - Behavioral
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

entity clk20Hz is
    Port (    clk100,reset : in  STD_LOGIC;	    -- Horloge 100 Mhz et Reset Asynchrone
			  clk20: out STD_LOGIC;
			  cpt20: out STD_LOgic);			-- Horloge 25 Hz (pour Traiter les Commandes de l'Accéléromètre)
end clk20Hz;

architecture Behavioral of clk20Hz is

-- Compteur pour Horloge 20 Hz
signal CPT_20: std_logic_vector(21 downto 0);

-- Signal Tampon pour l'horloge 20 Hz
signal Clk2: std_logic;

begin

    -- Affectation Horloge 25 Hz
    Clk20 <= Clk2;
    
    --------------------------------------------
    -- GESTION DES COMPTEURS DE DIVISION
    --		ET GENERATION DE L'HORLOGE 25 Hz
    process(clk100,reset)
    
        begin
        
            if reset = '0' then 
            
                Clk2 <= '0'; CPT_20 <= (others => '0');
    
            elsif rising_edge(clk100) then
                
                CPT_20 <= CPT_20+1;
                -- 2499999 pour passer à 20 Hz
                if (CPT_20 = 2499999) then
                    CPT_20 <= (others => '0');
                    Clk2 <= not Clk2;
                end if;
                
            end if;
    
    end process;

cpt20 <= '1' when CPT_20 = 0  else '0';

end Behavioral;
