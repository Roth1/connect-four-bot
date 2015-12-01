with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Strings.Fixed;
-- with Partie;

use Ada.Text_IO;
use Ada.Integer_Text_IO;
use Ada.Strings.Fixed;
-- use Partie;

procedure Test_Affiche_Jeu is
   -- Affiche a l'ecran le coup passe en parametre
   N : Natural := 10;
   M : Natural := 10;
   type Etat_Type is array(1..N, 1..M, 1..3) of Character;
   -- type Coup is new Natural;
   Etat : Etat_Type;
   Counter : Natural := 0;
   Input : Natural := 0;
   Check : Boolean := False;
begin
   Put("Enter dimensions: ");
   -- Get(N);
   New_Line;
   for I in 1..M loop
      if I < 10 then
	 Put(" ");
      end if;
      Put(Integer'Image(I));
   end loop;
   New_Line;
   for I in 1..N loop
      for I in 1..(M+1) loop
	 Put("|  ");   
	  end loop;
	  New_Line;
   end loop;
   for I in 1..M loop
      Put("---");
   end loop;
   Put("-");
   
   -- affiche coup
   New_Line;
   New_Line;
   -- New_Line;
   for I in 1..M loop
      if I < 10 then
	 Put(" ");
      end if;
      Put(Integer'Image(I));
   end loop;
   New_Line;
   for I in 1..N loop
      for J in 1..M loop
	 Etat(I, J, 1) := '|';
	 Put(Etat(I, J, 1));
	 Etat(I, J, 2) := ' ';
	 Put(Etat(I, J, 2));
	 Etat(I, J, 3) := ' ';
	 Put(Etat(I, J, 3));
      end loop;
      Put('|');
      New_Line;
   end loop;
   for I in 1..M loop
      Put("---");
   end loop;
   Put("-");
   
   -- Game
   Etat(1, M, 3) := 'X';
   Etat(N-1, M, 3) := 'X';
   Etat(N-2, M, 3) := 'X';
   Etat(N-3, M, 3) := 'X';
   --Etat(I, J, 1) := '|';
   -- Affiche
   New_Line;
   for I in 1..M loop
	 if I < 10 then
	    Put(" ");
	 end if;
	 Put(Integer'Image(I));
      end loop;
      New_Line;
      for I in 1..N loop
	 for J in 1..M loop
	    Put(Etat(I, J, 1));
	    Put(Etat(I, J, 2));
	    Put(Etat(I, J, 3));
	 end loop;
	 Put('|');
	 New_Line;
      end loop;
      for I in 1..M loop
	 Put("---");
      end loop;
      Put("-");
      
      -- teste Est_Gagnant
      for I in 1..N loop
	 for J in 1..M loop
	    if Etat(I,J,3) = 'X' then
	       Counter := Counter + 1;
	       if Counter = 3 then 
		  Put("WINNER!");
	       end if;
	    else 
	       Counter := 0;
	    end if;
	 --end if;
	 end loop;
      end loop;
      -- teste les colonnes
      Counter := 0;
      for J in 1..M loop
	 for I in 1..N loop
	    if Etat(I,J,3) = 'X' then
	       Counter := Counter + 1;
	       if Counter = 4 then
		  New_Line;
		  Put_Line("WINNER!");
	       end if;
	    else 
	       Counter := 0;
	    end if;
	 end loop;
      end loop;
      
      Put_Line("Tapez votre coup!");
      
      -- implement do/while
      while(Check = False) loop
	 Get(Input);
	 if Input > 0 and then Input < 11 then
	    if Etat(N, Input, 3) /= 'X' then
	       Check := True;
	    end if;
	 end if;
      end loop;
      Put("Coup : " & Integer'Image(Input));
      
end Test_Affiche_Jeu;

-- procedure Test_Affiche_Jeu is
-- begin
   -- Affiche_Jeu;
-- end Test_Affiche_Jeu;
