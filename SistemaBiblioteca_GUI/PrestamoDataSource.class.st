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
tabla := Tabla_UI crearLConDataSource: (LibroDataSource elements: ((elements at: rowIndex) libros)) ancho: 800 altura: 300.
^ FTCellMorph new
		addMorphBack: (boton definirAccion: [Ventana_UI crearConMorph: tabla]; label: 'Ver libros';color: (Color r: 0.4 g: 0.8 b: 0.6));
		yourself
]

{ #category : #updating }
PrestamoDataSource >> update: unCambio [

"debe informarse que operacion se realizo, ya que la coleccion de prestamos de la tabla no apunta a la coleccion de prestamos de cada biblioteca, y por ende no se reflejan los cambios en la coleccion de la tabla"
((unCambio at: 1) = 1) ifTrue: [ elements add: (unCambio at: 2). ].
((unCambio at: 1) = 2) ifTrue: [ elements remove: (unCambio at: 2). ].
self tableRefresh.
]
