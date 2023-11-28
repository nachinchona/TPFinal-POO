Class {
	#name : #'BotonMostrarBiblioteca_UI',
	#superclass : #SimpleButtonMorph,
	#instVars : [
		'system',
		'ventana',
		'colInfo',
		'colLibros'
	],
	#category : #'SistemaBiblioteca_GUI'
}

{ #category : #'as yet unclassified' }
BotonMostrarBiblioteca_UI >> asignarSistema: unSistema [
system := unSistema .
]

{ #category : #'as yet unclassified' }
BotonMostrarBiblioteca_UI >> inicializarConSistema: unSistema [
self asignarSistema: unSistema.
self label: 'Mostrar biblioteca' font: (LogicalFont familyName: 'Roboto' pointSize: 14). 
]

{ #category : #'as yet unclassified' }
BotonMostrarBiblioteca_UI >> mostrarInfoDeBiblioteca: unaBiblioteca [

]

{ #category : #'event handling' }
BotonMostrarBiblioteca_UI >> mouseUp: anEvent [
super mouseUp: anEvent 
]
