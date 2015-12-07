-- with Liste_Generique;
with Participant;
with Ada.Text_IO;

use Ada.Text_IO;
use Participant;

package body Partie is

   -- ...
   procedure Joue_Partie(E : in out Etat; J : in Joueur) is
      Check : Boolean := False;
      Le_Coup : Coup;
      Le_Joueur : Joueur := J;
   begin
      loop
         if Le_Joueur = Joueur1 then
            Le_Coup := Coup_Joueur1(E);
         else
            Le_Coup := Coup_Joueur2(E);
         end if;
         Affiche_Coup(Le_Coup); -- on affiche le coup joué
         E := Etat_Suivant(E, Le_Coup);
         Affiche_Jeu(E); -- on affiche la nouvelle grille
         if Est_Gagnant(E, Le_Joueur) then -- on teste si le match est gagné
            Put_Line(" ");
            Put_Line(" ");
            if Le_Joueur = Joueur2 then
               Put_Line("Joueur 2 a gagné le match !");
            else
               Put_Line("Joueur 1 a gagné le match!");
            end if;
            Put_Line(" ");
            exit;
         end if;
         if Est_Nul(E) then -- et si le match est nul
            Put_Line(" ");
            Put_Line(" ");
            Put_Line("Resultat : NUL !");
            Put_Line(" ");
            exit;
         end if;
         Le_Joueur := Adversaire(Le_Joueur);-- une fois le coup joué on passe la main à l'adversaire
      end loop;
   end Joue_Partie;

end Partie;
