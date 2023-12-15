Class {
	#name : #BibliotecaDataSource,
	#superclass : #FTSimpleDataSource,
	#category : #'SistemaBiblioteca_GUI'
}

{ #category : #accessing }
BibliotecaDataSource >> cellColumn: column row: rowIndex [

(column id = 'ID') ifTrue: [ ^ self idCellColumn: column row: rowIndex ].
(column id = 'Nombre') ifTrue: [ ^ self nombreCellColumn: column row: rowIndex ].
(column id = 'Dirección') ifTrue: [ ^ self direccionCellColumn: column row: rowIndex ].
(column id = 'Teléfono') ifTrue: [ ^ self telefonoCellColumn: column row: rowIndex ].
(column id = 'Nombre representante') ifTrue: [ ^ self nombreRCellColumn: column row: rowIndex ].
(column id = 'Préstamos') ifTrue: [ ^ self prestamosCellColumn: column row: rowIndex ].

]

{ #category : #'as yet unclassified' }
BibliotecaDataSource >> direccionCellColumn: column row: rowIndex [
^ FTCellMorph new
		addMorphBack: ((elements at: rowIndex) direccion) asStringMorph;
		yourself
]

{ #category : #'as yet unclassified' }
BibliotecaDataSource >> idCellColumn: column row: rowIndex [
^ FTCellMorph new
		addMorphBack: ((elements at: rowIndex) id) asStringMorph;
		yourself
]

{ #category : #'as yet unclassified' }
BibliotecaDataSource >> nombreCellColumn: column row: rowIndex [
^ FTCellMorph new
		addMorphBack: ((elements at: rowIndex) nombre) asStringMorph;
		yourself
]

{ #category : #'as yet unclassified' }
BibliotecaDataSource >> nombreRCellColumn: column row: rowIndex [
^ FTCellMorph new
		addMorphBack: ((elements at: rowIndex) nombreRepresentante) asStringMorph;
		yourself
]

{ #category : #'as yet unclassified' }
BibliotecaDataSource >> prestamosCellColumn: column row: rowIndex [
|tabla boton|
boton := BotonGenerico_UI new.
tabla := Tabla_UI crearPConDataSource: (PrestamoDataSource elements: (self elementAt: rowIndex) getPrestamos ) ancho: 500 altura: 200.
^ FTCellMorph new
		addMorphBack: (boton definirAccion: [Ventana_UI crearConMorph: tabla]; label: 'Ver préstamos'; color: (Color r: 0.4 g: 0.8 b: 0.6));
		yourself
]

{ #category : #'as yet unclassified' }
BibliotecaDataSource >> telefonoCellColumn: column row: rowIndex [
^ FTCellMorph new
		addMorphBack: ((elements at: rowIndex) telefono) asStringMorph;
		yourself
]
