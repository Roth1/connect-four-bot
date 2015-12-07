with Participant; use Participant;
with Liste_Generique;
with Ada.Text_IO;
with Ada.Numerics.Discrete_Random;

package body Moteur_Jeu is

   -- ...
   function Choix_Coup(E: Etat) return Coup is
      V : Integer := -1000; -- initialisation à la valeur minimale
      Eval_Noeud : Integer := 0; -- initialisation à la valeur neutre
      Coup_Liste : Liste_Coups.Liste := Liste_Coups.Creer_Liste;
      Coup_Iter : Liste_Coups.Iterateur;
      Temp : Coup;
      Le_Coup : Coup;
      G : Generator;
   begin
      -- le joueur virtuel est toujours le Joueur1
      Coup_Liste := Coups_Possibles(E, Joueur1);
      Coup_Iter := Liste_Coups.Creer_Iterateur(Coup_Liste);
      loop
         Temp := Liste_Coups.Element_Courant(Coup_Iter);
         Eval_Noeud := Eval_Min_Max(E, P - 1, Temp, Joueur1);
         if Eval_Noeud > V then -- si le coup étudié est plus favorable au J1 que le coup gardé en mémoire
           V := Eval_Noeud; -- alors on actualise la valeur de V, V représente la valeur max ie la valeur associée au coup le plus favorable
           Le_Coup := Temp; -- et on actualise la valeur du coup que l'on va choisir à la fin de la fonction
         end if;
         -- on introduit du hasard pour que le joueur virtuel "change ses habitudes"
         if Eval_Noeud = V then -- si le coup étudié est autant favorable que le coup en mémoire
               Reset(G);
               -- demarre random generator
               if Random(G) = Heads then
                  Le_Coup  := Temp;
               end if;
         end if;
         exit when not Liste_Coups.A_Suivant(Coup_Iter); -- lorsque l'on a parcouru tout les coups
         Liste_Coups.Suivant(Coup_Iter); -- on parcours le dernir coup
      end loop; -- et on s'arrète
      Liste_Coups.Libere_Iterateur(Coup_Iter);
      return Le_Coup;
   end Choix_Coup;

   -- fonction récursive
   function Eval_Min_Max(E : Etat; P : Natural; C : Coup; J : Joueur) return Integer is
      Possible_State : Etat;
      V : Integer;
      Eval_Noeud : Integer := 0;
      Coup_Liste : Liste_Coups.Liste := Liste_Coups.Creer_Liste;
      Coup_Iter : Liste_Coups.Iterateur;
      Temp : Coup;
      G : Generator;
   begin
      Possible_State := Etat_Suivant(E, C);
      -- on teste les cas particluiers : J1 ou J2 gagne, match nul
      if Est_Gagnant(Possible_State, J) then
         return 1000; -- 1000 est notre valeur max
      end if;
      if Est_Gagnant(Possible_State, Adversaire(J)) then
         return -1000; -- -1000 est notre valeur min
      end if;
      if Est_Nul(Possible_State) then
         return 0; -- avoir un match nul n'est ni favorable ni défavorable on lui associe la valeur neutre 0
      end if;
      -- on est arrivé à la profondeur P demandée
      if P = 0 then
         return Eval(Possible_State);
      end if;
      -- if maximizing player
      if J = Joueur1 then
         V := -1000; -- initialisation de V au minimum
         -- pour chaque fils de noeuds
         Coup_Liste := Coups_Possibles(Possible_State, J);
         Coup_Iter := Liste_Coups.Creer_Iterateur(Coup_Liste);
         loop
            Temp := Liste_Coups.Element_Courant(Coup_Iter);
            Eval_Noeud := Eval_Min_Max(Possible_State, P - 1, Temp, Joueur2);
            if Eval_Noeud > V then -- si le coup étudié et plus favorable au J1 que le coup en mémoire ( initialisé au coup le moins favorable possible)
               V := Eval_Noeud; -- alors on actualise V avec cette nouvelle valeur, V représente bien la valeur du coup le plus favorable pour J1 avec la récursion
               -- Le_Coup := Temp;
            end if;
            if Eval_Noeud = V then -- si le coup étudié est autant favorable que le coup en mémoire
               Reset(G);
               -- on crée du hasard en démarrant le random generator
               if Random(G) = Tails then
                  V := Eval_Noeud; -- on choisit aléatoirement parmi les 2 coups (pour pas que le joueur virtuel joue toujours la même chose)
               end if;
            end if;
            exit when not Liste_Coups.A_Suivant(Coup_Iter); -- on s'arrète lorsque l'on a tout parcouru
            Liste_Coups.Suivant(Coup_Iter);
         end loop;
         Liste_Coups.Libere_Iterateur(Coup_Iter);
         return V;
      else -- si J = joueur 2
         V := 1000;-- initialisation à la valeur maximale
         Coup_Liste := Coups_Possibles(Possible_State, J);
         Coup_Iter := Liste_Coups.Creer_Iterateur(Coup_Liste);
         loop
            Temp := Liste_Coups.Element_Courant(Coup_Iter);
            Eval_Noeud := Eval_Min_Max(Possible_State, P - 1, Temp, Joueur1);
            if Eval_Noeud < V then -- si le coup étudié est moins favorable au J2 que le coup en mémoire (initialisé au coup le plus favorable)
               V := Eval_Noeud; -- alors on actualise V ,V représente bien la valeur du coup le plus favorable pour J1  avec la récursion
               -- Le_Coup := Temp;
            end if;
            if Eval_Noeud = V then
               Reset(G);
               -- demarre random generator
               if Random(G) = Heads then
                  V := Eval_Noeud;
               end if;
            end if;
            exit when not Liste_Coups.A_Suivant(Coup_Iter); -- lorsque la liste de coups est vide on arrète la récursion
            Liste_Coups.Suivant(Coup_Iter);
         end loop;
         Liste_Coups.Libere_Iterateur(Coup_Iter);
         return V;
      end if;
   end Eval_Min_Max;

end Moteur_Jeu;
