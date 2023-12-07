Class {
	#name : #'BotonGenerico_UI',
	#superclass : #SimpleButtonMorph,
	#instVars : [
		'system',
		'accion',
		'habilitado'
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
BotonGenerico_UI >> deshabilitar [
habilitado := false.
self color: Color darkGray.
]

{ #category : #'as yet unclassified' }
BotonGenerico_UI >> inicializarConAccion: unaAccion [
habilitado := true.
accion := unaAccion .
]

{ #category : #'as yet unclassified' }
BotonGenerico_UI >> inicializarConSistema: unSistema label: unTexto [
self asignarSistema: unSistema.
habilitado := true.
self label: unTexto font: (LogicalFont familyName: 'Roboto' pointSize: 14); color: Color orange. 
]

{ #category : #'event handling' }
BotonGenerico_UI >> mouseUp: unEvento [
super mouseUp: unEvento.
habilitado ifTrue:
[accion value. ].
]
