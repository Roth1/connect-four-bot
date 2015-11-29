with Ada.Text_IO;
with Ada.Integer_Text_IO;

use Ada.Text_IO;
use Ada.Integer_Text_IO;

package body Puissance4 is
   
   procedure Initialiser(E: in out Etat) is
      
   begin
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
   end Initialiser;
   
   --
   function Est_Gagnant(E: Etat, XO: Joueur) return Boolean is
      Counter : Natural := 0;   
      Symbol : Char;
   begin
      -- teste les lignes
      for I in 1..N loop
	 for J in 1..M loop
	    if Etat[I][J][3] = XO then
	       Counter := Counter + 1;
	       if Counter = P then 
		  return True;
	       end if;
	    else 
	       Counter := 0;
	    end if;
	 end loop;
      end loop;
      -- teste les colonnes
      Counter := 0;
      for J in 1..M loop
	 for I in 1..N loop
	    if Etat[I][J][3] = XO then
	       Counter := Counter + 1;
	       if Counter = P then 
		  return True;
	       end if;
	    else 
	       Counter := 0;
	    end if;
	 end loop;
      end loop;
      -- teste les diagonales
      return False;
   end Est_Gagnant;
   
   -- ..
   function Est_Nul(E: Etat) return Boolean is
   begin
	 for J in 1..M loop
	    if Etat(I, J, 3) = ' ' then
	       return False;
	    end if;
	 end loop;
	 return True;
   end Est_Nul;
   
   procedure Afficher(E: in Etat) is
   begin
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
   end Afficher;
  
   --
   
   procedure Affiche_Coup(C: in Coup) is 
   begin 
      Put_Line("Le coup est : placement de pion dans la colonne " & Integer'Image(C));
   end Affiche_Coup;
   
   function Demande_Coup_Joueur1(E: in Etat) return Coup is
      Afficher(E);
      Put_Line("Tapez votre coup!");
      Coup : Input;
      Check : Boolean := False;
      -- implement do/while
      while(Check = False) loop
	 Get(Input);
	 if Input < M + 1 then
	    if Etat(N, Input, 3) /= ('X' or 'O') then
	       Check := True;
	    end if;
	 end if;
      end loop;
      return Input;
end Demande_Coup_Joueur1;



















