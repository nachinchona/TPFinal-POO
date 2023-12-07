Class {
	#name : #'Table_TEST',
	#superclass : #FTTableMorph,
	#instVars : [
		'system'
	],
	#category : #'SistemaBiblioteca_TEST'
}

{ #category : #'as yet unclassified' }
Table_TEST class >> mostrarTablaConModel: model [
|ds  tabla|
ds := BDataSource elements: model rootNodes.
tabla := self new extent: 650@500;
addColumn: (FTColumn id: '#');
dataSource: ds; selectFirst;
		showFirstSelection;
		onAnnouncement: FTSelectionChanged do: [ :ann | ('rows selected: ' , ann newSelectedIndexes asString) crTrace ];
		onAnnouncement: FTStrongSelectionChanged do: [ :ann | ('double-click on row: ' , ann selectedIndex asString) crTrace ];
		beMultipleSelection;
		beResizable;
		yourself.
^ tabla openInWindow
]

{ #category : #'as yet unclassified' }
Table_TEST class >> mostrarTablaConSistema: system [
|ds bibliotecas tabla|
bibliotecas := system getBibliotecas .
ds := BDataSource elements: bibliotecas.
tabla := self new extent: 650@500;
addColumn: (FTColumn id: 'ID'); addColumn: (FTColumn id: 'Dirección'); addColumn: (FTColumn id: 'Nombre');
dataSource: ds; selectFirst;
		showFirstSelection;
		onAnnouncement: FTSelectionChanged do: [ :ann | ('rows selected: ' , ann newSelectedIndexes asString) crTrace ];
		onAnnouncement: FTStrongSelectionChanged do: [ :ann | ('double-click on row: ' , ann selectedIndex asString) crTrace ];
		beMultipleSelection;
		beResizable;
		yourself.
^ tabla 
]

{ #category : #'as yet unclassified' }
Table_TEST class >> mostrarTablaConSistema: system model: model [
|ds bibliotecas tabla|
bibliotecas := (system getBibliotecas) addAll: (model rootNodes) .
ds := BDataSource elements: bibliotecas.
tabla := self new extent: 650@500;
addColumn: (FTColumn id: '#');
addColumn: (FTColumn id: 'ID'); addColumn: (FTColumn id: 'Dirección'); addColumn: (FTColumn id: 'Nombre');
dataSource: ds; selectFirst;
		showFirstSelection;
		onAnnouncement: FTSelectionChanged do: [ :ann | ('rows selected: ' , ann newSelectedIndexes asString) crTrace ];
		onAnnouncement: FTStrongSelectionChanged do: [ :ann | ('double-click on row: ' , ann selectedIndex asString) crTrace ];
		beMultipleSelection;
		beResizable;
		yourself.
^ tabla openInWindow
]

{ #category : #'as yet unclassified' }
Table_TEST >> asignarSistema: unSistema [
system := unSistema .
]

{ #category : #'as yet unclassified' }
Table_TEST >> mostrarTabla [
|ds bibliotecas|
bibliotecas := system getBibliotecas .
ds := BDataSource elements: bibliotecas.
self addColumn: (FTColumn id: 'ID'); addColumn: (FTColumn id: 'Dirección'); addColumn: (FTColumn id: 'Nombre').

]
