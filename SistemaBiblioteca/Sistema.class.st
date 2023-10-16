Class {
	#name : #Sistema,
	#superclass : #Object,
	#instVars : [
		'colBibliotecas',
		'colUsuarios',
		'colAutores'
	],
	#category : #SistemaBiblioteca
}

{ #category : #accessing }
Sistema class >> default [
|libro1 libro2 libro3 libro4 bib1 bib2 user1 user2 pres1 pres2 col1 col2 colAllLibros colAllB colAllU sistema|

libro1 := Libro crearConNombre: 'A-01' editorial: 'Mian' anioEdicion: 2001 autores: 1.
libro2 := Libro crearConNombre: 'B-45' editorial: 'Yuugami' anioEdicion: 2011 autores: 1.
libro3 := Libro crearConNombre: 'A-23' editorial: 'Mian' anioEdicion: 1991 autores: 1.
libro4 := Libro crearConNombre: 'C-13' editorial: 'Mian' anioEdicion: 1968 autores: 1.

colAllLibros := OrderedCollection new.
colAllLibros add: libro1; add: libro2; add: libro3; add: libro4.

bib1 := Biblioteca crearConId: 1 direccion: 'Anin 1' nombre: 'Jan 1' telefono: 23456 nombreRepresentante: 'Yo'.
bib1 setColLibros: colAllLibros.
bib2 := Biblioteca crearConId: 2 direccion: 'Unio 19' nombre: 'Jan 2' telefono: 12345 nombreRepresentante: 'Zo'.
bib2 setColLibros: colAllLibros.

colAllB := OrderedCollection new.
colAllB add: bib1; add: bib2.

user1 := Usuario crearConNombre: 'Ignacio' apellido: 'Navarro' dni: 44481878 contraseña: 'asd'.
user2 := Usuario crearConNombre: 'Sebastián' apellido: 'Navarro' dni: 32124345 contraseña: 'zxc'.

colAllU := OrderedCollection new.
colAllU add: user1; add: user2.

col1 := OrderedCollection new. 
col1 add: libro1; add: libro4.

col2 := OrderedCollection new. 
col2 add: libro2; add: libro3; add: libro1.

pres1 := bib1 registrarPrestamoConLibros: col1 deUsuario: user1.
pres2 := bib1 registrarPrestamoConLibros: col2 deUsuario: user2.

sistema := self new.
sistema inicializarSistemaConColBibliotecas: colAllB colUsuarios: colAllU yColAutores: 1.

^ sistema
]

{ #category : #'as yet unclassified' }
Sistema >> agregarBiblioteca: unaBiblioteca [
colBibliotecas add: unaBiblioteca .
]

{ #category : #'as yet unclassified' }
Sistema >> buscarBibliotecaConId: unaId [
colBibliotecas detect: [ :b | b id = unaId ] ifNone: [ nil ].
]

{ #category : #'as yet unclassified' }
Sistema >> buscarUsuarioConDni: unDni [
^ colUsuarios detect: [ :u | u dni = unDni asInteger] ifNone: [ nil ].
]

{ #category : #'as yet unclassified' }
Sistema >> getAutores [
^ colAutores   
]

{ #category : #'as yet unclassified' }
Sistema >> getBibliotecas [
^ colBibliotecas 
]

{ #category : #'as yet unclassified' }
Sistema >> getUsuarios [
^ colUsuarios  
]

{ #category : #'as yet unclassified' }
Sistema >> inicializarSistemaConColBibliotecas: colB colUsuarios: colU yColAutores: colA [
|controlDiario presTemp|
colBibliotecas := colB.
colAutores := colA.
colUsuarios := colU.
controlDiario := 
	[ Delay forSeconds: 86400.
	colBibliotecas do: [ :b | presTemp := b getPrestamos. presTemp do: [ :p | (p fechaLimite = Date tomorrow) ifTrue: [ (colUsuarios detect: [ :u | u dni = p dni ]) multarConDias: 7]  ]  ]
	] newProcess.
controlDiario name: 'Control Prestamos'.
controlDiario resume.
]

{ #category : #'as yet unclassified' }
Sistema >> obtenerIDBibliotecaSiguiente [
|idRetorno|
colBibliotecas ifNil: [ idRetorno := 1 ] ifNotNil: [ idRetorno := colBibliotecas size + 1 ].
^ idRetorno 
]
