Class {
	#name : #'BotonGenerico_UI',
	#superclass : #SimpleButtonMorph,
	#instVars : [
		'accion',
		'habilitado'
	],
	#category : #'SistemaBiblioteca_GUI'
}

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
BotonGenerico_UI >> habilitar [
habilitado := true.
self color: Color orange.
]

{ #category : #'as yet unclassified' }
BotonGenerico_UI >> inicializarConAccion: unaAccion [
accion := unaAccion .
]

{ #category : #initialization }
BotonGenerico_UI >> initialize [
super initialize.
self color: Color orange.
habilitado := true.
]

{ #category : #'event handling' }
BotonGenerico_UI >> mouseUp: unEvento [
super mouseUp: unEvento.
habilitado ifTrue:
[accion value. ].
]

{ #category : #'as yet unclassified' }
BotonGenerico_UI >> textoBoton: unTexto [
super label: unTexto font: (LogicalFont familyName: 'Arial' pointSize: 15); color: Color orange.
]
