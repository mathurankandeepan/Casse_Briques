----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.12.2020 18:06:28
-- Design Name: 
-- Module Name: transcod - Behavioral
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

entity transcod is
  Port ( e : in std_logic_VECTOR(3 DOWNTO 0); 
         s : out std_logic_VECTOR(7 DOWNTO 0) );
end transcod;

architecture Behavioral of transcod is

begin
    process(e)
    begin
        case e is    
            WHEN "0000" => s <= "00111111" ;
            WHEN "0001" => s <= "00000110" ;
            WHEN "0010" => s <= "01011011" ;
            WHEN "0011" => s <= "01001111" ;
            WHEN "0100" => s <= "01100110" ;
            WHEN "0101" => s <= "01101101" ;
            WHEN "0110" => s <= "01111101" ;
            WHEN "0111" => s <= "00000111" ;
            WHEN "1000" => s <= "01111111" ;
            WHEN "1001" => s <= "01101111" ;
            WHEN OTHERS => s <= "00000001" ;
        end case;
     end process;
end Behavioral;
