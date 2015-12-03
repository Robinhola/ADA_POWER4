with Participant; use Participant; 
with Liste_Generique;
with puissance4;
with Ada.Text_IO;
with Puissance4;

generic
type Etat is private;
type Coup is private;
-- Profondeur de recherche du coup
hauteur, largeur, victoire : Positive;
max : Integer;

P : Natural;
-- Indique le joueur interprete par le moteur
JoueurMoteur : Joueur;

with procedure Affiche_coup(C : in Coup);
with package Liste_Coups is new Liste_Generique(Coup, Affiche_Coup);
with function Est_Possible(E : Etat; X : Integer; J : Joueur; C : in out Coup) return Boolean;
with function Est_Gagnant(E : Etat; J : Joueur) return Boolean; 

package moteur_puissance4 is
		
	-- Retourne la liste des coups possibles pour J a partir de l'etat 
	function Coups_Possibles(E : Etat; J : Joueur) return Liste_Coups.Liste; 
	-- Evaluation statique du jeu du point de vue de l'ordinateur
	function Eval(E : Etat) return Integer;   
    
end moteur_puissance4;
	