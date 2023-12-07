Class {
	#name : #VistaUsuario,
	#superclass : #'Sistema_UI',
	#instVars : [
		'bienvenida',
		'modalidadMorph',
		'bCambioModalidad',
		'bMostrarBibInteres',
		'pDataSource',
		'pTabla',
		'bRealizarPrestamo',
		'bDevolverPrestamo',
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
VistaUsuario class >> crearConSistema: unSistema usuario: unUsuario [
|vista|
vista := self crearVentanaConAncho:  770 altura: 600 titulo: 'LIBRERÍA NACIONAL I.A'.
vista inicializarConSistema: unSistema usuario: unUsuario.
^vista
]

{ #category : #'as yet unclassified' }
VistaUsuario >> inicializarConSistema: unSistema usuario: unDni [

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

bCambioModalidad := (BotonGenerico_UI new definirAccion: [ usuario := usuario cambiarModalidad: unSistema. usuario addDependent: self. self mensaje: 'Usted ha cambiado su modalidad correctamente.' ]; textoBoton: 'Cambiar modalidad').
self añadirMorph: bCambioModalidad conMargen: 20.

bMostrarBibInteres := (BotonGenerico_UI new definirAccion: [ Ventana_UI crearConMorph: bTabla ]; textoBoton: 'Mostrar mis bibliotecas de interés').
self añadirMorph: bMostrarBibInteres conMargen: 20.

pDataSource := PrestamoDataSource elements: (system getPrestamosDeUsuario: unDni).

pTabla := Tabla_UI crearPConDataSource: pDataSource ancho: 750 altura: 150 .
self añadirMorph: pTabla conMargen: 20.

bRealizarPrestamo := nil.

bDevolverPrestamo := nil.

bCerrarSesion := (BotonGenerico_UI new definirAccion: [ self delete. self vistaPrincipal ]; textoBoton: 'Cerrar sesión').
self añadirMorph: bCerrarSesion conMargen: 20.

self openCenteredInWorld .

^self
]

{ #category : #updating }
VistaUsuario >> update: unUsuario [

plus := plus not.
modalidadMorph contents: ((plus) ifTrue: [ 'Usted es usuario plus.' ] ifFalse: ['Usted es usuario común.']).

]
