with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Participant;

use Ada.Text_IO;
use Ada.Integer_Text_IO;
use Participant;

package body Puissance4 is
   
   procedure Initialiser(E: in out Etat) is
   begin
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
	    E(I, J, 1) := '|';
	    Put(E(I, J, 1));
	    E(I, J, 2) := ' ';
	    Put(E(I, J, 2));
	 E(I, J, 3) := ' ';
	 Put(E(I, J, 3));
	 end loop;
	 Put('|');
	 New_Line;
      end loop;
      for I in 1..M loop
	 Put("---");
      end loop;
      Put("-");
   end Initialiser;
   
   -- ...
   function Jouer(E: Etat; C: Coup; J: Joueur) return Etat is
      Top : Natural := 1;
      Le_Etat : Etat := E;
   begin
      while Top /= N + 1 and then E(Top, C, 3) /= 'X' and then E(Top, C, 3) /= 'O' loop
	 Top := Top + 1;
      end loop;
      if J = Joueur1 then
	 Le_Etat(Top - 1, C, 3) := 'X';
      else
	 Le_Etat(Top - 1, C, 3) := 'O';
      end if;
      return Le_Etat;
   end Jouer;
   
   --
   function Est_Gagnant(E: Etat; J: Joueur) return Boolean is
      Counter : Natural := 0;   
      Symbol : Character;
   begin
      -- connect player to symbol
      if J = Joueur1 then
	 Symbol := 'X';
      else
	 Symbol := 'O';
      end if;
      -- teste les lignes
      for I in 1..N loop
	 Counter := 0;
	 for K in 1..M loop
	    if E(I, K, 3) = Symbol then
	       Counter := Counter + 1;
	       if Counter = P then
		  Put_Line(" ");
		  Put_Line(" ");
		  Put_Line("Vous avez gangné le match !");
		  Put_Line(" ");
		  return True;
	       end if;
	    else 
	       Counter := 0;
	    end if;
	 end loop;
      end loop;
      -- teste les colonnes
      Counter := 0;
      for K in 1..M loop
	 Counter := 0;
	 for I in 1..N loop
	    if E(I, K, 3) = Symbol then
	       Counter := Counter + 1;
	       if Counter = P then
		  Put_Line(" ");
		  Put_Line(" ");
		  Put_Line("Vous avez gangné le match !");
		  Put_Line(" ");
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
	    if E(1, J, 3) = ' ' then
	       return False;
	    end if;
	 end loop;
	 Put_Line(" ");
	 Put_Line(" ");
	 Put_Line("Resultat : NUL !");
	 Put_Line(" ");
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
	    Put(E(I, J, 1));
	    Put(E(I, J, 2));
	    Put(E(I, J, 3));
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
      Put_Line(" ");
      Put_Line("Le coup est : placement de pion dans la colonne" & Integer'Image(C) & ".");
      Put_Line(" ");
   end Affiche_Coup;
   
   -- ....
   function Demande_Coup_Joueur1(E: in Etat) return Coup is
      Input : Integer;
   begin
      Put_Line(" ");
      Put_Line("Joueur 1 : Tapez votre coup!");
      -- implement do/while
      loop
	 Get(Input);
	 if Input > 0 and Input < M + 1 then
	    if E(1, Input, 3) /= 'X' and E(1, Input, 3) /= 'O' then
	       exit;
	    end if;
	 end if;
	 Put_Line("Ce n'est pas possible, essayez encore une fois !");
      end loop;
      return Input;
   end Demande_Coup_Joueur1;
   
   -- ....
   function Demande_Coup_Joueur2(E: in Etat) return Coup is
      Input : Integer;
   begin
      Put_Line(" ");
      Put_Line("Joueur 2 : Tapez votre coup!");
      -- implement do/while
      loop
	 Get(Input);
	 if Input > 0 and Input < M + 1 then
	    if E(1, Input, 3) /= 'X' and E(1, Input, 3) /= 'O' then
	       exit;
	    end if;
	 end if;
	 Put_Line("Ce n'est pas possible, essayez encore une fois!");
      end loop;
      return Input;
   end Demande_Coup_Joueur2;
   
end Puissance4;
