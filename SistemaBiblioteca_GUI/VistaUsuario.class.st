Class {
	#name : #VistaUsuario,
	#superclass : #'Sistema_UI',
	#instVars : [
		'bienvenida',
		'modalidadMorph',
		'bCambioModalidad',
		'bMostrarBibInteres',
		'listaBibModel',
		'listaBib',
		'bibliotecas',
		'usuario',
		'plus'
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
VistaUsuario >> inicializarConSistema: unSistema usuario: unDni [

usuario := (unSistema buscarUsuarioConDni: unDni).
usuario addDependent: self.
plus := usuario esPlus .
self asignarSistema: unSistema .

bibliotecas := Dictionary new.
(usuario bibliotecasInteres) do: [ :b | bibliotecas at: b nombre put: b ].
listaBibModel := MorphTreeModel new rootItems: (bibliotecas keys).
listaBibModel autoMultiSelection: true; headerLabel: 'Tus bibliotecas'.
listaBib := listaBibModel defaultTreeMorph buildContents; vResizing: #spaceFill; hResizing:#spaceFill; extent: 370@120.

bienvenida := TextMorph new contents: 'Bienvenido/a ',usuario nombre,'! :)'.
self añadirBoton: bienvenida conMargen: 20.

modalidadMorph := TextMorph new contents: ((usuario esPlus) ifTrue: [ 'Usted es usuario plus.' ] ifFalse: ['Usted es usuario común.']).

self añadirBoton: modalidadMorph conMargen: 20.

bCambioModalidad := (BotonGenerico_UI new inicializarConSistema: system label: 'Cambiar modalidad').
bCambioModalidad definirAccion: [ usuario := usuario cambiarModalidad: unSistema. usuario addDependent: self. self mensaje: 'Usted ha cambiado su modalidad correctamente.' ].
self añadirBoton: bCambioModalidad conMargen: 20.

bMostrarBibInteres := (BotonGenerico_UI new inicializarConSistema: system label: 'Mostrar mis bibliotecas de interés').
bMostrarBibInteres definirAccion: [ (Ventana_UI crearConMorph: listaBib) openCenteredInWorld ].
self añadirBoton: bMostrarBibInteres conMargen: 20.


self openCenteredInWorld .

^self
]

{ #category : #updating }
VistaUsuario >> update: unUsuario [

plus := plus not.
modalidadMorph contents: ((plus) ifTrue: [ 'Usted es usuario plus.' ] ifFalse: ['Usted es usuario común.']).

]
