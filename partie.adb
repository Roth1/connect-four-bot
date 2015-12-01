with Liste_Generique, Participant;
with Ada.Text_IO;

use Participant;

package body Partie is
   
   -- ...
   procedure Joue_Partie(E : in out Etat; J : in Joueur) is
      Check : Boolean := False;
      Le_Coup : Coup;
   begin
      while Check = False loop	 
	 if J = Joueur1 then
	    Le_Coup := Coup_Joueur1(E);
	 else 
	    Le_Coup := Coup_Joueur1(E);
	 end if;
	 Affiche_Coup(Le_Coup);
	 E := Etat_Suivant(E, Le_Coup);
	 Affiche_Jeu(E);
	 if Est_Gagnant(E, J) then
	    Check := True;
	 end if;
	 if Est_Nul(E) then
	    Check := True;
	 end if;
      end loop;
   end Joue_Partie;
   
end Partie;
