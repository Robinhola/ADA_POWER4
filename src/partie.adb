with Ada.Text_IO; use Ada.Text_IO;
with participant; use participant;


package body partie is

	-- Joue une parte.
	-- E : EI
	-- J : Joueur qui commence
	procedure Joue_Partie(E : in out Etat; J : in Joueur) is
		joueurCourant : Joueur := J;
		s, a : String(1..8);
		coupJoue : Coup;
	begin -- Joue_Partie
		Affiche_Jeu(E);
		while (Not Est_Gagnant(E, Adversaire(joueurCourant)) And Not Est_Nul(E)) loop 			
			if (joueurCourant = Joueur1) then
				coupJoue := Coup_Joueur1(E);
			else
				coupJoue := Coup_Joueur2(E);
			end if;
			
			Affiche_Coup(coupJoue);
			E := Etat_Suivant(E, coupJoue);
			Affiche_Jeu(E);
			
			joueurCourant := Adversaire(joueurCourant);
		end loop;
		
		if (joueurCourant = Joueur2) then
			s := "Joueur 1";
			a := "Joueur 2"; 
		else
			s := "Joueur 2";
			a := "Joueur 1";
		end if;

		if (Est_Gagnant(E, Adversaire(joueurCourant))) then
			New_line;
			Put(s);
			Put(" a gagné la partie et ");
			Put(a);
			Put(" est perdant !");
		elsif (Est_Nul(E)) then
			Put_line("La partie est nulle");
		else
			Put_line("ERREUR");
		end if;
		
		New_line;
		
	end Joue_Partie;
	
end partie;