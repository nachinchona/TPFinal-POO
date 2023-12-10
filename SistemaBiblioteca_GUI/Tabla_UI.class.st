Class {
	#name : #'Tabla_UI',
	#superclass : #FTTableMorph,
	#category : #'SistemaBiblioteca_GUI'
}

{ #category : #'as yet unclassified' }
Tabla_UI class >> crearBConDataSource: unaDataSource ancho: unAncho altura: unaAltura [
|tabla columnas|
tabla := self new extent: unAncho@unaAltura;
addColumn: (FTColumn id: 'ID'); addColumn: (FTColumn id: 'Nombre'); addColumn: (FTColumn id: 'Dirección'); addColumn: (FTColumn id: 'Teléfono'); addColumn: (FTColumn id: 'Nombre representante');
dataSource: unaDataSource;
		beMultipleSelection;
		beResizable;
		yourself.
tabla secondarySelectionColor: tabla selectionColor.
columnas := (tabla columns).
(columnas at: 1) width: 20.
(columnas at: 2) width: 280.
(columnas at: 4) width: 100.
(columnas at: 5) width: 150.
^ tabla 
]

{ #category : #'as yet unclassified' }
Tabla_UI class >> crearLConDataSource: unaDataSource ancho: unAncho altura: unaAltura [
|tabla|
tabla := self new extent: unAncho@unaAltura;
addColumn: (FTColumn id: 'Nombre'); addColumn: (FTColumn id: 'Editorial'); addColumn: (FTColumn id: 'Año de publicación'); addColumn: (FTColumn id: 'Autores');
dataSource: unaDataSource;
		beMultipleSelection;
		beResizable;
		yourself.
tabla secondarySelectionColor: tabla selectionColor.
^ tabla 
]

{ #category : #'as yet unclassified' }
Tabla_UI class >> crearPConDataSource: unaDataSource ancho: unAncho altura: unaAltura [
|tabla|
tabla := self new extent: unAncho@unaAltura;
addColumn: (FTColumn id: 'ID'); addColumn: (FTColumn id: 'Fecha de realización'); addColumn: (FTColumn id: 'Fecha límite'); addColumn: (FTColumn id: 'Libros');
dataSource: unaDataSource;
		beMultipleSelection;
		beResizable;
		yourself.
tabla secondarySelectionColor: tabla selectionColor.
^ tabla 
]

{ #category : #'as yet unclassified' }
Tabla_UI class >> crearUConDataSource: unaDataSource ancho: unAncho altura: unaAltura [
|tabla|
tabla := self new extent: unAncho@unaAltura;
addColumn: (FTColumn id: 'DNI'); addColumn: (FTColumn id: 'Nombre'); addColumn: (FTColumn id: 'Apellido'); addColumn: (FTColumn id: 'Multado'); addColumn: (FTColumn id: 'Bib. interés'); addColumn: (FTColumn id: 'Préstamos');
dataSource: unaDataSource;
		beMultipleSelection;
		beResizable;
		yourself.
tabla secondarySelectionColor: tabla selectionColor.
^ tabla 
]
