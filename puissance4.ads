with Ada.Text_IO;
with Ada.Integer_Text_IO;

use Ada.Text_IO;
use Ada.Integer_Text_IO;

package Puissance4 is
   --
   N : Natural;
   M : Natural;
   P : Natural;
   
   --
   type Etat is array(1..N, 1..M, 1..3) of Character;
   type Coup is Integer;
   -- asfs
   procedure Initialiser(E: in out Etat);
   -- asdas
   procedure Joueur();
   -- 
   function Est_Gagnant(E: Etat; J: Joueur) return Boolean;
   --
   function Est_Nul(E: Etat) return Boolean;
   --
   procedure Afficher(E: in Etat);
   --
   procedure Affiche_Coup(C: in Coup);
   -- 
   function Demande_Coup_Joueur1(E: in Etat) return Coup;
   --
   function Demande_Coup_Joueur2(E: in Etat) return Coup;
   
   
   
end Puissance4;
