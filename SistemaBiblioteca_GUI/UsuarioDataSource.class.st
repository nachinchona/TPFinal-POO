Class {
	#name : #UsuarioDataSource,
	#superclass : #FTSimpleDataSource,
	#instVars : [
		'system'
	],
	#category : #'SistemaBiblioteca_GUI'
}

{ #category : #'as yet unclassified' }
UsuarioDataSource class >> crear: unSistema [
|unaDS|
unaDS := self elements: unSistema getUsuarios .
unaDS asignarSistema: unSistema .
^ unaDS

]

{ #category : #'as yet unclassified' }
UsuarioDataSource class >> elements: unaCol conSistema: unSistema [
|ds|
ds := super elements: unaCol.
ds asignarSistema: unSistema.

^ ds

]

{ #category : #'as yet unclassified' }
UsuarioDataSource >> apellidoCellColumn: column row: rowIndex [
^ FTCellMorph new
		addMorphBack: ((elements at: rowIndex) apellido) asStringMorph;
		yourself
]

{ #category : #'as yet unclassified' }
UsuarioDataSource >> asignarSistema: unSistema [
system := unSistema .
]

{ #category : #'as yet unclassified' }
UsuarioDataSource >> bibInteresCellColumn: column row: rowIndex [
|tabla boton|
boton := BotonGenerico_UI new.
tabla := Tabla_UI crearBConDataSource: (BibliotecaDataSource elements: ((elements at: rowIndex) bibliotecasInteres)) ancho: 500 altura: 200.
^ FTCellMorph new
		addMorphBack: (boton definirAccion: [Ventana_UI crearConMorph: tabla]; label: 'Ver bibliotecas'; color: (Color r: 0.4 g: 0.8 b: 0.6));
		yourself
]

{ #category : #accessing }
UsuarioDataSource >> cellColumn: column row: rowIndex [
(column id = 'DNI') ifTrue: [ ^ self dniCellColumn: column row: rowIndex ].
(column id = 'Nombre') ifTrue: [ ^ self nombreCellColumn: column row: rowIndex ].
(column id = 'Apellido') ifTrue: [ ^ self apellidoCellColumn: column row: rowIndex ].
(column id = 'Multado') ifTrue: [ ^ self multaCellColumn: column row: rowIndex ].
(column id = 'Bib. interés') ifTrue: [ ^ self bibInteresCellColumn: column row: rowIndex ].
(column id = 'Préstamos') ifTrue: [ ^ self prestamosCellColumn: column row: rowIndex ].
]

{ #category : #'as yet unclassified' }
UsuarioDataSource >> dniCellColumn: column row: rowIndex [
^ FTCellMorph new
		addMorphBack: ((elements at: rowIndex) dni) asStringMorph;
		yourself
]

{ #category : #'as yet unclassified' }
UsuarioDataSource >> multaCellColumn: column row: rowIndex [
^ FTCellMorph new
		addMorphBack: ((elements at: rowIndex) estaMultado) asStringMorph;
		yourself
]

{ #category : #'as yet unclassified' }
UsuarioDataSource >> nombreCellColumn: column row: rowIndex [
^ FTCellMorph new
		addMorphBack: ((elements at: rowIndex) nombre) asStringMorph;
		yourself
]

{ #category : #'as yet unclassified' }
UsuarioDataSource >> prestamosCellColumn: column row: rowIndex [
|tabla boton|
boton := BotonGenerico_UI new.
tabla := Tabla_UI crearPConDataSource: (PrestamoDataSource elements: (system getPrestamosDeUsuario: ((elements at: rowIndex) dni) )) ancho: 500 altura: 200.
^ FTCellMorph new
		addMorphBack: (boton definirAccion: [Ventana_UI crearConMorph: tabla]; label: 'Ver préstamos'; color: (Color r: 0.4 g: 0.8 b: 0.6));
		yourself
]
