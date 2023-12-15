Class {
	#name : #VistaUsuario,
	#superclass : #'Sistema_UI',
	#instVars : [
		'bienvenida',
		'modalidadMorph',
		'bCambioModalidad',
		'bPagar',
		'bMostrarBibInteres',
		'pDataSource',
		'pTabla',
		'bRealizarPrestamo',
		'bDevolverPrestamo',
		'bSeleccionarTodos',
		'bAyuda',
		'bDataSource',
		'bTabla',
		'bibliotecas',
		'usuario',
		'plus',
		'bCerrarSesion'
	],
	#category : #'SistemaBiblioteca_GUI'
}

{ #category : #'as yet unclassified' }
VistaUsuario class >> crearConSistema: unSistema usuario: unDni [
|vista|
vista := self crearVentanaConAncho:  770 altura: 600 titulo: 'LIBRERÍA NACIONAL I.A'.
vista inicializarConSistema: unSistema usuario: unDni.
^ vista
]

{ #category : #'as yet unclassified' }
VistaUsuario >> inicializarConSistema: unSistema usuario: unDni [

|prestamosElegidos|

usuario := (unSistema buscarUsuarioConDni: unDni).
usuario addDependent: self.
plus := usuario esPlus .
self asignarSistema: unSistema .

bibliotecas := usuario bibliotecasInteres.

bDataSource := BibliotecaDataSource elements: bibliotecas.
bTabla := Tabla_UI crearBConDataSource: bDataSource ancho: 900 altura: 200.

bienvenida := TextMorph new contents: 'Bienvenido/a ',usuario nombre,'! :)'.
self añadirMorph: bienvenida conMargen: 20.

modalidadMorph := TextMorph new contents: ((usuario esPlus) ifTrue: [ 'Usted es usuario plus.' ] ifFalse: [ 'Usted es usuario común.' ]).

self añadirMorph: modalidadMorph conMargen: 20.

bCambioModalidad := BotonGenerico_UI new textoBoton: 'Cambiar modalidad'; definirAccion: [ |usuarioCambiado| usuarioCambiado := (usuario cambiarModalidad: unSistema). (usuarioCambiado = usuario) ifFalse: [usuario addDependent: self. self mensaje: 'Usted ha cambiado su modalidad correctamente.'] ifTrue: [self error: 'Usted no realizó ningún pago: no puede mejorar su modalidad']].
self añadirMorph: bCambioModalidad conMargen: 20.

bPagar := (BotonGenerico_UI new definirAccion: [ (usuario estaAlDiaConCuota) ifTrue: [ self mensaje: 'Usted ya pagó su cuota anteriormente.' ] ifFalse: [ usuario pagarCuota. self mensaje: 'Usted ha pagado su cuota correctamente.' ] ]; textoBoton: 'Pagar cuota'; color: Color red).
self añadirMorph: bPagar alLadoDe: bCambioModalidad.

bMostrarBibInteres := (BotonGenerico_UI new definirAccion: [ Ventana_UI crearConMorph: bTabla ]; textoBoton: 'Mostrar mis bibliotecas de interés').
self añadirMorph: bMostrarBibInteres conMargen: 20.

pDataSource := PrestamoDataSource elements: (system getPrestamosDeUsuario: unDni).

pTabla := Tabla_UI crearPConDataSource: pDataSource ancho: 750 altura: 150 .
self añadirMorph: pTabla conMargen: 20.

bibliotecas do: [ :b | b addDependent: pDataSource ].

bRealizarPrestamo := (BotonGenerico_UI new textoBoton: 'Realizar préstamo').
bRealizarPrestamo definirAccion: [ self delete. self vistaPrestamo: unDni ].
self añadirMorph: bRealizarPrestamo conMargen: 20.

bDevolverPrestamo := (BotonGenerico_UI new textoBoton: 'Devolver préstamo'; definirAccion: [ prestamosElegidos := (pTabla selectedIndexes) collect: [:i | pDataSource elementAt: i]. prestamosElegidos do: [ :p | system devolverPrestamo: unDni deBib: (p idBiblioteca). ]. self mensaje: 'Tus préstamos han sido devueltos correctamente.' ]).
self añadirMorph: bDevolverPrestamo conMargen: 20.

bSeleccionarTodos := BotonGenerico_UI new textoBoton: 'Seleccionar todos'; definirAccion: [ pTabla selectAll. ].
self añadirMorph: bSeleccionarTodos alLadoDe: bDevolverPrestamo .

bAyuda := BotonGenerico_UI new definirAccion: [bAyuda showBalloon: 'Para devolver muchos préstamos, mantén apretada la tecla Ctrl y selecciona más préstamos :)']; textoBoton: '?'; color: Color blue; extent: 30@30; helpText: 'Para devolver muchos préstamos, mantén apretada la tecla Ctrl y selecciona más préstamos :)'.
self añadirMorph: bAyuda alLadoDe: bSeleccionarTodos.

bCerrarSesion := (BotonGenerico_UI new definirAccion: [ self delete. self vistaPrincipal ]; textoBoton: 'Cerrar sesión').
self añadirMorph: bCerrarSesion conMargen: 20.

self openCenteredInWorld .

(system verificarMulta: unDni) ifNotNil: [ self error: 'Algún préstamo no fue devuelto a tiempo. Se le aplicó una suspensión de ',(system cantDiasMulta) asString, ' días: no podrá realizar préstamos durante ese período.'. bRealizarPrestamo deshabilitar ].
]

{ #category : #updating }
VistaUsuario >> update: unUsuario [

plus := plus not.
modalidadMorph contents: ((plus) ifTrue: [ 'Usted es usuario plus.' ] ifFalse: ['Usted es usuario común.']).

]
