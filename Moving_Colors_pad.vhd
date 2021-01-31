----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.12.2020 11:13:47
-- Design Name: 
-- Module Name: Moving_Colors_pad - Behavioral
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

entity Moving_Colors_pad is
    Port ( 
        Clk100, reset : in std_logic ;                      -- Horloge et Reset asynchrone
        RED_Out       : out STD_LOGIC_VECTOR (3 downto 0);  -- Composante Rouge de la Couleur VGA Affich�e
        GREEN_Out     : out STD_LOGIC_VECTOR (3 downto 0);  -- Composante Verte de la Couleur VGA Affich�e
        BLUE_OUT      : out STD_LOGIC_VECTOR (3 downto 0) );-- Composante Bleue de la Couleur VGA Affich�e
end Moving_Colors_pad;

architecture Behavioral of Moving_Colors_pad is

signal Clk20 : std_logic;
signal cpt20 : std_logic;
signal RED,GREEN,BLUE : std_logic_vector(4 downto 0);  
signal OK : std_logic := '0';                                --signal qui permet de savoir si on change d'�tat
signal x,y : std_logic;                                      --signaux de sortie de la MAE
type etat is (S0,S1,S2);                                     --�tats de la MAE
signal EP, EF : etat;                                        --�tat pr�sent et �tat futur

begin

    -- Affectation des sorties
    Red_Out   <= RED   (4 downto 1); 
    GREEN_Out <= GREEN (4 downto 1); 
    BLUE_Out  <= BLUE  (4 downto 1); 
    
    -- Diviseur d'horloge pour obrtenir 20Hz + changement d'�tat quand OK = 1
    clk20Hz : entity work.clk20Hz
        port map ( 
            clk100 => clk100,
            reset => reset,
            clk20 => clk20,
            cpt20 => cpt20);
           
    process( Clk100, reset )

    begin
        if rising_edge(Clk100) then   -- Pour passer � clk20, changer le 5 en 10000000   
            -- changement d'�tat quand n�cessaire 
            if ( ( (Red = 31 and Blue = 0)or (Blue = 31 and Red = 31) or (Red = 0 and Blue = 0) )  and  cpt20 = '1' and clk20 = '1' ) 
                    then OK <= '1' ;
                    else OK <= '0'; 
            end if;
        end if;
    end process;


    ----Machine � etat    
     
    --Process du Registre d'etats
    process(Clk100,reset)
    begin
        if reset = '0' then EP <= S0;
        elsif rising_edge(Clk100) then EP <= EF;
        end if;
    end process;
    

     --Combinatoire des etats
    process(Ep,OK)
    
    begin
        case (EP) is
            when S0 => EF <=S0 ; if OK = '1' then EF <= S1; end if;
            when S1 => EF <=S1 ; if OK = '1' then EF <= S2; end if;
            when S2 => EF <=S2 ; if OK = '1' then EF <= S0; end if;            
        end case;
        
    end process;
    
      --Combinatoire des sorties
    process(EP)
    begin 
        case (EP) is
            when S0 => x <= '0' ; y <= '0';
            when S1 => x <= '1' ; y <= '0';
            when S2 => x <= '0' ; y <= '1';
        end case;
    end process;
    
    
    
    

    
    --Compteurs 
    process(clk20,reset,OK)
    
    begin
        if reset = '0' then
           Red   <= "11111";
           Green <= "11111";
           Blue  <= "00000";
        elsif rising_edge(clk20) then
            if x = '0' and y = '0'    then Blue <= Blue + 1; 
            elsif x = '1' and y = '0' then Blue <= Blue - 1 ; Red <= Red - 1;  
            elsif x = '0' and y = '1' then Red <= Red + 1; 
            end if;
        end if;
    end process;

end Behavioral;
