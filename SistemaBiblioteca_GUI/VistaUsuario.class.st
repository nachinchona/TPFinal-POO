Class {
	#name : #VistaUsuario,
	#superclass : #'Sistema_UI',
	#instVars : [
		'bienvenida',
		'modalidadMorph',
		'bCambioModalidad'
	],
	#category : #'SistemaBiblioteca_GUI'
}

{ #category : #'as yet unclassified' }
VistaUsuario class >> crearConSistema: unSistema usuario: unUsuario [
|vista|
vista := self crearVentanaConAncho:  450 altura: 350 titulo: 'LIBRERÍA NACIONAL I.A'.
vista inicializarConSistema: unSistema usuario: unUsuario.
^vista
]

{ #category : #'as yet unclassified' }
VistaUsuario >> inicializarConSistema: unSistema usuario: unUsuario [

unUsuario addDependent: self.
self asignarSistema: unSistema .

bienvenida := TextMorph new contents: 'Bienvenido/a ',unUsuario nombre,'! :)'.
self añadirBoton: bienvenida conMargen: 20.

modalidadMorph := TextMorph new contents: (((system buscarUsuarioConDni: (unUsuario dni)) esPlus) ifTrue: [ 'Usted es usuario plus.' ] ifFalse: ['Usted es usuario común.']).

self añadirBoton: modalidadMorph conMargen: 20.

bCambioModalidad := (BotonGenerico_UI new inicializarConSistema: system label: 'Cambiar modalidad').
bCambioModalidad definirAccion: [ (unUsuario cambiarModalidad: system) ifTrue: [ self mensaje: 'Usted ha cambiado su modalidad correctamente.' ] .].
self añadirBoton: bCambioModalidad conMargen: 20.

self openCenteredInWorld .

^self
]

{ #category : #updating }
VistaUsuario >> update: unUsuario [
modalidadMorph contents: (((system buscarUsuarioConDni: (unUsuario dni)) esPlus) ifTrue: [ 'Usted es usuario plus.' ] ifFalse: ['Usted es usuario común.']).
]
