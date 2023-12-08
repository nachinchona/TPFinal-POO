Class {
	#name : #'BotonCerrar_UI',
	#superclass : #'BotonGenerico_UI',
	#category : #'SistemaBiblioteca_GUI'
}

{ #category : #'as yet unclassified' }
BotonCerrar_UI >> initialize [
super initialize.
self label: ('cerrar' asText allBold). self extent: 45@20; color: Color red; borderColor: Color darkGray ; borderWidth: 3.
]

{ #category : #'event handling' }
BotonCerrar_UI >> mouseUp: unEvento [
super mouseUp: unEvento.
self owner delete.
]
