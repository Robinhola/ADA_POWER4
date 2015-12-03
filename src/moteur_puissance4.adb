with puissance4;

package body moteur_puissance4 is
	
	-- Retourne la liste des coups possibles pour J a partir de l'etat 
	function Coups_Possibles(E : Etat; J : Joueur) return Liste_Coups.Liste is
		liste_c : Liste_Coups.Liste;
		C : Coup;
		numJ : Integer;
	begin
		liste_c := Liste_Coups.Creer_Liste;
		if(J = Joueur1) then
			numJ := 1;
		else
			numJ := 2;
		end if;
		
		for I in Integer range 1..LARGEUR+1 loop
			if(Est_Possible(E, I, J, C)) then
				Liste_Coups.Insere_Tete(C, liste_c);
			end if;
		end loop;
		return liste_c;
	end Coups_Possibles;
	
	
	-- Evaluation statique du jeu du point de vue de l'ordinateur
	function Eval(E : Etat) return Integer is
	begin
		if(Est_Gagnant(E, JoueurMoteur)) then
			return Max;
		elsif(Est_Gagnant(E,Adversaire(JoueurMoteur))) then
			return Max;
		end if;
		
		return 0;
	end Eval;  
	 
end moteur_puissance4;