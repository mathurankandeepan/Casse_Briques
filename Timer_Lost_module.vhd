----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.12.2020 18:17:14
-- Design Name: 
-- Module Name: Timer_Lost - Behavioral
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

entity Timer_Lost_module is
    Port ( clk25,reset : in STD_LOGIC;
           Load_Timer_Lost : in STD_LOGIC;
           Update_Timer_Lost : in STD_LOGIC;
           Timer_Lost : out STD_LOGIC_VECTOR (5 downto 0);
           Game_Lost : out STD_LOGIC);
end Timer_Lost_module;

architecture Behavioral of Timer_Lost_module is

signal Timer_Lost_local : STD_LOGIC_VECTOR(5 downto 0);

begin

    process( clk25 , reset , Load_Timer_Lost, Update_Timer_Lost)
    
    begin
        
        if reset = '0' 
            then Timer_Lost_local <= (others=>'0') ;
        elsif  rising_edge(clk25) then
            if  Load_Timer_Lost = '1'
                then Timer_Lost_local <= (others=>'1') ;
            elsif Update_Timer_Lost = '1'
                then Timer_Lost_local <= Timer_Lost_local - 1; 
            end if;
        end if ;
    
    end process;

    Game_Lost <= '0' when Timer_Lost_local = "000000" else '1' ;
    Timer_Lost <= Timer_Lost_local ;

end Behavioral;
