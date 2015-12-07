with Participant; use Participant;
with Liste_Generique;
with Ada.Text_IO;
with Ada.Numerics.Discrete_Random;

package body Moteur_Jeu is

   -- fonction pour choisir un coup
   function Choix_Coup(E: Etat) return Coup is
      V : Integer := -10000; -- initialisation à une valeur représentant -infinie
      Eval_Noeud : Integer; -- la valeur evaluée d'un noeud
      Coup_Liste : Liste_Coups.Liste := Liste_Coups.Creer_Liste; -- liste des coups possibles
      Coup_Iter : Liste_Coups.Iterateur; -- itérateur sur cette liste
      Temp : Coup; -- un coup temporel
      Le_Coup : Coup; -- le coup qu'on va retourner
      G : Generator; -- le générateur pour ramdomiser le choix du coup
   begin
      -- le joueur virtuel est toujours le Joueur1
      Coup_Liste := Coups_Possibles(E, Joueur1); -- crée la liste de coups possibles 
      Coup_Iter := Liste_Coups.Creer_Iterateur(Coup_Liste); -- crée itérateur sur cette liste
      loop
         Temp := Liste_Coups.Element_Courant(Coup_Iter); -- get un élément
         Eval_Noeud := Eval_Min_Max(E, P - 1, Temp, Joueur2); -- evalue ce noeud / changement de Joueur <- le joueur humain effectura le coup après
         if Eval_Noeud > V then -- si le coup étudié est plus favorable au J1 que le coup est gardé en mémoire
           V := Eval_Noeud; -- alors, on actualise la valeur de V, V représente la valeur max, i.e. la valeur associée au coup le plus favorable
           Le_Coup := Temp; -- et on actualise la valeur du coup que l'on va choisir à la fin de la fonction
         end if;
         -- on introduit du hasard pour que le joueur virtuel "change ses habitudes"
         if Eval_Noeud = V then -- si le coup étudié est autant favorable que le coup en mémoire
               Reset(G);
               -- démarre le générateur aléatoire: Tails ou Heads
               if Random(G) = Heads then
                  Le_Coup  := Temp; -- si la pièce est Heads, prend ce coup
               end if;
         end if;
         exit when not Liste_Coups.A_Suivant(Coup_Iter); -- lorsque l'on a parcouru tout les coups
         Liste_Coups.Suivant(Coup_Iter); -- on parcours le coup suivant
      end loop; -- et on s'arrète
      Liste_Coups.Libere_Iterateur(Coup_Iter); -- libère l'itérateur
      --Liste_Coups.Libere_Liste(Coup_Liste); -- libère la liste
      return Le_Coup;
   end Choix_Coup;

   -- fonction récursive
   function Eval_Min_Max(E : Etat; P : Natural; C : Coup; J : Joueur) return Integer is
      Possible_State : Etat; -- un état suivant possible
      V : Integer; -- valeur d'evaluation qu'on va retourner
      Eval_Noeud : Integer; -- valeur 'evaluation d'un noeud particulier
      Coup_Liste : Liste_Coups.Liste := Liste_Coups.Creer_Liste; -- une liste de coups possibles
      Coup_Iter : Liste_Coups.Iterateur; -- un itérateur sur cette liste
      Temp : Coup; -- un coup temporel pour être capable d'evaluer
   begin
      -- on effectue le coup donné dans les paramètres
      Possible_State := Etat_Suivant(E, C);
      -- on teste les cas particluiers : J1 ou J2 gagne, match nul
      if Est_Gagnant(Possible_State, J) then
         return 10000; -- 10000 est notre valeur max
      end if;
      if Est_Gagnant(Possible_State, Adversaire(J)) then
         return -10000; -- -10000 est notre valeur min
      end if;
      if Est_Nul(Possible_State) then
         return 0; -- avoir un match nul n'est ni favorable ni défavorable on lui associe la valeur neutre 0
      end if;
      -- on est arrivé à la profondeur P demandée
      if P = 0 then
	 -- evalue la situation
         return Eval(Possible_State);
      end if;
      -- if maximizing player
      if J = Joueur1 then
         V := -10000; -- initialisation à une valeur représentant -infinie
         -- pour chaque fils
         Coup_Liste := Coups_Possibles(Possible_State, J); -- crée la liste de coups possibles 
         Coup_Iter := Liste_Coups.Creer_Iterateur(Coup_Liste); -- crée itérateur sur cette liste
         loop
            Temp := Liste_Coups.Element_Courant(Coup_Iter); -- le coup courant
            Eval_Noeud := Eval_Min_Max(Possible_State, P - 1, Temp, Joueur2); -- appel récursif un niveau plus bas
            if Eval_Noeud > V then -- si le coup étudié et plus favorable au J1 que le coup en mémoire (initialisé au coup le moins favorable possible)
               V := Eval_Noeud; -- alors on actualise V avec cette nouvelle valeur, V représente bien la valeur du coup le plus favorable pour J1 avec la récursion
            end if;
            exit when not Liste_Coups.A_Suivant(Coup_Iter); -- on s'arrète lorsque l'on a tout parcouru
            Liste_Coups.Suivant(Coup_Iter);
         end loop;
	 Liste_Coups.Libere_Iterateur(Coup_Iter); -- libère l'itérateur
	 --Liste_Coups.Libere_Liste(Coup_Liste); -- libère la liste
         return V;
      else -- si J = joueur 2
         V := 10000; -- à une valeur représentant +infinie
	 -- pour chaque fils
         Coup_Liste := Coups_Possibles(Possible_State, J); -- crée la liste de coups possibles 
         Coup_Iter := Liste_Coups.Creer_Iterateur(Coup_Liste); -- crée itérateur sur cette liste
         loop
            Temp := Liste_Coups.Element_Courant(Coup_Iter); --le coup courant
            Eval_Noeud := Eval_Min_Max(Possible_State, P - 1, Temp, Joueur1); -- appel récursif un niveau plus bas
            if Eval_Noeud < V then -- si le coup étudié est moins favorable au J1 que le coup en mémoire (initialisé au coup le plus favorable)
               V := Eval_Noeud; -- alors on actualise V ,V représente bien la valeur du coup le plus favorable pour J2  avec la récursion
            end if;
            exit when not Liste_Coups.A_Suivant(Coup_Iter); -- lorsque la liste de coups est vide on arrète la récursion
            Liste_Coups.Suivant(Coup_Iter); -- on parcours le coup suivant
         end loop;
	 Liste_Coups.Libere_Iterateur(Coup_Iter); -- libère l'itérateur
	 --Liste_Coups.Libere_Liste(Coup_Liste); -- libère la liste
         return V;
      end if;
   end Eval_Min_Max;

end Moteur_Jeu;
