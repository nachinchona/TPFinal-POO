Class {
	#name : #'Ventana_UI',
	#superclass : #Morph,
	#instVars : [
		'botones'
	],
	#category : #'SistemaBiblioteca_GUI'
}

{ #category : #'as yet unclassified' }
Ventana_UI class >> crearVentanaConAncho: unAncho altura: unaAltura [
|frame barra bCerrar|

frame := self new color: Color gray; extent: unAncho@unaAltura; borderColor: Color lightGray; borderWidth: 3.
barra := self new color: Color gray; extent: unAncho@20; borderColor: Color lightGray; borderWidth: 3.
bCerrar := BotonCerrar_UI new inicializar.

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
|frame barra titulo contenedorTitulo bCerrar|

frame := self new color: Color gray; extent: unAncho@unaAltura; borderColor: Color lightGray; borderWidth: 3.
barra := self new color: Color gray; extent: unAncho@20; borderColor: Color lightGray; borderWidth: 3.
contenedorTitulo := Morph new beTransparent; extent: unAncho@40.
titulo := TextMorph new contents: (unTitulo asText allBold); fillsOwner: true.
titulo font: (LogicalFont familyName: 'Roboto' pointSize: 20).

bCerrar := BotonCerrar_UI new inicializar.
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
Ventana_UI >> añadirAccion: unaAccion [
"añade una accion al boton cerrar (volver entre ventanas)"
(botones at: 1) añadirAccion: unaAccion .
]

{ #category : #'as yet unclassified' }
Ventana_UI >> añadirBoton: unBoton conMargen: unMargen [
unBoton position: (10@(self lastSubmorph bottom + unMargen)). self addMorphBack: unBoton. 
]

{ #category : #accessing }
Ventana_UI >> botones [
^botones
]

{ #category : #'as yet unclassified' }
Ventana_UI >> inicializarBotones [
botones := OrderedCollection new.
]
