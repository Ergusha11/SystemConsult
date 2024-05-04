:- dynamic satisface/2.

main :- repeat,bienvenida,
      nl,write('Menu'),nl,
      nl,write('1 Consulta el sistema experto'),
      nl,write('2 Salir'),
      nl,nl,write('Indica tu opcion:'),read(Opcion),
	  (
		  (Opcion=1,consulta,fail);
		  (Opcion=2,writeln('Gracias por usar el modelo'),halt)
	  ).


bienvenida :- writeln('==============================================='),
			  writeln('Bienvenido al sistema de consulta para elegir tu carrera'),
              writeln('Puedo hacer un diagnóstico dependiendo de tus gustos'),
			  writeln('Solo soy un sistema de consulta'),
              writeln('"NO ELIJA SU CARRERA A BASE DE ESTE MODELO"'),
              writeln('===============================================').

consulta :- borraResp,
			Caracteristicas = ['interesado_en_tecnologia', 'interesado_en_artes', 'interesado_en_sociales', 'interesado_en_salud'],
			maplist(preguntar, Caracteristicas).

preguntar(Caracteristica) :- \+ satisface(Caracteristica, _),
							 \+ satisface(no, Caracteristica),
							 format('¿Satisfaces la característica: ~w? (si/no) ', [Caracteristica]),
							 read(Respuesta),
							(   
								Respuesta = si -> 
								assertz(satisface(Caracteristica,si));  
								assertz(satisface(Caracteristica,no))
							).


borraResp :-
    retractall(satisface(_, _)),
    retractall(satisface(no, _)).

ciencias_tecnologia(X) :- satisface('interesado_en_tecnologia', X).
humanidades_arte(X) :- satisface('interesado_en_artes', X).
ciencias_sociales(X) :- satisface('interesado_en_sociales', X).
ciencias_salud(X) :- satisface('interesado_en_salud', X).

medicina(X) :-
    ciencias_salud(X),
    satisface('quiere_ayudar_a_personas', X),
    satisface('puede_estudiar_mucho', X).


