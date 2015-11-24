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
   type Etat_Type is array(1..10, 1..10, 1..3) of Character;
   Etat : Etat_Type;
begin
   Put("Enter dimensions: ");
   -- Get(N);
   New_Line;
   for I in 1..N loop
      if I < 10 then
	 Put(" ");
      end if;
      Put(Integer'Image(I));
   end loop;
   New_Line;
   for I in 1..N loop
      for I in 1..(N+1) loop
	 Put("|  ");   
	  end loop;
	  New_Line;
   end loop;
   for I in 1..N loop
      Put("---");
   end loop;
   Put("-");
   
   -- affiche coup
   New_Line;
   New_Line;
   -- New_Line;
   for I in 1..N loop
      if I < 10 then
	 Put(" ");
      end if;
      Put(Integer'Image(I));
   end loop;
   New_Line;
   for I in 1..N loop
      for J in 1..N loop
	 Etat(J, I, 1) := '|';
	 Put(Etat(J, I, 1));
	 Etat(J, I, 2) := ' ';
	 Put(Etat(J, I, 2));
	 Etat(J, I, 3) := ' ';
	 Put(Etat(J, I, 3));
      end loop;
      Put('|');
      New_Line;
   end loop;
   for I in 1..N loop
      Put("---");
   end loop;
   Put("-");
   
end Test_Affiche_Jeu;

-- procedure Test_Affiche_Jeu is
-- begin
   -- Affiche_Jeu;
-- end Test_Affiche_Jeu;
