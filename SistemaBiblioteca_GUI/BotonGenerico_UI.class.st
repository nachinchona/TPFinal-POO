Class {
	#name : #'BotonGenerico_UI',
	#superclass : #SimpleButtonMorph,
	#instVars : [
		'system',
		'accion'
	],
	#category : #'SistemaBiblioteca_GUI'
}

{ #category : #'as yet unclassified' }
BotonGenerico_UI >> asignarSistema: unSistema [
system := unSistema.
]

{ #category : #'as yet unclassified' }
BotonGenerico_UI >> definirAccion: unaAccion [
accion := unaAccion .
]

{ #category : #'as yet unclassified' }
BotonGenerico_UI >> inicializarConSistema: unSistema label: unTexto [
self asignarSistema: unSistema.
self label: unTexto font: (LogicalFont familyName: 'Roboto' pointSize: 14). 
]

{ #category : #'event handling' }
BotonGenerico_UI >> mouseUp: unEvento [
super mouseUp: unEvento .
accion value.
]
