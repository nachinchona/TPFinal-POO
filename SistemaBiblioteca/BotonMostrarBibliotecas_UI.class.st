Class {
	#name : #'BotonMostrarBibliotecas_UI',
	#superclass : #SimpleButtonMorph,
	#instVars : [
		'system'
	],
	#category : #SistemaBiblioteca
}

{ #category : #'as yet unclassified' }
BotonMostrarBibliotecas_UI >> asignarSistema: unSistema [
system := unSistema .
]

{ #category : #'as yet unclassified' }
BotonMostrarBibliotecas_UI >> inicializarConSistema: unSistema [
self asignarSistema: unSistema.
self label: 'Lista de bibliotecas' font: (LogicalFont familyName: 'Roboto' pointSize: 14). 
]
