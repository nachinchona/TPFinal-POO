Class {
	#name : #'Ventana_UI',
	#superclass : #Morph,
	#instVars : [
		'botones'
	],
	#category : #'SistemaBiblioteca_GUI'
}

{ #category : #'as yet unclassified' }
Ventana_UI class >> crearConMorph: unMorph [
|ventana|
ventana := self crearVentanaConAncho: unMorph width + 20 altura: unMorph height + 20.
ventana addMorphCentered: unMorph . 
ventana openCenteredInWorld.
^ ventana
]

{ #category : #'as yet unclassified' }
Ventana_UI class >> crearVentanaConAncho: unAncho altura: unaAltura [
|frame barra bCerrar|

frame := self new color: Color veryDarkGray ; extent: unAncho@unaAltura; borderColor: Color darkGray; borderWidth: 3.
barra := self new color: Color veryDarkGray; extent: unAncho@20; borderColor: Color darkGray; borderWidth: 3.
bCerrar := BotonCerrar_UI new.

bCerrar position: frame topRight - bCerrar extent.
barra position: frame position - (0@20).
frame inicializarBotones .
(frame botones) add: bCerrar.
frame addMorph: barra.
frame addMorph: bCerrar  inFrontOf: barra.
^ frame
]

{ #category : #'as yet unclassified' }
Ventana_UI class >> crearVentanaConAncho: unAncho altura: unaAltura titulo: unTitulo [
|frame barra titulo bCerrar|

frame := self new color: Color veryDarkGray ; extent: unAncho@unaAltura; borderColor: Color darkGray; borderWidth: 3.

barra := self new color: Color veryDarkGray; extent: unAncho@20; borderColor: Color darkGray; borderWidth: 3.
titulo := TextMorph new contents: (unTitulo asText allBold); fillsOwner: true.
titulo font: (LogicalFont familyName: 'Roboto' pointSize: 20).

bCerrar := BotonCerrar_UI new.
frame inicializarBotones .
(frame botones) add: bCerrar.
bCerrar position: frame topRight - bCerrar extent.
barra position: frame position - (0@20).

frame addMorphFront: titulo. titulo position: frame topLeft + (10@0).
frame addMorph: barra.
frame addMorph: bCerrar  inFrontOf: barra.
^ frame
]

{ #category : #'as yet unclassified' }
Ventana_UI >> añadirMorph: unMorph alLadoDe: otroMorph [
unMorph position: otroMorph position + (otroMorph width + 10@0).
self addMorph: unMorph behind: otroMorph

]

{ #category : #'as yet unclassified' }
Ventana_UI >> añadirMorph: unMorph conMargen: unMargen [
unMorph position: (10@(self lastSubmorph bottom + unMargen)).
self addMorphBack: unMorph. 
]

{ #category : #accessing }
Ventana_UI >> botones [
^botones
]

{ #category : #'as yet unclassified' }
Ventana_UI >> definirAccion: unaAccion [
"añade una accion al boton cerrar (volver entre ventanas)"
(botones at: 1) definirAccion: unaAccion .
]

{ #category : #'as yet unclassified' }
Ventana_UI >> inicializarBotones [
botones := OrderedCollection new.
]
