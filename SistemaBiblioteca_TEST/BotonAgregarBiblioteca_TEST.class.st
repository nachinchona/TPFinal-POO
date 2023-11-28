Class {
	#name : #'BotonAgregarBiblioteca_TEST',
	#superclass : #SimpleButtonMorph,
	#instVars : [
		'system'
	],
	#category : #'SistemaBiblioteca_TEST'
}

{ #category : #'as yet unclassified' }
BotonAgregarBiblioteca_TEST >> asignarSistema: unSistema [
system := unSistema .
]

{ #category : #'as yet unclassified' }
BotonAgregarBiblioteca_TEST >> inicializarConSistema: unSistema [
self asignarSistema: unSistema.
self label: 'Agregar biblioteca' font: (LogicalFont familyName: 'Roboto' pointSize: 14). 
]

{ #category : #'event handling' }
BotonAgregarBiblioteca_TEST >> mouseUp: anEvent [
|userInput id direccion nombre telefono nombreRepresentante cantDiasPrestamo nuevaBiblioteca|
super mouseUp: anEvent .

id :=  system obtenerIDBibliotecaSiguiente.
userInput := UIManager default request: 'Ingrese el nombre de la biblioteca:'.
nombre := userInput.
0.5 seconds wait.

userInput := UIManager default request: 'Ingrese la dirección de la biblioteca:'.
direccion := userInput .
0.5 seconds wait.

userInput := UIManager default request: 'Ingrese el teléfono de la biblioteca:'.
telefono := userInput.
0.5 seconds wait.

userInput := UIManager default request: 'Ingrese el nombre del representante de la biblioteca:'.
nombreRepresentante := userInput.
0.5 seconds wait.

userInput := UIManager default request: 'Ingrese la cantidad de días para prestar de la biblioteca:'.
cantDiasPrestamo := userInput .
0.5 seconds wait.

(nombre isNotNil & direccion isNotNil & telefono isNotNil & nombreRepresentante isNotNil & cantDiasPrestamo isNotNil) 
ifTrue: 
[
nuevaBiblioteca := Biblioteca crearConId: id direccion: direccion nombre: nombre telefono: telefono nombreRepresentante: nombreRepresentante cantDiasPrestamo: cantDiasPrestamo.
system agregarBiblioteca: nuevaBiblioteca.
]
ifFalse:
[
UIManager default abort: 'Error: ha ocurrido un error al ingresar los datos.'
].





]
