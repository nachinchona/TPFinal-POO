Class {
	#name : #BDataSource,
	#superclass : #FTSimpleDataSource,
	#category : #'SistemaBiblioteca_TEST'
}

{ #category : #accessing }
BDataSource >> cellColumn: column row: rowIndex [

(column id = 'ID') ifTrue: [ ^ self idCellColumn: column row: rowIndex ].
(column id = 'Dirección') ifTrue: [ ^ self direccionCellColumn: column row: rowIndex ].
(column id = 'Nombre') ifTrue: [ ^ self nombreCellColumn: column row: rowIndex ].
]

{ #category : #'as yet unclassified' }
BDataSource >> direccionCellColumn: column row: rowIndex [
^ FTCellMorph new
		addMorphBack: ((elements at: rowIndex) direccion) asStringMorph;
		yourself
]

{ #category : #'as yet unclassified' }
BDataSource >> idCellColumn: column row: rowIndex [
^ FTCellMorph new
		addMorphBack: ((elements at: rowIndex) id) asStringMorph;
		yourself
]

{ #category : #'as yet unclassified' }
BDataSource >> mCellColumn: column row: rowIndex [
^ FTCellMorph new
		addMorphBack: (elements at: rowIndex) asMorph;
		yourself
]

{ #category : #'as yet unclassified' }
BDataSource >> nombreCellColumn: column row: rowIndex [
^ FTCellMorph new
		addMorphBack: ((elements at: rowIndex) nombre) asStringMorph;
		yourself
]
