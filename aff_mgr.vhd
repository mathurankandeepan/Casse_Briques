----------------------------------------------------------------------------------
-- Company: 	UPMC
-- Engineer: 	Julien Denoulet
-- 
--	Gestion des Afficheurs 7 Segments
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL; 


entity aff_mgr is
    Port ( clk25 			: in  STD_LOGIC;						-- Horloge 25 MHz
           reset 			: in  STD_LOGIC;						-- Reset Asynchrone
           pause 			: in  STD_LOGIC;						-- Commande Pause
           game_lost        : in std_logic;                         -- Drapeau Partie Perdue
           game_win         : in std_logic;                         -- Drapeau Partie Gagnée
           master_slave	    : in STD_LOGIC;							-- Selection Manette de Jeu (Encodeur / Accéléromètre)
		   game_type 	    : in  STD_LOGIC;						-- Type de Jeu (Pong / Casse-Briques=
           Timer_Game_Affichage : in std_logic_vector (7 downto 0); -- Timer qui compte le temps de jeu restant pour gagner la partie
           score : in std_logic_vector(4 downto 0);                 -- Score comptant le nombre de briques cassées
           sel_seg 		    : out STD_LOGIC_VECTOR (7 downto 0); 	-- Selection de l'Afficheur
           seg 			    : out STD_LOGIC_VECTOR (7 downto 0));	-- Valeur des Segments de l'Afficheur
end aff_mgr;

--------------------------------------------------
-- Fonctionnement Afficheurs
--------------------------------------------------
--
--		- Segments Allumés à 0, Eteints à 1
--		- Validation
--				- SEL = 0 --> Affichage des Segments
--				- SEL = 1 --> Segments Eteints

--		- Numéro des Segments Afficheur (Point = 7)
--
--					  0
--				 --------
--				-			-
--			 5	-			- 1
--				-	  6	-
--				 --------
--				-			-
--			 4	-			- 2
--				-			-
--				 --------
--				     3
--
--------------------------------------------------


architecture Behavioral of aff_mgr is

signal counter: integer range 0 to 100000; -- COmpteur de Temporisation
signal Time0, Time1, Time2, Time3 : std_logic_vector (3 downto 0);
signal score0, score1, score2, score3 : std_logic_vector (3 downto 0);
signal s0, s1, s2, s3, s4, s5, s6, s7 : std_logic_vector (7 downto 0); -- affichage des 7 segments
signal score_tmp : std_logic_vector (7 downto 0);

begin
    
    process(clk25, reset)
    
          begin
          if reset = '0' then 
                counter<=0; sel_seg <= not "00000000"; seg <= not "00000000";
          elsif rising_edge(clk25) then
       
                -- Gestion du Compteur
                counter <= counter + 1; 
             if (counter = 99999) then counter <= 0; end if;
                -- affichage de "CASSE BRI(ques)"
                case (counter) is
                    
                    --when 00000 => sel_seg <= not "00000001"; seg <= not "00010000"; --i
                    --when 10000 => sel_seg <= not "00000010"; seg <= not "01010000"; --r
                    --when 20000 => sel_seg <= not "00000100"; seg <= not "01111100"; --b
                    --when 30000 => sel_seg <= not "00001000"; seg <= not "11111001"; --e
                    --when 40000 => sel_seg <= not "00010000"; seg <= not "01101101"; --s
                    --when 50000 => sel_seg <= not "00100000"; seg <= not "01101101"; --s
                    --when 60000 => sel_seg <= not "01000000"; seg <= not "01110111"; --a
                    --when 70000 => sel_seg <= not "10000000"; seg <= not "00111001"; --c
                    when 00000 => sel_seg <= not "00000001"; seg <= not s0;     -- Timer[0]
                    when 10000 => sel_seg <= not "00000010"; seg <= not s1;     -- Timer[1]
                    when 20000 => sel_seg <= not "00000100"; seg <= not s2;     -- Timer[2]
                    when 30000 => sel_seg <= not "00001000"; seg <= not s3;     -- Timer[3]
                    when 40000 => sel_seg <= not "00010000"; seg <= not "00000000"; -- mis à 0 pour séparer le timer du score
                    when 50000 => sel_seg <= not "00100000"; seg <= not s4;     -- Score[0]
                    when 60000 => sel_seg <= not "01000000"; seg <= not s5;     -- Score[1]
                    when 70000 => sel_seg <= not "10000000"; seg <= not s6;     -- Score[2]
    
                    when others => NULL;
                
                end case;    
      
                if master_slave = '0' then 
                
                -- Affichage de "MANETTE"
                    case (counter) is
    
                        when 00000 => sel_seg <= not "00000001"; seg <= not "00000000"; 
                        when 10000 => sel_seg <= not "00000010"; seg <= not "01111001"; --e
                        when 20000 => sel_seg <= not "00000100"; seg <= not "01111000"; --t
                        when 30000 => sel_seg <= not "00001000"; seg <= not "01111000"; --t
                        when 40000 => sel_seg <= not "00010000"; seg <= not "01111001"; --e
                        when 50000 => sel_seg <= not "00100000"; seg <= not "01010100"; --n
                        when 60000 => sel_seg <= not "01000000"; seg <= not "01110111"; --a
                        when 70000 => sel_seg <= not "10000000"; seg <= not "00110111"; --m
          
                        when others => NULL;
    
                    end case;
    
                -- Affichage de "PAUSE"
                elsif pause = '1'  and game_lost = '0' then       
         
                    case (counter) is
    
                        when 00000 => sel_seg <= not "00000001"; seg <= not "00000000"; 
                        when 10000 => sel_seg <= not "00000010"; seg <= not "00000000"; 
                        when 20000 => sel_seg <= not "00000100"; seg <= not "00000000"; 
                        when 30000 => sel_seg <= not "00001000"; seg <= not "01111001"; --e
                        when 40000 => sel_seg <= not "00010000"; seg <= not "01101101"; --s
                        when 50000 => sel_seg <= not "00100000"; seg <= not "00111110"; --u
                        when 60000 => sel_seg <= not "01000000"; seg <= not "01110111"; --a
                        when 70000 => sel_seg <= not "10000000"; seg <= not "01110011"; --p
                        when others => NULL;
    
                    end case;
                    
                -- Affichage de "WinnEr"
                elsif game_win = '1' then       
         
                    case (counter) is
    
                        when 00000 => sel_seg <= not "00000001"; seg <= not "00000000"; 
                        when 10000 => sel_seg <= not "00000010"; seg <= not "01010000"; --r
                        when 20000 => sel_seg <= not "00000100"; seg <= not "01111001"; --e
                        when 30000 => sel_seg <= not "00001000"; seg <= not "00110111"; --n
                        when 40000 => sel_seg <= not "00010000"; seg <= not "00110111"; --n
                        when 50000 => sel_seg <= not "00100000"; seg <= not "00110000"; --i
                        when 60000 => sel_seg <= not "01000000"; seg <= not "00011110"; --w
                        when 70000 => sel_seg <= not "10000000"; seg <= not "00111100"; --w
                        when others => NULL;
    
                    end case;
                    
                -- Affichage de "LoosEr"
                elsif pause = '1'  and game_lost = '1' then       
         
                    case (counter) is
    
                        when 00000 => sel_seg <= not "00000001"; seg <= not "00000000"; 
                        when 10000 => sel_seg <= not "00000010"; seg <= not "00000000"; 
                        when 20000 => sel_seg <= not "00000100"; seg <= not "01010000"; --r
                        when 30000 => sel_seg <= not "00001000"; seg <= not "01111001"; --e
                        when 40000 => sel_seg <= not "00010000"; seg <= not "01101101"; --s
                        when 50000 => sel_seg <= not "00100000"; seg <= not "00111111"; --o
                        when 60000 => sel_seg <= not "01000000"; seg <= not "00111111"; --o
                        when 70000 => sel_seg <= not "10000000"; seg <= not "00111000"; --L
                        when others => NULL;
    
                    end case;
     
                -- Affichage de "PONG"
                elsif game_type = '1' then       
                    
                    case (counter) is
                    
                        when 00000 => sel_seg <= not "00000001"; seg <= not "00000000"; --
                        when 10000 => sel_seg <= not "00000010"; seg <= not "00000000"; --
                        when 20000 => sel_seg <= not "00000100"; seg <= not "00000000"; --
                        when 30000 => sel_seg <= not "00001000"; seg <= not "00000000"; --
                        when 40000 => sel_seg <= not "00010000"; seg <= not "01111101"; --g
                        when 50000 => sel_seg <= not "00100000"; seg <= not "00110111"; --n
                        when 60000 => sel_seg <= not "01000000"; seg <= not "00111111"; --o
                        when 70000 => sel_seg <= not "10000000"; seg <= not "01110011"; --p
          
                        when others => NULL;
    
                    end case;
                end if;     
            end if;
        end process;
        
        
        
    -- Pour l'affichage du Timer restant
    binary_bdc0: entity work.binary_bcd             -- Transforme le timer codé en binaire en DCB
        port map(
            in_binary => Timer_Game_Affichage,
            digit_0 => Time0, 
            digit_1 => Time1,
            digit_2 => Time2, 
            digit_3 => Time3);
    transcod0 : entity work.transcod               -- Transcodage pour afficher le numéro sur les 7 segments
        port map( 
            e => Time0,
            s => s0);     
    transcod1 : entity work.transcod               -- Transcodage pour afficher le numéro sur les 7 segments
        port map( 
            e => Time1,
            s => s1);
    transcod2 : entity work.transcod               -- Transcodage pour afficher le numéro sur les 7 segments
        port map( 
            e => Time2,
            s => s2);      
    transcod3 : entity work.transcod               -- Transcodage pour afficher le numéro sur les 7 segments
        port map( 
            e => Time3,
            s => s3);
            
    -- Pour l'affichage du score
    score_tmp <= "000" & score;
    binary_bdc1: entity work.binary_bcd     -- Transforme le score codé en binaire en DCB
        port map(
            in_binary => score_tmp,
            digit_0 => score0, 
            digit_1 => score1,
            digit_2 => score2, 
            digit_3 => score3);
    transcod4 : entity work.transcod        -- Transcodage pour afficher le numéro sur les 7 segments
        port map( 
            e => score0,
            s => s4);     
    transcod5 : entity work.transcod        -- Transcodage pour afficher le numéro sur les 7 segments
        port map( 
            e => score1,
            s => s5);
    transcod6 : entity work.transcod        -- Transcodage pour afficher le numéro sur les 7 segments
        port map( 
            e => score2,
            s => s6);      
    transcod7 : entity work.transcod        -- Transcodage pour afficher le numéro sur les 7 segments
        port map( 
            e => score3,
            s => s7);
            
end Behavioral;

