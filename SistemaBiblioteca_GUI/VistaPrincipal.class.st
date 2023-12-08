Class {
	#name : #VistaPrincipal,
	#superclass : #'Sistema_UI',
	#instVars : [
		'bienvenida',
		'campoDNI',
		'campoPass',
		'bIniciarSesion',
		'bRegistrar'
	],
	#category : #'SistemaBiblioteca_GUI'
}

{ #category : #'as yet unclassified' }
VistaPrincipal class >> crearConSistema: unSistema [
|vista|
vista := self crearVentanaConAncho:  450 altura: 350 titulo: 'LIBRERÍA NACIONAL I.A'.
vista inicializarConSistema: unSistema.
^ vista
]

{ #category : #initialization }
VistaPrincipal >> inicializarConSistema: unSistema [

self asignarSistema: unSistema . 

bienvenida := TextMorph new contents: 'Bienvenido a LIBRERÍAS I.A.! :)'.
self añadirMorph: bienvenida conMargen: 40.

campoDNI := RubTextFieldMorph new extent: 300@20; ghostText: 'Ingrese su DNI'.
self añadirMorph: campoDNI conMargen: 20.

campoPass := RubTextFieldMorph new extent: 300@20; ghostText: 'Ingrese su contraseña'.
self añadirMorph: campoPass conMargen: 20.

bIniciarSesion := (BotonIniciarSesion_UI new inicializarConSistema: self campoDNI: campoDNI campoPass: campoPass ).
self añadirMorph: bIniciarSesion conMargen: 20.

bRegistrar := (BotonRegistrar_UI new inicializarConSistema: self).
self añadirMorph: bRegistrar conMargen: 20.

self openCenteredInWorld .

]
