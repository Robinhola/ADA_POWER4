with participant; use participant;
with Ada.Text_IO; use Ada.Text_IO;
with puissance4;
with moteur_jeu;
with moteur_puissance4;
with liste_generique;
with partie;

procedure main1joueur is
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
		New_line;
	    Put_Line("Puissance 4");
	    Put_Line("");
	    Put_Line("Joueur 1 : X"); 
	    Put_Line("Joueur 2 : O");
   
		Initialiser(E);
		Joue_Partie(E, Joueur1);
	
end main1joueur;