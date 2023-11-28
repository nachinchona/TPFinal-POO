Class {
	#name : #'Ventana_TEST',
	#superclass : #Morph,
	#instVars : [
		'botones'
	],
	#category : #'SistemaBiblioteca_TEST'
}

{ #category : #'as yet unclassified' }
Ventana_TEST class >> crearVentanaConAncho: unAncho altura: unaAltura [
|frame barra contenedorTitulo bCerrar|
"este metodo quedaria mejor como parte de BorderedMorph, pero para que quede todo en el mismo paquete es de SistemaUI"
frame := self new color: Color gray; extent: unAncho@unaAltura; borderColor: Color lightGray; borderWidth: 3.
barra := self new color: Color gray; extent: unAncho@20; borderColor: Color lightGray; borderWidth: 3.
contenedorTitulo := Morph new beTransparent; extent: 300@40.
bCerrar := BotonCerrar_UI new inicializar.

bCerrar position: frame topRight - bCerrar extent.
barra position: frame position - (0@20).

frame addMorph: barra.
frame addMorph: bCerrar  inFrontOf: barra.
^ frame
]

{ #category : #'as yet unclassified' }
Ventana_TEST class >> crearVentanaConAncho: unAncho altura: unaAltura titulo: unTitulo [
|frame barra titulo contenedorTitulo bCerrar|
"este metodo quedaria mejor como parte de BorderedMorph, pero para que quede todo en el mismo paquete es de SistemaUI"
frame := self new color: Color gray; extent: unAncho@unaAltura; borderColor: Color lightGray; borderWidth: 3.
barra := self new color: Color gray; extent: unAncho@20; borderColor: Color lightGray; borderWidth: 3.
contenedorTitulo := Morph new beTransparent; extent: 300@40.
titulo := TextMorph new contents: (unTitulo asText allBold); fillsOwner: true.
titulo font: (LogicalFont familyName: 'Roboto' pointSize: 20). 
bCerrar := BotonCerrar_UI new inicializar.

bCerrar position: frame topRight - bCerrar extent.
barra position: frame position - (0@20).

frame addMorphFront: titulo.
frame addMorph: barra.
frame addMorph: bCerrar  inFrontOf: barra.
^ frame
]

{ #category : #'as yet unclassified' }
Ventana_TEST class >> vistaInicioSesion: system [
|ventana bInicioSesion bRegistrar|
ventana := self crearVentanaConAncho: 300 altura: 400 titulo: 'BIENVENIDO'.
bInicioSesion := BotonIniciarSesion_UI new inicializarConSistema: system.
bRegistrar := SimpleButtonMorph new label: 'Registrar' font: (LogicalFont familyName: 'Roboto' pointSize: 14).

ventana agregarBoton: bInicioSesion.
ventana addMorph: bInicioSesion.
ventana agregarBoton: bRegistrar.
ventana addMorph: bRegistrar.

bInicioSesion position: ventana position + (10@50).
bRegistrar position: ventana position + (10@(30 + bInicioSesion top)).

ventana openCenteredInWorld .
]

{ #category : #'as yet unclassified' }
Ventana_TEST >> agregarBoton: unBoton [
botones ifNil: [botones := OrderedCollection new. ].
botones add: unBoton. 
self addMorph: unBoton .

]

{ #category : #accessing }
Ventana_TEST >> botones [
^botones
]
