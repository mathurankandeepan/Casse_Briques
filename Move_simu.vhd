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

entity Move_simu is

end Move_simu;

architecture Behavioral of Move_simu is

signal clk25 : std_logic := '0' ;
signal reset : std_logic := '0' ;
signal QA, QB : std_logic := '0' ;
signal rot_left, rot_right : std_logic ;


begin
    
-- Instanciation du module move
My_move : entity work.move
port map(
    clk25 => clk25 ,
    reset => reset ,
    QA => QA ,
    QB => QB ,
    rot_left => rot_left ,
    rot_right => rot_right );


clk25 <=  not clk25 after 20 ns;
reset <= '1' after 50 ns;
QA <= '1' after 99 ns , '0' after 500 ns , '1' after 800 ns ;
QB <= '1' after 200 ns , '0' after 450 ns , '1' after 850 ns ;

end Behavioral;
