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
BotonIniciarSesion_UI >> inicializarConSistema: unSistema [
self asignarSistema: unSistema.
self label: 'Iniciar sesión' font: (LogicalFont familyName: 'Roboto' pointSize: 14). 
]

{ #category : #'as yet unclassified' }
BotonIniciarSesion_UI >> inicializarConSistema: unSistema campoDNI: unCampoDNI campoPass: unCampoPass [
campoDNI := unCampoDNI.
campoPass := unCampoPass.
self asignarSistema: unSistema.
self label: 'Iniciar sesión' font: (LogicalFont familyName: 'Roboto' pointSize: 14). 
]

{ #category : #'as yet unclassified' }
BotonIniciarSesion_UI >> iniciarSesion [
|tempUsuario|
tempUsuario := ((systemUI getSistema) buscarUsuarioConDni: (campoDNI getText)).
tempUsuario ifNotNil: [self owner delete. ] ifNil: [^false].


]

{ #category : #'event handling' }
BotonIniciarSesion_UI >> mouseUp: anEvent [
super mouseUp: anEvent.
self iniciarSesion.
]
