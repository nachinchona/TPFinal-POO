Class {
	#name : #'Sistema_TEST',
	#superclass : #BorderedMorph,
	#instVars : [
		'frame',
		'system',
		'bAgregarBiblioteca',
		'bMostrarBibliotecas',
		'bIniciarSesion'
	],
	#category : #'SistemaBiblioteca_TEST'
}

{ #category : #'as yet unclassified' }
Sistema_TEST class >> crearVentanaConAncho: unAncho altura: unaAltura [
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
Sistema_TEST class >> crearVentanaConAncho: unAncho altura: unaAltura titulo: unTitulo [
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
Sistema_TEST >> agregarBotones [

bAgregarBiblioteca := BotonAgregarBiblioteca_UI new inicializarConSistema: system .
bMostrarBibliotecas := BotonMostrarBiblioteca_UI new inicializarConSistema: system.
bIniciarSesion := BotonIniciarSesion_UI new inicializarConSistema: system.

frame addMorph: bAgregarBiblioteca.
frame addMorph: bMostrarBibliotecas.
frame addMorph: bIniciarSesion.

bAgregarBiblioteca position: frame position + (10@50).
bMostrarBibliotecas position: frame position + (10@(30+bAgregarBiblioteca top)).
bIniciarSesion position: frame position + (10@(30+bMostrarBibliotecas top)).
]

{ #category : #'as yet unclassified' }
Sistema_TEST >> asignarSistema: unSistema [
system := unSistema .
]

{ #category : #'as yet unclassified' }
Sistema_TEST >> getSistema [
^system
]

{ #category : #'as yet unclassified' }
Sistema_TEST >> iniciarMenuPrincipalConSistema: unSistema [

system := unSistema.

self armarFrame.
self agregarBotones.

frame openCenteredInWorld .
]

{ #category : #'as yet unclassified' }
Sistema_TEST >> vistaInicioSesion [
Ventana_UI vistaInicioSesion: system.
]
