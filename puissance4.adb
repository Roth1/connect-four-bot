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
   function Jouer(E: Etat; C: Coup) return Etat is
      Top : Natural := 1;
      Le_Etat : Etat := E;
   begin
      while Top /= N + 1 and then E(Top, C.C, 3) /= 'X' and then E(Top, C.C, 3) /= 'O' loop
	 Top := Top + 1;
      end loop;
      if C.J = Joueur1 then
	 Le_Etat(Top - 1, C.C, 3) := 'X';
      else
	 Le_Etat(Top - 1, C.C, 3) := 'O';
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
		  return True;
	       end if;
	    else 
	       Counter := 0;
	    end if;
	 end loop;
      end loop;
      -- teste les diagonales
      -- test the possible downwards diagonals from left to right
      for K in 1..(M - P + 1) loop
	    Counter := 0;
	    for D in 0..(M - K) loop
	       if 1 + D > N or K + D > M then
		  exit;
	       end if;
	       if E(1 + D, K + D, 3) = Symbol then
		  Counter := Counter + 1;
		  if Counter = P then
		     return True;
		  end if;
	       else 
		  Counter := 0;
	       end if;
	    end loop;
      end loop;
      -- test the possible downwards diagonals from top to bottom
      for I in 1..(N - P + 1) loop
	 Counter := 0;
	    for D in 0..(N - I) loop
	       if I + D > N or 1 + D > M then
		  exit;
	       end if;
	       if E(I + D, 1 + D, 3) = Symbol then
		  Counter := Counter + 1;
		  if Counter = P then
		     return True;
		  end if;
	       else 
		  Counter := 0;
	       end if;
	    end loop;
      end loop;
      -- test the possible upwards diagonals from left to right
      for K in 1..(M - P + 1) loop
	    Counter := 0;
	    for D in 0..(M - K) loop
	       if N - D < 1 or K + D > M then
		  exit;
	       end if;
	       if E(N - D, K + D, 3) = Symbol then
		  Counter := Counter + 1;
		  if Counter = P then
		     return True;
		  end if;
	       else 
		  Counter := 0;
	       end if;
	    end loop;
      end loop;
      -- test the possible upwards diagonals from bottom to top
      for I in 1..(N - P + 1) loop
	    Counter := 0;
	    for D in 0..(N - I) loop
	       if N - D < 1 or 1 + D > M then
		  exit;
	       end if;
	       if E(N - D, 1 + D, 3) = Symbol then
		  Counter := Counter + 1;
		  if Counter = P then
		     return True;
		  end if;
	       else 
		  Counter := 0;
	       end if;
	    end loop;
      end loop;
      -- all tests failed : no winner yet
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
      Put_Line("Le coup est : placement de pion dans la colonne" & Integer'Image(C.C) & ".");
      Put_Line(" ");
   end Affiche_Coup;
   
   -- ....
   function Demande_Coup_Joueur1(E: in Etat) return Coup is
      Input : Integer;
      Le_Coup : Coup;
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
      Le_Coup.C := Input;
      Le_Coup.J := Joueur1;
      return Le_Coup;
   end Demande_Coup_Joueur1;
      
   -- ....
   function Demande_Coup_Joueur2(E: in Etat) return Coup is
      Input : Integer;
      Le_Coup : Coup;
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
      Le_Coup.C := Input;
      Le_Coup.J := Joueur2;
      return Le_Coup;
   end Demande_Coup_Joueur2;
   
   function Coups_Possibles(E : Etat; J : Joueur) return Liste_Coups.Liste is
      Coup_Liste : Liste_Coups.Liste := Creer_Liste;
      Le_Coup : Coup;
   begin
      for K in 1..M loop
	 if E(1, K, 3) /= 'X' and E(1, K, 3) /= 'O' then
	    Le_Coup.C := K;
	    Le_Coup.J := J;
	    Insere_Tete(Le_Coup, Coup_Liste);
	 end if;
      end loop;
      return Coup_Liste;
   end Coups_Possibles;
   
    -- Evaluation statique du jeu du point de vue de l'ordinateur
   function Eval(E : Etat) return Integer is
      Counter_C : Integer := 0;
      Counter_L : Integer := 0;
      
      --function Voisins_H(Positive I; Positive J) is
      --begin	 
	 
      --end Voisins_H;
      
      --function Voisins_V(Positive I; Positive J) is
      --begin	 
	 
      --end Voisins_V;

   begin
--       for I in 1..N loop
-- 	 -- Counter_L := 0;
-- 	 for K in 1..M loop
-- 	    if E(I, K, 3) = 'X' then
-- 	       Counter_L := Counter_L + 5;
-- 	    elsif E(I, K, 3) = 'O' then
-- 	      Counter_L := Counter_L -5;
-- 	    end if;
-- 	    if K < M and Counter_L > 10 then
-- 	       if E(I, K, 3) = ' ' then
-- 		  Counter_L := Counter_L
-- 	 end loop;
--       end loop;
--       -- teste les colonnes
--       Counter_C := 0;
--       for K in 1..M loop
-- 	 Counter_C := 0;
-- 	 for I in 1..N loop
-- 	    if E(I, K, 3) = 'X' then
-- 	       Counter_C := Counter_C + 10;
-- 	    elsif E(I, K, 3) = 'O' then
-- 	       Counter_C := Counter_C -10;
-- 	    end if;
-- 	 end loop;
--       end loop;
--       return Counter_C + Counter_L;
      for I in 1..N loop
	 for J in 1..M loop
	    if E(I, J, 3) = 'X' then
	       if J > 1 and J < M then
		  if E(I, J - 1, 3) = ' ' and E(I, J + 1, 3) = 'X' then
		     Counter_L := Counter_L + 20;
		  elsif E(I, J - 1, 3) = 'X' and E(I, J + 1, 3) = ' ' then
		     Counter_L := Counter_L + 20;
		  end if;
	       end if;
	       if I > 1 and I < N then
		  if E(I - 1, J, 3) = ' ' and E(I + 1, J, 3) = 'X' then
		     Counter_L := Counter_L + 20;
		  elsif E(I - 1, J, 3) = 'X' and E(I + 1, J, 3) = ' ' then
		     Counter_L := Counter_L + 20;
		  end if;
	       end if;
	    elsif E(I, J, 3) = 'O' then
	       if J > 1 and J < M then
		  if E(I, J - 1, 3) = ' ' and E(I, J + 1, 3) = 'O' then
		     Counter_L := Counter_L - 30;
		  elsif E(I, J - 1, 3) = 'O' and E(I, J + 1, 3) = ' ' then
		     Counter_L := Counter_L - 30;
		  end if;
	       end if;
	       if I > 1 and I < N then
		  if E(I - 1, J, 3) = ' ' and E(I + 1, J, 3) = 'O' then
		     Counter_L := Counter_L - 30;
		  elsif E(I - 1, J, 3) = 'O' and E(I + 1, J, 3) = ' ' then
		     Counter_L := Counter_L - 30;
		  end if;
	       end if;
	    end if;
	 end loop;
      end loop;
      return Counter_L;
   end Eval;
   
end Puissance4;
