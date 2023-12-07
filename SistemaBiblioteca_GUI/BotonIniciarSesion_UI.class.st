Class {
	#name : #'BotonIniciarSesion_UI',
	#superclass : #SimpleButtonMorph,
	#instVars : [
		'systemUI',
		'campoDNI',
		'campoPass'
	],
	#category : #'SistemaBiblioteca_GUI'
}

{ #category : #'as yet unclassified' }
BotonIniciarSesion_UI >> asignarSistema: unSistema [
systemUI := unSistema.
]

{ #category : #'as yet unclassified' }
BotonIniciarSesion_UI >> inicializarConSistema: unSistema campoDNI: unCampoDNI campoPass: unCampoPass [
campoDNI := unCampoDNI.
campoPass := unCampoPass.
self asignarSistema: unSistema.
self label: 'Iniciar sesión' font: (LogicalFont familyName: 'Roboto' pointSize: 14); color: Color orange.
]

{ #category : #'as yet unclassified' }
BotonIniciarSesion_UI >> iniciarSesion [
((campoDNI getText) asString = 'admin')
ifTrue: 
[  
	"puede ser admin"
	(((campoPass getText) asString) = 'admin')
	ifTrue: [ self owner delete. systemUI vistaAdmin. ]
	ifFalse: [ systemUI error: 'Contraseña incorrecta.' ].
]
ifFalse: 
[
	"es usuario comun"
	((campoDNI getText ~= '')  & (campoDNI getText asString isAllDigits) & (campoPass getText ~= ''))
	ifTrue: 
	[ 
		|tempUsuario|
		tempUsuario := ((systemUI getSistema) buscarUsuarioConDni: (campoDNI getText)).
		tempUsuario
		ifNotNil: 
		[
			((tempUsuario contrasenia) asString = (campoPass getText) asString)		
				ifTrue: [ self owner delete. systemUI vistaUsuario: (campoDNI getText) asNumber . ]
				ifFalse: [ systemUI error: 'Contraseña incorrecta.' ].
		] 
		ifNil: 
			[systemUI error: 'Usuario no existe.'].	
	]
	ifFalse:
	[ systemUI error: 'Error: no ingresó correctamente en algún campo' ]
]

]

{ #category : #'event handling' }
BotonIniciarSesion_UI >> mouseUp: anEvent [
super mouseUp: anEvent.
self iniciarSesion.
]
