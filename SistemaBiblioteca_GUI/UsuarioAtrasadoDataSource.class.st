"
Esta clase no solo contiene usuarios, sino también la biblioteca en la que adeudan, en forma de tuplas (x,y), siendo x el objeto Usuario e y la id de la biblioteca
"
Class {
	#name : #UsuarioAtrasadoDataSource,
	#superclass : #FTSimpleDataSource,
	#instVars : [
		'system'
	],
	#category : #'SistemaBiblioteca_GUI'
}

{ #category : #'as yet unclassified' }
UsuarioAtrasadoDataSource class >> crear: unSistema [
|unaDS|
unaDS := self elements: unSistema getUsuarios .
unaDS asignarSistema: unSistema .
^ unaDS

]

{ #category : #'as yet unclassified' }
UsuarioAtrasadoDataSource class >> elements: unaCol conSistema: unSistema [
|ds|
ds := super elements: unaCol.
ds asignarSistema: unSistema.

^ ds

]

{ #category : #'as yet unclassified' }
UsuarioAtrasadoDataSource >> apellidoCellColumn: column row: rowIndex [
^ FTCellMorph new
		addMorphBack: (((elements at: rowIndex) at: 1) apellido) asStringMorph;
		yourself
]

{ #category : #'as yet unclassified' }
UsuarioAtrasadoDataSource >> asignarSistema: unSistema [
system := unSistema .
]

{ #category : #accessing }
UsuarioAtrasadoDataSource >> cellColumn: column row: rowIndex [
(column id = 'DNI') ifTrue: [ ^ self dniCellColumn: column row: rowIndex ].
(column id = 'Nombre') ifTrue: [ ^ self nombreCellColumn: column row: rowIndex ].
(column id = 'Apellido') ifTrue: [ ^ self apellidoCellColumn: column row: rowIndex ].
(column id = 'Multado') ifTrue: [ ^ self multaCellColumn: column row: rowIndex ].
(column id = 'Biblioteca en la que adeuda') ifTrue: [ ^ self idBibliotecaCellColumn: column row: rowIndex ].
]

{ #category : #'as yet unclassified' }
UsuarioAtrasadoDataSource >> dniCellColumn: column row: rowIndex [
^ FTCellMorph new
		addMorphBack: (((elements at: rowIndex) at: 1) dni) asStringMorph;
		yourself
]

{ #category : #'as yet unclassified' }
UsuarioAtrasadoDataSource >> idBibliotecaCellColumn: column row: rowIndex [
^ FTCellMorph new
		addMorphBack: ((elements at: rowIndex) at: 2) asStringMorph;
		yourself
]

{ #category : #'as yet unclassified' }
UsuarioAtrasadoDataSource >> multaCellColumn: column row: rowIndex [
^ FTCellMorph new
		addMorphBack: (((elements at: rowIndex) at: 1) estaMultado) asStringMorph;
		yourself
]

{ #category : #'as yet unclassified' }
UsuarioAtrasadoDataSource >> nombreCellColumn: column row: rowIndex [
^ FTCellMorph new
		addMorphBack: (((elements at: rowIndex) at: 1) nombre) asStringMorph;
		yourself
]
