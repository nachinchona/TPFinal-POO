Class {
	#name : #'BotonCerrar_UI',
	#superclass : #SimpleButtonMorph,
	#category : #SistemaBiblioteca
}

{ #category : #'as yet unclassified' }
BotonCerrar_UI >> inicializar [
self label: ('cerrar' asText allBold). self extent: 45@20; color: Color red; borderColor: Color lightGray ; borderWidth: 3.
]

{ #category : #'as yet unclassified' }
BotonCerrar_UI >> mouseUp: anEvent [
super mouseUp: anEvent .
self owner delete.
]
