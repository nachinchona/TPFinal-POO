Class {
	#name : #'BotonRegistrar_UI',
	#superclass : #'BotonGenerico_UI',
	#instVars : [
		'systemUI'
	],
	#category : #'SistemaBiblioteca_GUI'
}

{ #category : #'as yet unclassified' }
BotonRegistrar_UI >> asignarSistema: unSistema [
systemUI := unSistema.
]

{ #category : #'as yet unclassified' }
BotonRegistrar_UI >> inicializarConSistema: unSistema [
self asignarSistema: unSistema.
self definirAccion: [ self registrar ].
self textoBoton: 'Registrar'. 
]

{ #category : #'as yet unclassified' }
BotonRegistrar_UI >> registrar [
systemUI vistaRegistro . self owner delete. 

]
