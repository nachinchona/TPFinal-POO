Class {
	#name : #'BotonMostrarBiblioteca_UI',
	#superclass : #SimpleButtonMorph,
	#instVars : [
		'system'
	],
	#category : #SistemaBiblioteca
}

{ #category : #'as yet unclassified' }
BotonMostrarBiblioteca_UI >> asignarSistema: unSistema [
system := unSistema .
]

{ #category : #'as yet unclassified' }
BotonMostrarBiblioteca_UI >> inicializarConSistema: unSistema [
self asignarSistema: unSistema.
self label: 'Lista de bibliotecas' font: (LogicalFont familyName: 'Roboto' pointSize: 14). 
]

{ #category : #'event handling' }
BotonMostrarBiblioteca_UI >> mouseUp: anEvent [
|userInput unaBiblioteca|
super mouseUp: anEvent .
userInput := UIManager default request: 'Ingrese la ID de biblioteca que desea buscar: '.
userInput
ifNil:
[ UIManager default abort: 'La biblioteca con la ID ingresada no existe. ' ]
ifNotNil: 
[ 
unaBiblioteca := system buscarBibliotecaConId: userInput .
].
^ unaBiblioteca 
]