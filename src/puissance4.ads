with participant; use participant;
with partie;

generic

	LARGEUR : Positive;
	HAUTEUR : Positive;
	VICTOIRE : Positive;
	
package puissance4 is
	
	type matrice is Array(1..LARGEUR, 1..HAUTEUR) of Integer; -- 7 colonnes et 6 lignes, l'origine est le coin en bas à gauche du plateau
	type tableau is Array(1..2) of Integer; -- la première case stocke la position du Coup joué 
											-- et la deuxième case stocke le joueur qui l'a joué							
	type Etat is new matrice;
	type Coup is new tableau;

	Nom1 : String := "Robin";
	Nom2 : String := "Celia";
		
    -- Calcule l'etat suivant en appliquant le coup
	function Etat_Suivant(E : Etat; C : Coup) return Etat;
    -- Indique si l'etat courant est gagnant pour le joueur J
    function Est_Gagnant(E : Etat; J : Joueur) return Boolean; 
    -- Indique si l'etat courant est un status quo (match nul)
    function Est_Nul(E : Etat) return Boolean; 
    -- Fonction d'affichage de l'etat courant du jeu
    procedure Affiche_Jeu(E : Etat);
    -- Affiche a l'ecran le coup passe en parametre
    procedure Affiche_Coup(C : in Coup);   
    -- Retourne le prochaine coup joue par le joueur1
    function Coup_Joueur1(E : Etat) return Coup;
    -- Retourne le prochaine coup joue par le joueur2   
    function Coup_Joueur2(E : Etat) return Coup; 
	
    procedure Initialiser(E : in out Etat);
	
	procedure Est_Possible(E : Etat; X : Integer; J : Joueur; C : in out Coup; Ans : out Boolean);
	
	function Copie_Etat(E : in Etat) return Etat;
							
end puissance4;