with participant; use participant;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO;
with puissance4;
with moteur_jeu;
with moteur_puissance4;
with liste_generique;
with partie;



procedure tests is
	
	procedure test_Participant is
		j1,j2 : Joueur;
	begin -- testParticipant
		j1 := Joueur1;
		j2 := Joueur2;
	
		Put_line("Procedure de test de participant :");
		New_line;
		Put_line("test Joueur 1 (attendu OK)");

		if(j2 = Adversaire(j1)) then 
			Put_line("Ok");
		else 
			Put_line("NON OK");
		end if; 
	
		New_line;
		Put_line("test Joueur 2 (attendu OK)");

		if(j1 = Adversaire(j2)) then 
			Put_line("Ok");
		else 
			Put_line("NON OK");
		end if; 
		
		New_line;
		Put_line("test Joueur 1 (attendu NON OK)");

		if(j1 = Adversaire(j1)) then 
			Put_line("Ok");
		else 
			Put_line("NON OK");
		end if; 
		
		New_line;
		Put_line("test Joueur 2 (attendu NON OK)");

		if(j2 = Adversaire(j2)) then 
			Put_line("Ok");
		else 
			Put_line("NON OK");
		end if; 
		New_line;
		
	end test_Participant;
	
	procedure test_Partie is
		
	    package MyPuissance4 is new Puissance4(7,6,4);
	    use MyPuissance4;
		
   
	       -- definition d'une partie entre L'ordinateur en Joueur 1 et un humain en Joueur 2
	    package MyPartie is new Partie(MyPuissance4.Etat,
	 				  MyPuissance4.Coup, 
	 				  "Pierre",
	 				  "Paul",
	 				  Etat_Suivant,
	 				  MyPuissance4.Est_Gagnant,
	 				  MyPuissance4.Est_Nul,
	 				  MyPuissance4.Affiche_Jeu,
	 				  MyPuissance4.Affiche_Coup,
	 				  MyPuissance4.Coup_Joueur1,
	 				  MyPuissance4.Coup_Joueur2);
	    use MyPartie;
		
		E : MyPuissance4.Etat;
   
		begin -- testPartie

			Initialiser(E);
			Joue_Partie(E, Joueur1);
		
	end test_Partie;
	
	
	procedure test_Moteur is
		hauteur : Positive := 7;
		largeur : Positive := 6;
		victoire : Positive := 4;
		profondeur : Positive :=5;
		
	    package MyPuissance4 is new Puissance4(hauteur, largeur, victoire);
	    use MyPuissance4;
		
		package Liste_Coups is new Liste_Generique(Coup, Affiche_Coup);
		use Liste_Coups;
		
		package MyMoteurP4 is new Moteur_puissance4(MyPuissance4.Etat,
													MyPuissance4.Coup,
													hauteur,
													largeur,
													victoire,
													100,
													profondeur,
													Joueur2,
													MyPuissance4.Affiche_Coup,
													Liste_Coups,
													MyPuissance4.Est_Possible,
													MyPuissance4.Est_Gagnant);
													
		package MyMoteur is new Moteur_jeu( MyPuissance4.Etat,
											MyPuissance4.Coup,
											100,
											MyPuissance4.Etat_Suivant,
											MyPuissance4.Est_Gagnant,
											MyPuissance4.Est_Nul,
											MyPuissance4.Affiche_Coup,
											Liste_Coups,
											MyMoteurP4.Coups_Possibles,
											MyMoteurP4.Eval,
											profondeur,
											Joueur2,
											MyPuissance4.Copie_Etat);

	       -- definition d'une partie entre L'ordinateur en Joueur 1 et un humain en Joueur 2
	    package MyPartie is new Partie(MyPuissance4.Etat,
	 				  MyPuissance4.Coup, 
	 				  "Pierre",
	 				  "Paul",
	 				  Etat_Suivant,
	 				  MyPuissance4.Est_Gagnant,
	 				  MyPuissance4.Est_Nul,
	 				  MyPuissance4.Affiche_Jeu,
	 				  MyPuissance4.Affiche_Coup,
	 				  MyPuissance4.Coup_Joueur1,
	 				  MyMoteur.Choix_Coup);
	    use MyPartie;
		
		E : MyPuissance4.Etat;
   
		begin -- testPartie

			Initialiser(E);
			Joue_Partie(E, Joueur1);
		
	end test_Moteur;

	choix: Integer := 0;

begin -- tests
	<<debut>>
	New_line;
	Put_line("Procedure de tests : entrer un nombre entre 1 et 4");
	New_Line;
	Put_Line("1) testParticipant");
	Put_Line("2) test_partie");
	Put_line("3) test_moteur");
	Put_line("4) Quitter");
	New_line;
	<<DEMANDE>>
	Ada.Integer_Text_IO.Get(choix);
	while (choix<= 0 Or choix > 4) loop
		Put_line("Hors champ !");
		Ada.Integer_Text_IO.Get(choix);
	end loop;
	
	case choix is
		when 1 =>
			test_Participant;
		when 2 =>
			test_partie;
		when 3 =>
			test_Moteur;
		when 4 =>
			goto fin;
		when others =>
		goto debut;
	end case;
	
	goto debut;

	<<fin>>
	
end tests;
