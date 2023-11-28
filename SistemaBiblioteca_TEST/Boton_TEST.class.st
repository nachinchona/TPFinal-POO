Class {
	#name : #'Boton_TEST',
	#superclass : #SimpleButtonMorph,
	#instVars : [
		't'
	],
	#category : #'SistemaBiblioteca_TEST'
}

{ #category : #'event handling' }
Boton_TEST >> mouseUp: anEvent [
super mouseUp: anEvent.
(t getText = 'hola') ifTrue: [ Transcript show: 'hola21' ].
]

{ #category : #initialization }
Boton_TEST >> set: te [
t := te.
]
