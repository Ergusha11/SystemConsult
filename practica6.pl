:- dynamic conocido/1.

main :-
      welcome,
      nl, opciones,
      nl, write('Indica tu opcion: '),
      read(Opcion),
      (
            Opcion = 1 -> consulta, nl, writeln('Gracias por utilizar este programa.');
            Opcion = 2 -> halt
      ).

opciones :-
      writeln('Opciones disponibles:'),
      writeln('1. Consultar recomendacion de carrera'),
      writeln('2. Salir del programa').

welcome :-
      writeln('Bienvenido a nuestra plataforma de orientacion vocacional!'),
      writeln('=================================================================================='),
      writeln('Estoy aqui para ofrecerte recomendaciones basadas en tus intereses y habilidades.'),
      writeln('Sin embargo, ten en cuenta que mis sugerencias deben ser consideradas como tal.'),
      writeln('Te invito a reflexionar sobre ellas y tomar la decision que mejor se adapte a ti.'),
      writeln('Listo para explorar las posibilidades de tu futuro profesional? Comencemos!').

consulta :- limpia_memoria_de_trabajo,
			consultaCarrera(Carrera),
			escribe_recomendacion(Carrera),
			ofrece_explicacion(Carrera).

consulta:-write('No hay suficiente conocimiento para elaborar una respuesta.').

consultaCarrera(Carrera) :- obtenerCarreraEspecificaciones(Carrera, ListEspecificaciones),
					  prueba_presencia_de(Carrera,ListEspecificaciones).

obtenerCarreraEspecificaciones(TipoCarrera, ListEspecificaciones) :- rules(carrera(TipoCarrera),especificaciones(ListEspecificaciones)).

limpia_memoria_de_trabajo:- retractall(conocido(_)).

prueba_presencia_de(_, []).
prueba_presencia_de(Carrera, [Head | Tail]) :-
    prueba_verdad_de(Carrera, Head),
    prueba_presencia_de(Carrera, Tail).

prueba_verdad_de(_, Especificacion) :-
    conocido(Especificacion).
prueba_verdad_de(Carrera, Especificacion) :-
    not(conocido(is_false(Especificacion))),
    pregunta_sobre(Carrera, Especificacion, Respuesta),
    Respuesta = si.

pregunta_sobre(Carrera, Especificacion, Respuesta) :-
    write('¿Cumple con la siguiente especificación para estudiar '), write(Carrera), write('? '),
    write(Especificacion), write('? '),
    read(Reply),
    procesar_respuesta(Especificacion, Reply, Respuesta).

procesar_respuesta(Especificacion, si, si) :-
    asserta(conocido(Especificacion)).
procesar_respuesta(Especificacion, no, no) :-
    asserta(conocido(is_false(Especificacion))).

escribe_recomendacion(Carrera) :-
    write('Una carrera recomendada para ti podría ser '), write(Carrera), write('.'), nl.

ofrece_explicacion(Carrera) :-
    pregunta_si_necesita_explicacion(Respuesta),
    actua_consecuentemente(Carrera, Respuesta).

pregunta_si_necesita_explicacion(Respuesta) :-
    write('¿Deseas saber por qué se recomienda esta carrera? (si/no) '),
    read(RespuestaUsuario),
    asegura_respuesta_si_o_no(RespuestaUsuario, Respuesta).

asegura_respuesta_si_o_no(si, si).
asegura_respuesta_si_o_no(no, no).
asegura_respuesta_si_o_no(_, Respuesta):- write('Debes contestar si o no.'),
pregunta_si_necesita_explicacion(Respuesta).

actua_consecuentemente(_, no).
actua_consecuentemente(Carrera, si) :-
    rules(carrera(Carrera), especificaciones(ListaDeEspecificaciones)),
    writeln('La recomendación se basa en las siguientes cualidades que coinciden contigo:'),
    escribe_lista(ListaDeEspecificaciones).

escribe_lista([]).
escribe_lista([Head | Tail]) :-
    write('- '), writeln(Head),
    escribe_lista(Tail).

rules(carrera('Arquitectura'),
      especificaciones(['Creatividad en el diseño',
                'Interés en el arte y la estética',
                'Habilidad para visualizar espacios tridimensionales',
                'Capacidad para trabajar con diferentes materiales',
                'Conocimiento de normativas de construcción'])).

rules(carrera('Biología'),
      especificaciones(['Interés en la investigación científica',
                'Habilidad para el análisis y la síntesis de datos',
                'Capacidad para trabajar en laboratorio',
                'Interés en la diversidad de la vida',
                'Conocimientos en genética y ecología'])).

rules(carrera('Periodismo'),
      especificaciones(['Habilidad para investigar y entrevistar',
                'Interés en la actualidad y los medios de comunicación',
                'Capacidad para escribir de manera clara y concisa',
                'Empatía y habilidades de comunicación',
                'Curiosidad y capacidad para buscar la verdad'])).

rules(carrera('Nutrición'),
      especificaciones(['Interés en la salud y la alimentación',
                'Habilidad para analizar y planificar dietas',
                'Capacidad para trabajar con personas y comunidades',
                'Conocimiento de bioquímica y fisiología humana',
                'Interés en promover hábitos alimenticios saludables'])).

rules(carrera('Medicina'),
      especificaciones(['Interés en ciencias biológicas',
                'Habilidad para el estudio intensivo',
                'Capacidad para trabajar bajo presión',
                'Empatía y habilidades de comunicación',
                'Interés en ayudar a los demás'])).

rules(carrera('Ingeniería Civil'),
      especificaciones(['Habilidad para resolver problemas',
                'Interés en matemáticas y física',
                'Capacidad para visualizar estructuras',
                'Habilidad para trabajar en equipo',
                'Interés en diseño y construcción'])).

rules(carrera('Psicología'),
      especificaciones(['Empatía y habilidades de escucha',
                'Interés en el comportamiento humano',
                'Capacidad para mantener la confidencialidad',
                'Habilidad para analizar y sintetizar información',
                'Interés en ayudar a otros a superar problemas'])).

rules(carrera('Ciencias de la Computación'),
      especificaciones(['Interés en tecnología y programación',
                'Habilidad para resolver problemas lógicos',
                'Capacidad para aprender nuevos lenguajes de programación',
                'Creatividad en la resolución de problemas',
                'Habilidad para trabajar en equipo'])).

rules(carrera('Derecho'),
      especificaciones(['Habilidad para el razonamiento lógico',
                'Capacidad para analizar y argumentar',
                'Interés en la justicia y los derechos humanos',
                'Habilidad para investigar y presentar casos',
                'Habilidad para comunicarse de manera efectiva'])).

rules(carrera('Administración de Empresas'),
      especificaciones(['Habilidad para tomar decisiones bajo presión',
                'Interés en estrategias de negocios',
                'Capacidad para liderar equipos',
                'Habilidad para analizar datos financieros',
                'Interés en el funcionamiento de las organizaciones'])).
