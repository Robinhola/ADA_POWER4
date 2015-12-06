with Ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;
with partie;


package body puissance4 is
	erreur : exception;
	
	-- Initialise le jeu
	procedure Initialiser(E : in out Etat) is
	begin -- Intialiser
		
		-- Assigne toutes les cases à 0
		for X in Integer range 1 .. LARGEUR loop
			for Y in Integer range 1..HAUTEUR loop
				E(X,Y) := 0;
			end loop;
		end loop;
		
	end Initialiser;
	
	
    -- Calcule l'etat suivant en appliquantCoup le coup
	function Etat_Suivant(E : Etat; C : Coup) return Etat is
		E_futur : Etat;
		I : Integer := HAUTEUR - 1;
		pos, joueur : Integer;
	begin -- Etat_suivant(E : Etat; C : Coup)

		E_futur := Copie_Etat(E);

		-- Placement impossible
		pos := C(1);
		joueur := C(2);
		
		if (E_futur(pos, HAUTEUR) /= 0) then
			raise erreur;
		end if;
		
		-- descente de la piece
		while(I > 1 And E_futur(pos,I) = 0) loop
			I := I - 1;
		end loop;
		
		-- verification du dernier rang
		if (I=1 And E_futur(pos, 1) = 0) then
			I := 0;
		end if;
		
		-- placement de la piece
		E_futur(pos,I+1) := joueur;
		return E_futur;
		
	end Etat_suivant;
	
	function verif_ligne(E : Etat; numJoueur : Integer; Y : Integer) return Boolean is
		somme : Natural := 0;
	begin
		for I in Integer range 1..LARGEUR loop
			exit when somme = victoire;
			if(E(I,Y) = numJoueur) then
				somme := somme + 1;
			else
				somme :=0;
			end if;
		end loop;
		return somme = victoire;
	end verif_ligne;
	
	function verif_colonne(E : Etat; numJoueur : Integer; X : Integer) return Boolean is
		somme : Natural := 0;
	begin
		for I in Integer range 1..HAUTEUR loop
			exit when somme = victoire;
			if(E(X,I) = numJoueur) then
				somme := somme + 1;
			else
				somme :=0;
			end if;
		end loop;
		return somme = victoire;
	end verif_colonne;
	
	function verif_diag_droite(E : Etat; numJoueur : Integer; X,Y : Integer) return Boolean is
		somme : Natural := 0;
	begin
		for I in Integer range 0.. HAUTEUR + LARGEUR loop
			exit when somme = victoire or X + I > LARGEUR Or Y + I > HAUTEUR;
			if(E(X + I,Y + I) = numJoueur) then
				somme := somme + 1;
			else
				somme :=0;
			end if;
		end loop;
		return somme = victoire;
	end verif_diag_droite;
		
	function verif_diag_gauche(E : Etat; numJoueur : Integer; X,Y : Integer) return Boolean is
			somme : Natural := 0;
		begin
			for I in Integer range 0..HAUTEUR+LARGEUR loop
				exit when somme = victoire or X - I < 1 Or Y + I > HAUTEUR;
				if(E(X - I,Y + I) = numJoueur) then
					somme := somme + 1;
				else
					somme :=0;
				end if;
			end loop;
			return somme = victoire;
		end verif_diag_gauche;
		
	
	
    -- Indique si l'etat courant est gagnant pour le joueur J
    function Est_Gagnant(E : Etat; J : Joueur) return Boolean is
		numJoueur, X, Y : Integer := 0; 
	begin -- E etat et J joueur
		
		-- Selection des joueurs
		if(J = Joueur1) then
			numJoueur := 1;
		else
			numJoueur := 2;
		end if;
		
		-- veriff des lignes
		for Y in Integer range 1..HAUTEUR loop
			if(verif_ligne(E,numJoueur,Y)) then
				goto fin;
			end if;
		end loop;
		
		-- veriff des colonnes
		for X in Integer range 1..LARGEUR loop
			if(verif_colonne(E,numJoueur,X)) then
				goto fin;
			end if;
		end loop;
		
		-- verrif des diag droite
		for X in Integer range 1.. LARGEUR - (VICTOIRE - 1) loop
			if(verif_diag_droite(E,numJoueur,X,1)) then
				goto fin;
			end if;
		end loop;
		
		for Y in Integer range 2.. HAUTEUR - (VICTOIRE-1) loop
			if(verif_diag_droite(E,numJoueur,1,Y)) then
				goto fin;
			end if;
		end loop;
		
		-- verrif des diag gauche
		for X in Integer range VICTOIRE..LARGEUR loop
			if(verif_diag_gauche(E,numJoueur,X,1)) then
				goto fin;
			end if;
		end loop;
		
		for Y in Integer range 2..HAUTEUR- (Victoire -1) loop
			if(verif_diag_gauche(E,numJoueur,LARGEUR,Y)) then
				goto fin;
			end if;
		end loop;
		
		return false;
		
		<<fin>>
		return true;
		
	end Est_Gagnant;
		
		
    -- Indique si l'etat courant est un status quo (match nul)
    function Est_Nul(E : Etat) return Boolean is
		i : Integer := 1;
	begin -- E Etat
		-- on regarde si le dernier rang est plein ************************* Amélioration possible
		while (i <= LARGEUR) loop
			if(E(i,HAUTEUR) = 0) then
				return false;
			end if;
			i := i + 1;
		end loop;	
		return true;
	end Est_Nul;
	 
	 
    -- Fonction d'affichage de l'etat courant du jeu
    procedure Affiche_Jeu(E : Etat) is
		x, y : Positive;
		val, ind: Integer;
	begin
		New_line;
		Put_line("Affichage du plateau :");
		y := HAUTEUR;
		while (y > 1) loop
			x := 1;
			New_line;
			while (x <= LARGEUR) loop
				val := E(x,y);
				Put("|");
				case val is
					when 0 =>
					Put(" ");
					when 1 =>
					Put("X");
					when 2 =>
					Put("O");
					when others =>
					raise erreur;
				end case;
				if (x = largeur) then
					Put("|");
				end if;
				x := x + 1;
			end loop;
			y := y - 1;
		end loop;
		y := 1;
		x := 1;
		New_line;
		while (x <= LARGEUR) loop
			val := E(x,y);
			Put("|");
			case val is
				when 0 =>
				Put(" ");
				when 1 =>
				Put("X");
				when 2 =>
				Put("O");
				when others =>
				raise erreur;
			end case;
			if (x = largeur) then
				Put("|");
			end if;
			x := x + 1;
		end loop;
		New_Line;
		ind := 1;
		for I in Character range '1'..'9' loop
			exit when ind > LARGEUR;
			ind := ind + 1;
			Put("|" & I);
		end loop;
		Put("|");
	end Affiche_Jeu;
	
    -- Affiche a l'ecran le coup passe en parametre
    procedure Affiche_Coup(C : in Coup) is
		joueur : String(1..8);
		pos : Integer := C(1);
	begin
		if(C(2) = 1) then
			joueur := "joueur 1";
		else
			joueur := "joueur 2";
		end if;
		New_line;
		Put(joueur & " joue en position :");
		Ada.Integer_Text_IO.Put(pos);
	end Affiche_Coup;   
    -- Retourne le prochaine coup joue par le joueur1
    function Coup_Joueur1(E : Etat) return Coup is
		colonne : Integer := 0;
		C : Coup;
	begin
		New_line;
		Put_line("Joueur 1 veuillez jouer");
		New_line;
		<<DEMANDE>>
		Ada.Integer_Text_IO.Get(colonne);
		while (colonne <= 0 Or colonne > LARGEUR) loop
			Put_line("Hors champ !");
			Ada.Integer_Text_IO.Get(colonne);
		end loop;
		
		if(E(colonne, HAUTEUR) /= 0) then
			Put_Line("Colonne pleine, veuillez reessayer !");
			colonne := 0;
			goto DEMANDE;
		end if;
		C(1) := colonne;
		C(2) := 1;
		return C;
	end Coup_Joueur1;
	
    -- Retourne le prochaine coup joue par le joueur2   
    function Coup_Joueur2(E : Etat) return Coup is
		colonne : Integer := 0;
		C : Coup;
	begin
		New_line;
		Put_line("Joueur 2 veuillez jouer");
		New_line;
		<<DEMANDE>>
		Ada.Integer_Text_IO.Get(colonne);
		while (colonne <= 0 Or colonne > LARGEUR) loop
			Put_line("Hors champ !");
			Ada.Integer_Text_IO.Get(colonne);
		end loop;
		
		if(E(colonne, HAUTEUR) /= 0) then
			Put_Line("Colonne pleine, veuillez reessayer !");
			colonne := 0;
			goto DEMANDE;
		end if;
		
		C(1) := colonne;
		C(2) := 2;
		return C;
	end Coup_Joueur2;
		
	procedure Est_Possible(E : Etat; X : Integer; J : Joueur; C : in out Coup; Ans : out Boolean) is
		nouv_Coup : Coup;
		joueur_actuel : Integer;
	begin
		if(J = Joueur1) then
			joueur_actuel := 1;
		else
			joueur_actuel := 2;
		end if;
		
		if(E(X,HAUTEUR) = 0) then
			nouv_Coup(1) := X;
			nouv_Coup(2) := joueur_actuel;
			C := nouv_Coup;
			Ans := true;
		else
			Ans := false;
		end if; 
		
	end Est_Possible;
		
	function Copie_Etat(E : in Etat) return Etat is
		nE : Etat;
	begin -- Copie_Etat
		for X in Integer range 1 .. LARGEUR loop
			for Y in Integer range 1..HAUTEUR loop
				nE(X,Y) := E(X,Y);
			end loop;
		end loop;
		return nE;
	end Copie_Etat;
	
end puissance4;