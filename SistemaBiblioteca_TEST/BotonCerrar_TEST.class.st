Class {
	#name : #'BotonCerrar_TEST',
	#superclass : #SimpleButtonMorph,
	#category : #'SistemaBiblioteca_TEST'
}

{ #category : #'as yet unclassified' }
BotonCerrar_TEST >> inicializar [
self label: ('cerrar' asText allBold). self extent: 45@20; color: Color red; borderColor: Color lightGray ; borderWidth: 3.
]

{ #category : #'as yet unclassified' }
BotonCerrar_TEST >> mouseUp: anEvent [
super mouseUp: anEvent .
self owner delete.
]
