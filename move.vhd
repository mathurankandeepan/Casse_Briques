----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.11.2020 18:36:57
-- Design Name: 
-- Module Name: move - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity move is
    Port ( clk25 	    : in STD_LOGIC;         -- Horloge
           reset 	    : in STD_LOGIC;	    -- Reset Asynchrone
           QA 	     	    : in STD_LOGIC;	    -- Switch A du Codeur
           QB    	    : in STD_LOGIC;	    -- Switch B du Codeur
           rot_left         : out STD_LOGIC;        -- Commande Rotation a Gauche
           rot_right        : out STD_LOGIC);       -- Commande Rotation a Droite
end move;

architecture Behavioral of move is

signal left, right : std_logic := '0';      
signal x, y : std_logic ;                           -- Signaux de sorties de la MAE
type etat is ( S0, S1, S2, S3, S4, S5 );
signal EP, EF : etat;



begin

    -- Affectation des Sorties
    rot_left <= left; 
    rot_right <= right;


            -- Machine à états
    
    -- Process du registre a etats
    process ( clk25, reset )
    begin 
        if reset = '0' 
            then EP <= S0 ;
        elsif rising_edge( clk25 ) 
            then EP <= EF;  
        end if;
    end process; 

    -- Combinatoire des entrées
    process ( EP, QA, QB ) 
    begin
        case ( EP ) is
            when S0 => EF <= S0 ; 
                if QA = '1' and QB = '0' then EF <= S1 ; 
                elsif QA = '1' and QB = '1' then EF <= S2; end if;  
            when S1 => EF <= S3 ;
            when S2 => EF <= S3 ; 
            when S3 => EF <= S3 ;
                if QA = '0' and QB = '0' then EF <= S5; 
                elsif QA = '0' and QB = '1' then EF <= S4; end if ;
            when S4 => EF <= S0 ;
            when S5 => EF <= S0 ;

        end case;        
    end process;
    
    
    -- Combinatoire des sorties
    process ( EP ) 
    begin
        case ( EP ) is 
            when S0 => x <= '0' ; y <= '0' ;
            when S1 => x <= '1' ; y <= '0' ;
            when S2 => x <= '0' ; y <= '1' ;
            when S3 => x <= '0' ; y <= '0' ;
            when S4 => x <= '1' ; y <= '0' ;
            when S5 => x <= '0' ; y <= '1' ;
         end case;
    end process;

    
    left <= '1'  when x = '1' and y = '0' else '0' ;    
    right <= '1'  when x = '0' and y = '1' else '0' ;    


end Behavioral;
