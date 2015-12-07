-- liste_generique.adb
---------------------------------------------------------------

with Ada.Text_Io;
use Ada.Text_Io;
with Ada.Unchecked_Deallocation;

package body Liste_Generique is

   procedure Libere is new Ada.Unchecked_Deallocation (Cellule, Liste);

   -- Affichage de la liste, dans l'ordre de parcours // cf cours listes génériques
   procedure Affiche_Liste (L : in Liste) is
      Cour : Liste := L;
   begin
      while Cour /= null loop
         Put(Cour.Val);
         Put("");
         Cour := Cour.Suiv;
      end loop;
      New_Line;
   end Affiche_Liste;

   -- Insertion d'un element V en tete de liste // cf cours
   procedure Insere_Tete (V : in Element; L : in out Liste) is
   begin
      L:= new Cellule'(V,L);
   end Insere_Tete;

    -- Vide la liste et libere toute la memoire utilisee // cf cours
   procedure Libere_Liste(L : in out Liste) is
      Tmp : Liste;
   begin
      while L/= null loop
         Tmp :=L;
         L:=L.Suiv;
         Libere(Tmp);
      end loop;
   end Libere_Liste;

   -- Creation de la liste vide // cf cours
   function Creer_Liste return Liste is
   begin
      return null;
   end Creer_Liste;


   -- Cree un nouvel iterateur
   function Creer_Iterateur (L : Liste) return Iterateur is
      It : Iterateur;
   begin
      if L/=null then It := new Iterateur_Interne'(L,L.Suiv);
      else Put_Line("la liste est vide, aucun itérateur n'a été créé");
      It := new Iterateur_Interne'(null,null);
      end if;
      return It;
   end Creer_Iterateur;

   -- Liberation d'un iterateur
   procedure Libere_Iterateur(It : in out Iterateur) is
   begin
      Libere_Liste(It.Cour);
      Libere_Liste(It.Suiv);
   end Libere_Iterateur;

   -- Avance d'une case dans la liste
   procedure Suivant(It : in out Iterateur) is
   begin
      It.Cour:= It.Suiv;
      It.Suiv:=It.Suiv.Suiv;
   end Suivant;

   -- Retourne l'element courant
   function Element_Courant(It : Iterateur) return Element is
   begin
      if It.Cour = null then Put_Line ("it.cour = null"); -- si l'élément est null on ne peut rien retourner
      raise Constraint_Error; -- on lève donc une execption
      else
         return It.Cour.Val;
      end if;
   end Element_Courant;

   -- Verifie s'il reste un element a parcourir
   function A_Suivant(It : Iterateur) return Boolean is -- return true s'il reste un element à parcourir
   begin
      if It.Suiv /= null then return True;
      else return False;
      end if;
   end A_Suivant;

end Liste_Generique;
