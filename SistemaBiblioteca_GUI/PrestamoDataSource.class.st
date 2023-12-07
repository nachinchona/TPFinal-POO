Class {
	#name : #PrestamoDataSource,
	#superclass : #FTSimpleDataSource,
	#category : #'SistemaBiblioteca_GUI'
}

{ #category : #accessing }
PrestamoDataSource >> cellColumn: column row: row [
(column id = 'ID') ifTrue: [ ^ self idCellColumn: column row: row ].
(column id = 'Fecha de realización') ifTrue: [ ^ self fechaRCellColumn: column row: row ].
(column id = 'Fecha límite') ifTrue: [ ^ self fechaLCellColumn: column row: row ].
(column id = 'Libros') ifTrue: [ ^ self librosCellColumn: column row: row ].
]

{ #category : #'as yet unclassified' }
PrestamoDataSource >> fechaLCellColumn: column row: rowIndex [
^ FTCellMorph new
		addMorphBack: ((elements at: rowIndex) fechaLimite) asStringMorph;
		yourself
]

{ #category : #'as yet unclassified' }
PrestamoDataSource >> fechaRCellColumn: column row: rowIndex [
^ FTCellMorph new
		addMorphBack: ((elements at: rowIndex) fechaRealizacion) asStringMorph;
		yourself
]

{ #category : #'as yet unclassified' }
PrestamoDataSource >> idCellColumn: column row: rowIndex [
^ FTCellMorph new
		addMorphBack: ((elements at: rowIndex) id) asStringMorph;
		yourself
]

{ #category : #'as yet unclassified' }
PrestamoDataSource >> librosCellColumn: column row: rowIndex [
|tabla boton|
boton := BotonGenerico_UI new.
tabla := Tabla_UI crearLConDataSource: (LibroDataSource elements: ((elements at: rowIndex) libros)) ancho: 500 altura: 200.
^ FTCellMorph new
		addMorphBack: (boton inicializarConAccion: [Ventana_UI crearConMorph: tabla]; label: 'Ver libros');
		yourself
]