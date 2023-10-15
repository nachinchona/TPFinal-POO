Class {
	#name : #'Sistema_UI',
	#superclass : #BorderedMorph,
	#instVars : [
		'frame',
		'system',
		'bAgregarBiblioteca',
		'bMostrarBibliotecas',
		'bIniciarSesion',
		'bCerrar'
	],
	#category : #SistemaBiblioteca
}

{ #category : #'as yet unclassified' }
Sistema_UI >> agregarBotones [

bAgregarBiblioteca := BotonAgregarBiblioteca_UI new inicializarConSistema: system .
bMostrarBibliotecas := BotonMostrarBibliotecas_UI new inicializarConSistema: system.
bIniciarSesion := BotonIniciarSesion_UI new inicializarConSistema: system.

frame addMorph: bAgregarBiblioteca.
frame addMorph: bMostrarBibliotecas.
frame addMorph: bIniciarSesion.

bAgregarBiblioteca position: frame position + (10@50).
bMostrarBibliotecas position: frame position + (10@(30+bAgregarBiblioteca top)).
bIniciarSesion position: frame position + (10@(30+bMostrarBibliotecas top)).
]

{ #category : #'as yet unclassified' }
Sistema_UI >> armarFrame [
|barra titulo contenedorTitulo|
frame := BorderedMorph new color: Color gray; extent: 300@500; borderColor: Color lightGray; borderWidth: 3.
barra := BorderedMorph new color: Color gray; extent: 300@20; borderColor: Color lightGray; borderWidth: 3.
contenedorTitulo := Morph new beTransparent; extent: 300@40.
titulo := TextMorph new contents: ('MENÚ PRINCIPAL' asText allBold); fillsOwner: true.
titulo font: (LogicalFont familyName: 'Roboto' pointSize: 20). 
bCerrar := BotonCerrar_UI new inicializar.

bCerrar position: frame topRight - bCerrar extent.
barra position: frame position - (0@20).

frame addMorphFront: titulo.
frame addMorph: barra.
frame addMorph: bCerrar  inFrontOf: barra.







]

{ #category : #'as yet unclassified' }
Sistema_UI >> getSistema [
^system
]

{ #category : #'as yet unclassified' }
Sistema_UI >> iniciarMenuPrincipalConSistema: unSistema [

system := unSistema.

self armarFrame.
self agregarBotones.

frame openCenteredInWorld .
]
