Pour compiler :

	gnatmake ./src/tests ./src/main1joueur ./src/main2joueurs -D ./bin/ 

Pour debugger  :

	gnatmake ./src/tests -D ./bin/ -g

puis 

	gdb tests

END;