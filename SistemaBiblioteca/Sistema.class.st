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
|libro1 libro2 libro3 libro4 bib1 bib2 bib3 bib4 bib5 bib6 user1 colBUser1 colBUser2 user2 admin pres1 pres2 col1 col2 colAllLibros colAllB colAllU sistema|

libro1 := Libro crearConNombre: 'A-01' editorial: 'Mian' anioEdicion: 2001 autores: 1.
libro2 := Libro crearConNombre: 'B-45' editorial: 'Yuugami' anioEdicion: 2011 autores: 1.
libro3 := Libro crearConNombre: 'A-23' editorial: 'Mian' anioEdicion: 1991 autores: 1.
libro4 := Libro crearConNombre: 'C-13' editorial: 'Mian' anioEdicion: 1968 autores: 1.

colAllLibros := OrderedCollection new.
colAllLibros add: libro1; add: libro2; add: libro3; add: libro4.

bib1 := Biblioteca crearConId: 1 direccion: 'Irigoyen 280' nombre: 'Biblioteca Pública Provincial del Neuquén' telefono: 23456 nombreRepresentante: 'Yo'.
bib1 setColLibros: (colAllLibros copyFrom: 1 to: 4).
bib2 := Biblioteca crearConId: 2 direccion: 'Boulevard Francisco Arro 352' nombre: 'Biblioteca Pública de Carmen de Patagones' telefono: 12345 nombreRepresentante: 'Zo'.
bib2 setColLibros: (colAllLibros copyFrom: 1 to: 4).
bib3 := Biblioteca crearConId: 3 direccion: 'Dr. Mantero 318' nombre: 'Biblioteca Maestro Trombotto' telefono: 12345 nombreRepresentante: 'Zo'.
bib3 setColLibros: (colAllLibros copyFrom: 1 to: 4).
bib4 := Biblioteca crearConId: 4 direccion: 'Buenos Aires 131' nombre: 'Biblioteca Provincial 9 de Julio' telefono: 12345 nombreRepresentante: 'Zo'.
bib4 setColLibros: (colAllLibros copyFrom: 1 to: 4).
bib5 := Biblioteca crearConId: 5 direccion: 'Dr. Fleming 240' nombre: 'Biblioteca Ricardo Güiraldes' telefono: 12345 nombreRepresentante: 'Zo'.
bib5 setColLibros: (colAllLibros copyFrom: 1 to: 4).
bib6 := Biblioteca crearConId: 6 direccion: 'República Bolivariana de Venezuela 1538' nombre: 'Biblioteca Martín del Barco Centenera' telefono: 12345 nombreRepresentante: 'Zo'.
bib6 setColLibros: (colAllLibros copyFrom: 1 to: 4).

colAllB := OrderedCollection new.
colAllB add: bib1; add: bib2; add: bib3; add: bib4; add: bib5; add: bib6.

colBUser1 := OrderedCollection new. colBUser1 add: bib1; add: bib4; add: bib6.
colBUser2 := OrderedCollection new. colBUser2 add: bib2; add: bib3; add: bib5.

user1 := UsuarioComun crearConNombre: 'Ignacio' apellido: 'Navarro' dni: 44481878 contraseña: 'asd'. user1 setBibliotecasInteres: colBUser1  .
user2 := UsuarioPlus crearConNombre: 'Sebastián' apellido: 'Navarro' dni: 32124345 contraseña: 'zxc'. user2 setBibliotecasInteres: colBUser2 .
admin := Usuario crearConNombre: 'admin' apellido: 'admin' dni: 12345678 contraseña: 'admin'.

colAllU := OrderedCollection new.
colAllU add: user1; add: user2; add: admin.

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

{ #category : #usuarios }
Sistema >> agregarUsuario: unUsuario [
(self buscarUsuarioConDni: (unUsuario dni)) ifNil: [ colUsuarios add: unUsuario . ] ifNotNil: [ ^false ].
^ true
]

{ #category : #'as yet unclassified' }
Sistema >> buscarBibliotecaConId: unaId [
^ colBibliotecas detect: [ :b | b id = (unaId asInteger) ] ifNone: [ nil ].
]

{ #category : #'as yet unclassified' }
Sistema >> buscarUsuarioConDni: unDni [
^ colUsuarios detect: [ :u | u dni = unDni asNumber] ifNone: [ nil ].
]

{ #category : #'as yet unclassified' }
Sistema >> eliminarUsuario: unDni [
colUsuarios remove: (self buscarUsuarioConDni: unDni) ifAbsent: [^false].
^true
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
Sistema >> getPrestamosDeUsuario: unDni [
|colTotal colAux|
colTotal := OrderedCollection new.
colBibliotecas do: [ :b | colAux := (b getPrestamosDeUsuario: unDni). colAux ifNotEmpty: [colTotal addAll: colAux] ].
^ colTotal 
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
"
controlDiario := 
	[ Delay forSeconds: 86400.
	colBibliotecas do: [ :b | presTemp := b getPrestamos. presTemp do: [ :p | (p fechaLimite = Date tomorrow) ifTrue: [ (colUsuarios detect: [ :u | u dni = p dni ]) multarConDias: 7]  ]  ]
	] newProcess.
controlDiario name: 'Control Prestamos'.
controlDiario resume.
"
]

{ #category : #'as yet unclassified' }
Sistema >> obtenerIDBibliotecaSiguiente [
|idRetorno|
colBibliotecas ifNil: [ idRetorno := 1 ] ifNotNil: [ idRetorno := colBibliotecas size + 1 ].
^ idRetorno 
]
