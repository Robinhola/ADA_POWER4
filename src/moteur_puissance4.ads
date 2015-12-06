with Participant; use Participant; 
with Liste_Generique;
with puissance4;
with Ada.Text_IO;
with Puissance4;

generic
	type Etat is private;
	type Coup is private;
	-- Paramètres du puissance4
	hauteur, largeur, victoire : Positive;
	-- cout d'une victoire dans eval
	max : Integer;
	-- Profondeur pour MinMax
	P : Natural;
	-- Indique le joueur interprete par le moteur
	JoueurMoteur : Joueur;
	-- Affiche un coup joué
	with procedure Affiche_coup(C : in Coup);
	-- package liste_coups
	with package Liste_Coups is new Liste_Generique(Coup, Affiche_Coup);
	-- Indique si un coup est possible dans telle ou telle colonne 
	-- et crée le coup en question
	with Procedure Est_Possible(E : Etat; X : Integer; J : Joueur; C : in out Coup; Ans : out Boolean);
	-- indique la victoire d'un joueur J
	with function Est_Gagnant(E : Etat; J : Joueur) return Boolean; 

package moteur_puissance4 is
		
	-- Retourne la liste des coups possibles pour J a partir de l'etat 
	function Coups_Possibles(E : Etat; J : Joueur) return Liste_Coups.Liste; 
	-- Evaluation statique du jeu du point de vue de l'ordinateur
	function Eval(E : Etat) return Integer;   
    
end moteur_puissance4;
	