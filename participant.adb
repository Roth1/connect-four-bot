package body Participant is
   
   function Adversaire(J : Joueur) return Joueur is
   begin
      if Joueur = Joueur1 then
	 return Joueur2;
      else 
	 return Joueur1;
      end if;
   end Adversaire;
   
end Participant;
