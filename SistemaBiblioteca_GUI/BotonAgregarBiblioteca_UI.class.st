Class {
	#name : #'BotonAgregarBiblioteca_UI',
	#superclass : #SimpleButtonMorph,
	#instVars : [
		'system'
	],
	#category : #'SistemaBiblioteca_GUI'
}

{ #category : #'as yet unclassified' }
BotonAgregarBiblioteca_UI >> asignarSistema: unSistema [
system := unSistema .
]

{ #category : #'as yet unclassified' }
BotonAgregarBiblioteca_UI >> inicializarConSistema: unSistema [
self asignarSistema: unSistema.
self label: 'Agregar biblioteca' font: (LogicalFont familyName: 'Roboto' pointSize: 14). 
]

{ #category : #'event handling' }
BotonAgregarBiblioteca_UI >> mouseUp: anEvent [
super mouseUp: anEvent 

]
