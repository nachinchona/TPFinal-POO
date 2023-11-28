Class {
	#name : #'BotonCerrar_UI',
	#superclass : #SimpleButtonMorph,
	#instVars : [
		'accion'
	],
	#category : #'SistemaBiblioteca_GUI'
}

{ #category : #'as yet unclassified' }
BotonCerrar_UI >> añadirAccion: unaAccion [
accion := unaAccion .

]

{ #category : #'as yet unclassified' }
BotonCerrar_UI >> inicializar [
self label: ('cerrar' asText allBold). self extent: 45@20; color: Color red; borderColor: Color lightGray ; borderWidth: 3.
]

{ #category : #'as yet unclassified' }
BotonCerrar_UI >> inicializarConAccion: unaAccion [
self inicializar.
accion := unaAccion .

]

{ #category : #'as yet unclassified' }
BotonCerrar_UI >> mouseUp: anEvent [
super mouseUp: anEvent .
accion value.
self owner delete.
]
