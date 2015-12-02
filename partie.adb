with Liste_Generique
with Participant;
with Ada.Text_IO;

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
	 Affiche_Coup(Le_Coup);
	 E := Etat_Suivant(E, Le_Coup);
	 Affiche_Jeu(E);
	 if Est_Gagnant(E, Le_Joueur) then
	    exit;
	 end if;
	 if Est_Nul(E) then
	    exit;
	 end if;
	 Le_Joueur := Adversaire(Le_Joueur);
      end loop;
   end Joue_Partie;
   
end Partie;
