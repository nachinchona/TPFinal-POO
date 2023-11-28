Class {
	#name : #'BotonRegistrar_UI',
	#superclass : #SimpleButtonMorph,
	#instVars : [
		'systemUI'
	],
	#category : #'SistemaBiblioteca_GUI'
}

{ #category : #'as yet unclassified' }
BotonRegistrar_UI >> asignarSistema: unSistema [
systemUI := unSistema.
]

{ #category : #'as yet unclassified' }
BotonRegistrar_UI >> inicializarConSistema: unSistema [
self asignarSistema: unSistema.
self label: 'Registrar' font: (LogicalFont familyName: 'Roboto' pointSize: 14). 
]

{ #category : #'event handling' }
BotonRegistrar_UI >> mouseUp: anEvent [
super mouseUp: anEvent.
self registrar.
]

{ #category : #'as yet unclassified' }
BotonRegistrar_UI >> registrar [
systemUI vistaRegistro . self owner delete. 

]
