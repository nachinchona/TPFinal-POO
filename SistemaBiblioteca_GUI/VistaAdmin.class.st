Class {
	#name : #VistaAdmin,
	#superclass : #'Sistema_UI',
	#instVars : [
		'bienvenida',
		'lista'
	],
	#category : #'SistemaBiblioteca_GUI'
}

{ #category : #'as yet unclassified' }
VistaAdmin class >> crearConSistema: unSistema [
|vista|
vista := self crearVentanaConAncho: 300 altura: 300 titulo: 'ADMIN'.
vista inicializarConSistema: unSistema .
^ vista

]

{ #category : #initialization }
VistaAdmin >> inicializarConSistema: unSistema [

bienvenida := TextMorph new contents: 'Bienvenido/a admin! :)'.
self añadirMorph: bienvenida conMargen: 30.

lista := BorderedMorph new extent: 280@180; color: Color darkGray; borderWidth: 1.
lista addMorph: (TextMorph new contents: 'Usuarios:'; position: lista position + (10@0)).
system getUsuarios do: [ :u | lista addMorphBack: (TextMorph new contents: (u dni) asString; position: lista lastSubmorph position + (0@20))].

self añadirMorph: lista conMargen: 20.

self openCenteredInWorld .
]

{ #category : #'as yet unclassified' }
VistaAdmin >> vistaAdmin [
|vista bienvenida lista|
vista := self class crearVentanaConAncho: 300 altura: 300 titulo: 'ADMIN'.

bienvenida := TextMorph new contents: 'Bienvenido/a admin! :)'.
vista añadirMorph: bienvenida conMargen: 30.

lista := BorderedMorph new extent: 280@180; color: Color darkGray; borderWidth: 1.
lista addMorph: (TextMorph new contents: 'Usuarios:'; position: lista position + (10@0)).
system getUsuarios do: [ :u | lista addMorphBack: (TextMorph new contents: (u dni) asString; position: lista lastSubmorph position + (0@20))].

vista añadirMorph: lista conMargen: 20.

vista openCenteredInWorld .
]
