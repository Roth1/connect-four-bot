with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Participant;
with Liste_Generique;

use Ada.Text_IO;
use Ada.Integer_Text_IO;
use Participant;

generic
   -- nos variables génériques
   N : Natural; -- le nombre de lignes
   M : Natural; -- le nombre de colonnes
   P : Natural; -- le nombre de pions alignés pour gagner
   
package Puissance4 is      
   -- type Etat est un tableau(Natural, Natural, Natural) of Character
   type Etat is array(1..N, 1..M, 1..3) of Character;
   -- type Coup est un record de la colonne choisie et le joueur responsable
   type Coup is record
      C : Integer; -- la colonne dans laquelle le coup va être effectué
      J : Joueur; -- le joueur responsable pour ce choix
   end record;
   -- initialise la grille
   procedure Initialiser(E: in out Etat);
   -- donne l'état suivant à partir de 'état présent et un coup
   function Jouer(E: Etat; C: Coup) return Etat;
   -- teste si un joueur a gagné
   function Est_Gagnant(E: Etat; J: Joueur) return Boolean;
   -- teste si le match a le résultat nul
   function Est_Nul(E: Etat) return Boolean;
   -- affiche la grille actuelle
   procedure Afficher(E: in Etat);
   -- affiche un coup
   procedure Affiche_Coup(C: in Coup);
   -- demande le prochain coup à joueur 1
   function Demande_Coup_Joueur1(E: in Etat) return Coup;
   -- demande le prochain coup à joueur 2
   function Demande_Coup_Joueur2(E: in Etat) return Coup;
   -- utilise une liste de coups à partir de notre liste générique
   package Liste_Coups is new Liste_Generique(Coup, Affiche_Coup);
   use Liste_Coups;
   -- retourne une liste de coups possibles
   function Coups_Possibles(E : Etat; J : Joueur) return Liste_Coups.Liste; 
    -- Evaluation statique du jeu du point de vue de l'ordinateur
   function Eval(E : Etat) return Integer; 

end Puissance4;
