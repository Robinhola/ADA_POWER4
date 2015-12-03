with Ada.Integer_Text_IO;
with Ada.Numerics.Discrete_Random;
package body moteur_jeu is
	
    -- Choix du prochain coup par l'ordinateur. 
    -- E : l'etat actuel du jeu;
    -- P : profondeur a laquelle la selection doit s'effetuer
    function Choix_Coup(E : Etat) return Coup is
		l_coups_possibles : Liste;
		Ite : Iterateur;
		C, coup_suiv : Coup;
		gain, nouv_gain : Integer := -(max + 1);
		
	begin
		declare
		   type Rand_Range is range 0..2;
		   package Rand_Int is new Ada.Numerics.Discrete_Random(Rand_Range);
		   seed : Rand_Int.Generator;
		   Num : Rand_Range;
	   begin
		
		l_coups_possibles := Coups_Possibles(E, JoueurMoteur);
		Ite := Creer_Iterateur(l_coups_possibles);
		C := Element_Courant(Ite);
--		Affiche_liste(l_coups_possibles);
		gain := Eval_Min_Max(E, P, C, JoueurMoteur);
		
	    Rand_Int.Reset(seed);
	    Num := Rand_Int.Random(seed);
--		Ada.Integer_Text_IO.Put(gain);
		
		while(A_suivant(Ite) and gain /= max) loop
			Suivant(Ite);
			coup_suiv := Element_Courant(Ite);
			nouv_gain := Eval_Min_Max(E, P, coup_suiv, JoueurMoteur);
--			Ada.Integer_Text_Io.Put(nouv_gain);
			if(nouv_gain > gain) then
				gain := nouv_gain;
				C := coup_suiv;
			elsif (nouv_gain = gain) then 
				Num := Rand_Int.Random(seed);
				if(Num = 1) then
					gain := nouv_gain;
					C := coup_suiv;
				end if;
			end if;		
		end loop;
		Libere_Iterateur(Ite);
		Libere_Liste(l_coups_possibles);
		return C;
	end;
	end Choix_Coup;
	
    function Eval_Min_Max(E : Etat; P : Natural; C : Coup; J : Joueur) return Integer is
		Efutur : Etat;
		Cfutur : Coup;
		l_coups_possibles : Liste;
		cout_max : Integer;
		cout_min : Integer;
		Ite : Iterateur;
	begin
		Efutur := Etat_suivant(E, C);

		if(P = 0 Or Est_Gagnant(E,J) or Est_nul(E)) then
			if(J=joueurmoteur) then
				return eval(E) + P;
			else
				return -(eval(E) + P);
			end if;
		end if;
		
		l_coups_possibles := Coups_Possibles(Efutur, Adversaire(J));
		Ite := Creer_Iterateur(l_coups_possibles);
		
		-- retourner le meilleur coup
		if(J = Joueurmoteur) then
			--retourne le minimum car ce sera a non l'ordi de jouer
			Cfutur := Element_Courant(Ite);
			cout_min := Eval_Min_Max(Efutur, P-1, Cfutur,Adversaire(J));
			while (A_Suivant(Ite)) loop
				Suivant(Ite);
				Cfutur := Element_Courant(Ite);
 				cout_min := Integer'Min(cout_min, Eval_Min_Max(Efutur, P-1, Cfutur,Adversaire(J)));
			end loop;
			Libere_liste(l_coups_possibles);
			return cout_min;
		else
			-- retourne le max car ce sera à l'ordi de jouer
			Cfutur := Element_Courant(Ite);
			cout_max := Eval_Min_Max(Efutur, P-1, Cfutur,Adversaire(J));
			while (A_Suivant(Ite)) loop
				Suivant(Ite);
				Cfutur := Element_Courant(Ite);
 				cout_max := Integer'Max(cout_max, Eval_Min_Max(Efutur, P-1, Cfutur,Adversaire(J)));
			end loop;
			Libere_liste(l_coups_possibles);
			return cout_max; 
		end if;
		
	end Eval_Min_Max;
	
end moteur_jeu;