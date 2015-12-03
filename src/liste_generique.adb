with Ada.Unchecked_Deallocation;

package body liste_generique is
	
	type Cellule is record
		val : Element;
		next : Liste;
	end record;
	
	type Iterateur_Interne is record 
		element : Liste;
	end record;
	
	procedure free is new Ada.Unchecked_Deallocation (Cellule, Liste);
	procedure free is new Ada.Unchecked_Deallocation (Iterateur_Interne, Iterateur);
	
	-- Affichage de la liste, dans l'ordre de parcours
	procedure Affiche_Liste (L : in Liste) is
		list : Liste; 
	begin -- 
		list := L;
		while list /= NULL loop
			Put(list.val);
			list := list.next;
		end loop;
	end Affiche_Liste;

	-- Insertion d'un element V en tete de liste
	procedure Insere_Tete (V : in Element; L : in out Liste) is
		tete : Liste;
	begin --
		tete := new Cellule;
		tete.val := V;
		tete.next := L;
		L:= tete;
	end Insere_Tete;
	 
	-- Vide la liste et libere toute la memoire utilisee
	procedure Libere_Liste(L : in out Liste) is
		list , tmp: Liste;
	begin
		list := L;
		while list /= null loop
			tmp := list;
			list := list.next;
			free(tmp);
		end loop;
	end Libere_Liste;
	
	-- Creation de la liste vide
	function Creer_Liste return Liste is
	begin
		return null;
	end Creer_Liste;

	-- Cree un nouvel iterateur 
	function Creer_Iterateur (L : Liste) return Iterateur is
		iter : Iterateur;
	begin
		iter := new Iterateur_Interne; 
		iter.element := L;
		return iter;
	end Creer_Iterateur;

	-- Liberation d'un iterateur
	procedure Libere_Iterateur(It : in out Iterateur) is
	begin
		free(It);
		It := null;
	end Libere_Iterateur;

	-- Avance d'une case dans la liste
	procedure Suivant(It : in out Iterateur) is
	begin
		If(It.element = null) then 
			raise FinDeListe;
		else 
			It.element := It.element.next;
		end if;
	end Suivant;  
			

	-- Retourne l'element courant
	function Element_Courant(It : Iterateur) return Element is  
	begin
		return It.element.val;
	end Element_Courant;

	-- Verifie s'il reste un element a parcourir
	function A_Suivant(It : Iterateur) return Boolean is 
	begin 
		if(It.element = null) then 
	 		raise FinDeListe;
	 		return false;
		elsif (It.element.next = null) then 
			return false;
		else 
			return true;
		end if;
	end A_suivant;
	
end liste_generique;