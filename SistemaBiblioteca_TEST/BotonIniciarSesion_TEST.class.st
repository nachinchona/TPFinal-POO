Class {
	#name : #'BotonIniciarSesion_TEST',
	#superclass : #SimpleButtonMorph,
	#instVars : [
		'system'
	],
	#category : #'SistemaBiblioteca_TEST'
}

{ #category : #'as yet unclassified' }
BotonIniciarSesion_TEST >> asignarSistema: unSistema [
system := unSistema.
]

{ #category : #'as yet unclassified' }
BotonIniciarSesion_TEST >> inicializarConSistema: unSistema [
self asignarSistema: unSistema.
self label: 'Iniciar sesión' font: (LogicalFont familyName: 'Roboto' pointSize: 14). 
]

{ #category : #'as yet unclassified' }
BotonIniciarSesion_TEST >> iniciarSesion [
|userInput tempUsuario|
userInput := (UIManager default request: 'Ingrese su DNI') asInteger .
userInput 
ifNotNil:
[
	(userInput isInteger)
	ifFalse:
	[
		UIManager default abort: 'Error: el DNI debe ser un dato numérico.'
	]	
	ifTrue:
	[ 
		tempUsuario := (system buscarUsuarioConDni: (userInput asInteger)).
		tempUsuario ifNil: [ UIManager default abort: 'Error. Usuario no existe con DNI ingresado. '] ifNotNil: 
		[ 
			userInput := UIManager default request: 'Ingrese su contraseña'.
			userInput 
			ifNotNil: [(tempUsuario contrasenia = userInput) ifFalse: [ UIManager default abort: 'Contraseña incorrecta.' ]]
			ifNil: [UIManager default abort: 'Error: la contraseña no fue ingresada correctamente.'].
		]
	]
]
ifNil:
[
UIManager default abort: 'Error: el DNI no fue ingresado correctamente.'
].
^ tempUsuario

]

{ #category : #'event handling' }
BotonIniciarSesion_TEST >> mouseUp: anEvent [
super mouseUp: anEvent.
self iniciarSesion
]
