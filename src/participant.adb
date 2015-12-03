package body participant is
	
	function Adversaire(J : Joueur) return Joueur is
	erreur : exception;	
	
	begin
		if(J = Joueur1) then 
			return Joueur2;
		elsif (J = Joueur2) then 
			return Joueur1;
		else
			raise erreur;
		end if;
		
	end Adversaire;
	
end participant;