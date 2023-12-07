Class {
	#name : #LibroDataSource,
	#superclass : #FTSimpleDataSource,
	#category : #'SistemaBiblioteca_GUI'
}

{ #category : #'as yet unclassified' }
LibroDataSource >> anioCellColumn: column row: rowIndex [
^ FTCellMorph new
		addMorphBack: ((elements at: rowIndex) anioEdicion) asStringMorph;
		yourself

]

{ #category : #'as yet unclassified' }
LibroDataSource >> autoresCellColumn: column row: rowIndex [
|colAutores string|
colAutores := (elements at: rowIndex) autores.
string := ''.
colAutores do: [ :a | string := string, ', '].
^ FTCellMorph new
		addMorphBack: (string) asStringMorph;
		yourself

]

{ #category : #accessing }
LibroDataSource >> cellColumn: column row: rowIndex [
(column id = 'Nombre') ifTrue: [ ^ self nombreCellColumn: column row: rowIndex   ].
(column id = 'Editorial') ifTrue: [ ^ self editorialCellColumn: column row: rowIndex  ].
(column id = 'Año de publicación') ifTrue: [  ^ self anioCellColumn: column row: rowIndex ].
(column id = 'Autores') ifTrue: [  ^ self nombreCellColumn: column row: rowIndex ].
]

{ #category : #'as yet unclassified' }
LibroDataSource >> editorialCellColumn: column row: rowIndex [
^ FTCellMorph new
		addMorphBack: ((elements at: rowIndex) editorial) asStringMorph;
		yourself

]

{ #category : #'as yet unclassified' }
LibroDataSource >> nombreCellColumn: column row: rowIndex [
^ FTCellMorph new
		addMorphBack: ((elements at: rowIndex) nombre) asStringMorph;
		yourself

]
