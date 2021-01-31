----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.11.2020 15:09:35
-- Design Name: 
-- Module Name: mode - Behavioral
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mode is
  Port ( clk25,reset    : in std_logic;     -- Horloge et Reset Asynchrone
         Pause_Rqt      : in std_logic;     -- Demande de Pause = Appui Bouton Encodeur
         Endframe       : in std_logic;     -- Fin de l'Image Visible
         Lost           : in std_logic ;    -- La Balle Va Sortir de l'Ecran
         No_Brick       : in std_logic;     -- Actif si Toutes les Briques Ont Ete Cassees
         Game_Lost      : out std_logic;    -- Partie Perdue
         Brick_Win      : out std_logic;    -- Partie Gagné
         Pause          : out std_logic;    -- Partie en Pause
         Timer_Game_Affichage : out std_logic_vector (7 downto 0));
end mode;

architecture Behavioral of mode is



signal RAZ_Tempo_Pause : std_logic ;
signal Update_Tempo_Pause : std_logic ;
signal Fin_Tempo_Pause : std_logic ;
signal Load_Timer_Lost : std_logic ;
signal Update_Timer_Lost : std_logic ;
signal Timer_Lost : std_logic_vector (5 downto 0) ;
signal Load_Timer_Game : std_logic ;
signal Update_Timer_Game: std_logic ;
signal Timer_Game: std_logic_vector (7 downto 0) ;
type etat is ( Etat_Actif, Etat_Win, Etat_Pause, Etat_Pause_tmp1, Etat_Pause_tmp2, Etat_Lost_step1, Etat_Lost_step2);
signal EP, EF : etat;

begin

    Timer_Game_Affichage <= Timer_Game;
    -- Machine à états
    
    -- Process du registre a etats
    process ( clk25, reset )
    begin 
        if reset = '0' 
            then EP <= Etat_Pause ; 
        elsif rising_edge( clk25 ) 
            then EP <= EF;  
        end if;
    end process; 
    
    -- Combinatoire des entrées
    process ( EP, No_Brick, Pause_rqt, Lost ) 
    begin
        case ( EP ) is
            when Etat_Win => EF <= Etat_Win ;
            when Etat_Actif => EF <= Etat_Actif; 
                if No_Brick = '1' then EF <= Etat_Win ; 
                elsif pause_rqt = '1' then EF <= Etat_Pause_tmp1 ;
                elsif lost = '1' or Timer_Game = "00000000" then EF <= Etat_Lost_step1; 
                end if;
            when Etat_Pause_tmp1 => EF <= Etat_Pause_tmp1 ;
                if Fin_Tempo_Pause = '1' and pause_rqt = '0' then EF <= Etat_Pause ;  end if;
            when Etat_Pause => EF <= Etat_Pause ; 
                if pause_rqt = '1' then EF <= Etat_Pause_tmp2 ; end if;
            when Etat_Pause_tmp2 => EF <= Etat_Pause_tmp2 ; 
                if Fin_Tempo_Pause = '1' and pause_rqt = '0' then EF <= Etat_Actif ; end if;
            when Etat_Lost_step1 => EF <= Etat_Lost_step2;
            when Etat_Lost_step2 => EF <= Etat_Lost_step2;
                if Timer_Lost = "000000" then EF <= Etat_Pause ; end if ;
        end case;
                
    end process;


    
    -- Combinatoire des sorties
    process ( EP ) 
    begin
        case ( EP ) is 
            when Etat_Win => 
                Brick_Win <= '1' ; 
                Pause <= '0' ;  
                RAZ_Tempo_Pause <= '1' ;
                Update_Tempo_Pause <= '0' ;
                Update_Timer_Lost <= '0' ;
                Load_Timer_Lost <= '0';
                Update_Timer_Game <= '0' ;
                Load_Timer_Game <= '0';
                
            when Etat_Actif => 
                Brick_Win <= '0' ; 
                Pause <= '0' ; 
                RAZ_Tempo_Pause <= '1' ;
                Update_Tempo_Pause <= '0' ;
                Update_Timer_Lost <= '0' ;
                Load_Timer_Lost <= '0';
                Update_Timer_Game <= '1' ;
                Load_Timer_Game <= '0';
                
            when Etat_Pause =>  
                Brick_Win <= '0' ; 
                Pause <= '1' ; 
                RAZ_Tempo_Pause <= '1' ;
                Update_Tempo_Pause <= '0' ;
                Update_Timer_Lost <= '0' ;
                Load_Timer_Lost <= '0';
                Update_Timer_Game <= '0' ;
                Load_Timer_Game <= '0';
                
            when Etat_Pause_tmp1 => 
                Brick_Win <= '0' ; 
                Pause <= '1' ; 
                RAZ_Tempo_Pause <= '0' ;
                Update_Tempo_Pause <= '1' ;
                Update_Timer_Lost <= '0' ;
                Load_Timer_Lost <= '0';
                Update_Timer_Game <= '0' ;
                Load_Timer_Game <= '0';
                
            when Etat_Pause_tmp2 => 
                Brick_Win <= '0' ; 
                Pause <= '1' ; 
                RAZ_Tempo_Pause <= '0' ;
                Update_Tempo_Pause <= '1' ;
                Update_Timer_Lost <= '0' ;
                Load_Timer_Lost <= '0';
                Update_Timer_Game <= '0' ;
                Load_Timer_Game <= '0';            

            when Etat_Lost_step1=> 
                Brick_Win <= '0' ; 
                Pause <= '1' ; 
                RAZ_Tempo_Pause <= '0' ;
                Update_Tempo_Pause <= '0' ;
                Update_Timer_Lost <= '0' ;
                Load_Timer_Lost <= '1';
                Update_Timer_Game <= '0' ;
                Load_Timer_Game <= '0';
                   
            when Etat_Lost_step2=> 
                Brick_Win <= '0' ; 
                Pause <= '1' ; 
                RAZ_Tempo_Pause <= '0' ;
                Update_Tempo_Pause <= '0' ;
                Update_Timer_Lost <= endframe ;
                Load_Timer_Lost <= '0';
                Update_Timer_Game <= '0' ;
                Load_Timer_Game <= '1';
                
                       
         end case;
    end process;


    --Tempo pause
	Tempo_Pause: entity work.Tempo_Pause
			port map (
				clk25			    => clk25,				-- Horloge 25 MHz
				reset			    => reset,				-- Reset Asynchrone
                RAZ_Tempo_Pause     => RAZ_Tempo_Pause,     
                Update_Tempo_Pause  => Update_Tempo_Pause,  
                Fin_Tempo_Pause     => Fin_Tempo_Pause       
			);
    
   -- Timer Lost
	Lost_Game: entity work.Timer_Lost_module
			port map (
				clk25			    => clk25,				-- Horloge 25 MHz
				reset			    => reset,				-- Reset Asynchrone
                Load_Timer_Lost     => Load_Timer_Lost,     -- Chargement parallele à la valeur 63
                Update_Timer_Lost   => Update_Timer_Lost,   -- Decrementation du timer
                Timer_Lost          => Timer_Lost,          -- Timer
                Game_Lost           => Game_Lost            -- Sortie game_Lost
			);

    -- Timer Game
    Timer_Game_module : entity work.Timer_Game
        port map ( 
            clk25 => clk25,
            reset => reset,  
            Load_Timer_Game => Load_Timer_Game,
            Update_Timer_Game => Update_Timer_Game,
            Timer_Game => Timer_Game
            );

end Behavioral;
