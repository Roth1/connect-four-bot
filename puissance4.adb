with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Participant;

use Ada.Text_IO;
use Ada.Integer_Text_IO;
use Participant;

package body Puissance4 is


-- on initilialise la grille (vide) de puissance 4 de N*M
   procedure Initialiser(E: in out Etat) is
   begin
      New_Line;
      for I in 1..M loop
         if I < 10 then
            Put(" ");
	 end if;
	 -- affiche les numéros de lignes
	 Put(Integer'Image(I));
      end loop;
      New_Line;
      -- affiche la grille 
      for I in 1..N loop
         for J in 1..M loop
            E(I, J, 1) := '|';
            Put(E(I, J, 1));
            E(I, J, 2) := ' ';
            Put(E(I, J, 2));
	    -- les cellules intéressantes sont vide
	    E(I, J, 3) := ' ';
	    Put(E(I, J, 3));
         end loop;
	 -- la ligne à droite
         Put('|');
         New_Line;
      end loop;
      for I in 1..M loop
	 -- la ligne en bas
         Put("---");
      end loop;
      Put("-");
   end Initialiser;

   -- Teste les lignes de la grille pour placer le pion sur la bonne ligne en fonction de la colonne donnée
   function Jouer(E: Etat; C: Coup) return Etat is
      Top : Natural := 1; -- Top est la premiere ligne
      Le_Etat : Etat := E; -- l'état donné
   begin
      while Top /= N + 1 and then E(Top, C.C, 3) /= 'X' and then E(Top, C.C, 3) /= 'O' loop  -- tant que E(top,C.C,3) est vide
         -- descend une ligne
	 Top := Top + 1;
      end loop;
      if C.J = Joueur1 then -- si c'est au tour du joueur1 (donc les 'X')
         Le_Etat(Top - 1, C.C, 3) := 'X'; -- on met une 'X' dans la colonne donnée (C.C) et dans la ligne libre la "plus basse" de la grille
      else
         Le_Etat(Top - 1, C.C, 3) := 'O'; -- idem pour 'O'
      end if;
      -- retourne le nouveau état
      return Le_Etat;
   end Jouer;

   -- Teste si P pions du joueur J sont alignés selon : - les lignes -les colonnes -les diagonales avec counter= nombre de pions alignés
   function Est_Gagnant(E: Etat; J: Joueur) return Boolean is
      Counter : Natural := 0; -- un compteur
      Symbol : Character; -- le symbole du joueur: soit 'X', soit 'O'
   begin
      -- on associe le symbole au joueur
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
      -- teste les diagonales en anglais
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

   -- s'il reste une case vide le match n'est pas nul
   function Est_Nul(E: Etat) return Boolean is
   begin
       for J in 1..M loop
	  -- teste pour une case vide
	  if E(1, J, 3) = ' ' then
	     return False;
	  end if;
       end loop;
       -- toutes les cases en haut sont pleines -> nul
       return True;
   end Est_Nul;

   procedure Afficher(E: in Etat) is
   begin
      for I in 1..M loop -- pour chaque colonne
         if I < 10 then
            Put(" "); -- pour avoir une "belle" grille (sinon décalage)
         end if;
         Put(Integer'Image(I));
      end loop;
      New_Line;
      for I in 1..N loop
         for J in 1..M loop
            Put(E(I, J, 1)); -- on crée chaque case avec '|' + ' ' + soit 'X' soit '0' soit ' '
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

   -- on retourne la colonne donnée dans C
   procedure Affiche_Coup(C: in Coup) is
   begin
      Put_Line(" ");
      Put_Line("Le coup est : placement de pion dans la colonne" & Integer'Image(C.C) & ".");
      Put_Line(" ");
   end Affiche_Coup;


   function Demande_Coup_Joueur1(E: in Etat) return Coup is
      Input : Integer;
      Le_Coup : Coup;
   begin
      Put_Line(" ");
      Put_Line("Joueur 1 : Tapez votre coup!");
      -- do/while loop
      loop
         Get(Input); -- on récupère la valeur tapée au clavier (ie la colonne)
         if Input > 0 and Input < M + 1 then
            if E(1, Input, 3) /= 'X' and E(1, Input, 3) /= 'O' then -- on vérifie que la ligne la + haute de la grille soit libre -> coup possible
               exit;
            end if;
         end if;
         Put_Line("Ce n'est pas possible, essayez encore une fois !"); -- si le coup est impossible on demande une autre valeur
      end loop;
      -- on met les informations dans la variable Le_Coup
      Le_Coup.C := Input;
      Le_Coup.J := Joueur1;
      return Le_Coup;
   end Demande_Coup_Joueur1;

   -- meme principe que Demande_Coup_Joueur1
   function Demande_Coup_Joueur2(E: in Etat) return Coup is
      Input : Integer;
      Le_Coup : Coup;
   begin
      Put_Line(" ");
      Put_Line("Joueur 2 : Tapez votre coup!");
      -- do/while
      loop
         Get(Input);
         if Input > 0 and Input < M + 1 then
            if E(1, Input, 3) /= 'X' and E(1, Input, 3) /= 'O' then
               exit;
            end if;
         end if;
         Put_Line("Ce n'est pas possible, essayez encore une fois!");
      end loop;
      -- on met les informations dans la variable Le_Coup
      Le_Coup.C := Input;
      Le_Coup.J := Joueur2;
      return Le_Coup;
   end Demande_Coup_Joueur2;
   
   -- retourne une liste des coups possibles
   function Coups_Possibles(E : Etat; J : Joueur) return Liste_Coups.Liste is
      -- crée une liste de coups
      Coup_Liste : Liste_Coups.Liste := Creer_Liste;
      Le_Coup : Coup; -- un coup
   begin
      -- pour chaque colonne
      for K in 1..M loop
         if E(1, K, 3) /= 'X' and E(1, K, 3) /= 'O' then -- case "vide" de la grille
	    -- on met les informations dans la variable Le_Coup
            Le_Coup.C := K;
            Le_Coup.J := J;
	    -- ajout ce coup en tête de la liste
            Insere_Tete(Le_Coup, Coup_Liste);
         end if;
      end loop;
      -- retourne la liste
      return Coup_Liste;
   end Coups_Possibles;

   -- Evaluation statique du jeu du point de vue de l'ordinateur
   function Eval(E : Etat) return Integer is
      Counter : Integer := 0; -- Evaluation qu'on va retourner
      Counter_L : Integer := 0; -- Evaluation des lignes
      Counter_C : Integer := 0; -- Evaluation d'une colonnes
      Counter_D : Integer := 0; -- Evaluation d'une diagonale
   begin
      for I in 1..N loop
         for J in 1..M loop
	    -- cas 'X'
            if E(I, J, 3) = 'X' then
               if J > 1 and J < M then
		  if E(I, J - 1, 3) = ' ' and E(I, J + 1, 3) = 'X' then -- situation ' ''X''X'
                     Counter_L := Counter_L + 20;
		     if J > 2 then
			if E(I, J - 2, 3) = 'X' then -- situation 'X'' ''X''X'
			   Counter_L := Counter_L + 100;
			end if;
		     end if;
		     if J < M - 1 then
			if E(I, J + 2, 3) = 'X' then -- situation ' ''X''X''X'
			   Counter_L := Counter_L + 100;
			end if;
		     end if;
                  elsif E(I, J - 1, 3) = 'X' and E(I, J + 1, 3) = ' ' then -- situation 'X''X'' '
                     Counter_L := Counter_L + 20;
		     if J > 2 then
			if E(I, J - 2, 3) = 'X' then 
			   Counter_L := Counter_L + 100; -- situation 'X''X''X'' '
			end if;
		     end if;
		     if J < M - 1 then
			if E(I, J + 2, 3) = 'X' then
			   Counter_L := Counter_L + 100; -- situation 'X''X'' ''X'
			end if;
		     end if;
                  end if;
               end if;
	    -- cas 'O' - de meme mais avec 'O'
            elsif E(I, J, 3) = 'O' then
               if J > 1 and J < M then
                  if E(I, J - 1, 3) = ' ' and E(I, J + 1, 3) = 'O' then
                     Counter_L := Counter_L - 20; -- situation ' ''O''O'
		     if J > 2 then
			if E(I, J - 2, 3) = 'O' then 
			   Counter_L := Counter_L - 100; -- situation 'O'' ''O''O'
			end if;
		     end if;
		     if J < M - 1 then
			if E(I, J + 2, 3) = 'O' then
			   Counter_L := Counter_L - 100; -- situation ' ''O''O''O'
			end if;
		     end if;
                  elsif E(I, J - 1, 3) = 'O' and E(I, J + 1, 3) = ' ' then
                     Counter_L := Counter_L - 20; -- situation 'O''O'' '
		     if J > 2 then
			if E(I, J - 2, 3) = 'O' then 
			   Counter_L := Counter_L - 100; -- situation 'O''O''O'' '
			end if;
		     end if;
		     if J < M - 1 then
			if E(I, J + 2, 3) = 'O' then
			   Counter_L := Counter_L - 100; -- situation 'O''O'' ''O'
			end if;
		     end if;
                  end if;
               end if;
            end if;
         end loop;
      end loop;
      -- le résultat des lignes va dans Counter
      Counter := Counter_L;
      -- pour les colonnes: pareil que Est_Gagnant, mais on incremente/decremente le Counter
      -- pour 'X'
      for K in 1..M loop
         for I in 1..N loop
            if E(I, K, 3) = 'X' then
               Counter_C := Counter_C + 20; -- incremente si on a plusieurs
	    elsif E(I, K, 3) = 'O' then
	       Counter_C := 0; -- remet à zéro si la chaine est interrompue
	    end if;
	 end loop;
	 Counter := Counter + Counter_C;
      end loop;
      -- pour 'O'
      for K in 1..M loop
         for I in 1..N loop
            if E(I, K, 3) = 'O' then
               Counter_C := Counter_C - 20; -- decremente si on a plusieurs
	    elsif E(I, K, 3) = 'X' then
	       Counter_C := 0; -- remet à zéro si la chaine est interrompue
	    end if;
	 end loop;
	 Counter := Counter + Counter_C;
      end loop;
      -- pour les diagonales, c'est aussi pareil et on incremente/decremente
      -- pour 'X'
      -- test the possible downwards diagonals from left to right
      for K in 1..M loop
	 Counter_D := 0;
	 for D in 0..(M - K) loop
	    if 1 + D > N or K + D > M then
	       exit;
	    end if;
	    if E(1 + D, K + D, 3) = 'X' then
	        Counter_D := Counter_D + 20;
	    elsif E(1 + D, K + D, 3) = 'O' then
	        Counter_D := 0;
	    end if;
	 end loop;
	 Counter := Counter + Counter_D;
      end loop;
      -- test the possible downwards diagonals from top to bottom
      for I in 1..N loop
	 Counter_D := 0;
            for D in 0..(N - I) loop
               if I + D > N or 1 + D > M then
                  exit;
               end if;
               if E(I + D, 1 + D, 3) = 'X' then
                  Counter_D := Counter_D + 20;
	       elsif E(I + D, 1 + D, 3) = 'O' then
                  Counter_D := 0;
               end if;
            end loop;
	    Counter := Counter + Counter_D;
      end loop;
      -- test the possible upwards diagonals from left to right
      for K in 1..M loop
	 Counter_D := 0;
            for D in 0..(M - K) loop
               if N - D < 1 or K + D > M then
                  exit;
               end if;
               if E(N - D, K + D, 3) = 'X' then
                  Counter_D := Counter_D + 20;
	       elsif E(N - D, K + D, 3) = 'O' then
                  Counter_D := 0;
	       end if;
            end loop;
	    Counter := Counter + Counter_D;
      end loop;
      -- test the possible upwards diagonals from bottom to top
      for I in 1..N loop
	 Counter_D := 0;
            for D in 0..(N - I) loop
               if N - D < 1 or 1 + D > M then
                  exit;
               end if;
               if E(N - D, 1 + D, 3) = 'X' then
                  Counter_D := Counter_D + 20;
	       elsif E(N - D, 1 + D, 3) = 'O' then
                  Counter := 0;
               end if;
            end loop;
	    Counter := Counter + Counter_D;
      end loop;
      -- pareil pour 'O'
      -- test the possible downwards diagonals from left to right
      for K in 1..M loop
	 Counter_D := 0;	 
	 for D in 0..(M - K) loop
	    if 1 + D > N or K + D > M then
	       exit;
	    end if;
	    if E(1 + D, K + D, 3) = 'O' then
	        Counter_D := Counter_D - 20;
	    elsif E(1 + D, K + D, 3) = 'X' then
	        Counter_D := 0;
	    end if;
	 end loop;
	 Counter := Counter + Counter_D;
      end loop;
      -- test the possible downwards diagonals from top to bottom
      for I in 1..N loop
	    Counter_D := 0;
            for D in 0..(N - I) loop
               if I + D > N or 1 + D > M then
                  exit;
               end if;
               if E(I + D, 1 + D, 3) = 'O' then
                  Counter_D := Counter_D - 20;
	       elsif E(I + D, 1 + D, 3) = 'X' then
                  Counter_D := 0;
               end if;
            end loop;
	    Counter := Counter + Counter_D;
      end loop;
      -- test the possible upwards diagonals from left to right
      for K in 1..M loop
	    Counter_D := 0;
            for D in 0..(M - K) loop
               if N - D < 1 or K + D > M then
                  exit;
               end if;
               if E(N - D, K + D, 3) = 'O' then
                  Counter_D := Counter_D - 20;
	       elsif E(N - D, K + D, 3) = 'X' then
                  Counter_D := 0;
	       end if;
            end loop;
	    Counter := Counter + Counter_D;
      end loop;
      -- test the possible upwards diagonals from bottom to top
      for I in 1..N loop
	    Counter_D := 0;
            for D in 0..(N - I) loop
               if N - D < 1 or 1 + D > M then
                  exit;
               end if;
               if E(N - D, 1 + D, 3) = 'O' then
                  Counter_D := Counter_D - 20;
	       elsif E(N - D, 1 + D, 3) = 'X' then
                  Counter := 0;
               end if;
            end loop;
	    Counter := Counter + Counter_D;
      end loop;
      -- retourne l'évaluation de l'état
      return Counter;
   end Eval;
   
end Puissance4;
