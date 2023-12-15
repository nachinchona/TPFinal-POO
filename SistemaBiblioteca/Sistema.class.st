Class {
	#name : #Sistema,
	#superclass : #Object,
	#instVars : [
		'colBibliotecas',
		'colUsuarios',
		'colAutores',
		'cantDiasMulta'
	],
	#category : #SistemaBiblioteca
}

{ #category : #accessing }
Sistema class >> default [
|libro1 libro2 libro3 libro4 libro5 libro6 bib1 bib2 bib3 bib4 bib5 bib6 user1 colBUser1 colBUser2 user2 user3 col1 col2 col3 col4 col5 colA colAllLibros colAllB colAllU sistema|

colA := OrderedCollection new.
colA add: 'Marcel Proust'.
colA add: 'James Joyce'.
colA add: 'Miguel de Cervantes'.
colA add: 'Gabriel Garcia Marquez'.
colA add: 'Maxwell Cresswell'; add: 'George Hughes'.
colA add: 'Ramez Elmasri'; add: 'Shamkant Navathe'.

libro1 := Libro crearConNombre: 'In Search of Lost Time' editorial: 'Grasset' anioEdicion: 1913 autores: {colA at: 1}.
libro2 := Audiolibro crearConNombre: 'Ulysses' editorial: 'Shakespeare and Company' anioEdicion: 1922 autores: {colA at: 2}.
libro3 := Libro crearConNombre: 'Don Quijote' editorial: '	Francisco de Robles' anioEdicion: 1605 autores: {colA at: 3}.
libro4 := Libro crearConNombre: 'Cien años de soledad' editorial: 'Editorial Sudamericana' anioEdicion: 1967 autores: {colA at: 4}.
libro5 := Libro crearConNombre: 'A New Introduction to Modal Logic' editorial: 'Charles Scribner''s Sons' anioEdicion: 1925 autores: {colA at: 5. colA at: 6}.
libro6 := Libro crearConNombre: 'Fundamentals of Database Systems' editorial: 'Richard Bentley' anioEdicion: 1851 autores: {colA at: 7. colA at: 8}.

colAllLibros := OrderedCollection new.
colAllLibros add: libro1; add: libro2; add: libro3; add: libro4; add: libro5; add: libro6.

bib1 := Biblioteca crearConId: 1 direccion: 'Irigoyen 280' nombre: 'Biblioteca Pública Provincial del Neuquén' telefono: 23456 nombreRepresentante: 'Yo'.
bib1 setColLibros: colAllLibros deepCopy.
bib2 := Biblioteca crearConId: 2 direccion: 'Boulevard Francisco Arro 352' nombre: 'Biblioteca Pública de Carmen de Patagones' telefono: 12345 nombreRepresentante: 'Zo'.
bib2 setColLibros: colAllLibros deepCopy.
bib3 := Biblioteca crearConId: 3 direccion: 'Dr. Mantero 318' nombre: 'Biblioteca Maestro Trombotto' telefono: 12345 nombreRepresentante: 'Zo'.
bib3 setColLibros: colAllLibros deepCopy.
bib4 := Biblioteca crearConId: 4 direccion: 'Buenos Aires 131' nombre: 'Biblioteca Provincial 9 de Julio' telefono: 12345 nombreRepresentante: 'Zo'.
bib4 setColLibros: colAllLibros deepCopy.
bib5 := Biblioteca crearConId: 5 direccion: 'Dr. Fleming 240' nombre: 'Biblioteca Ricardo Güiraldes' telefono: 12345 nombreRepresentante: 'Zo'.
bib5 setColLibros: colAllLibros deepCopy.
bib6 := Biblioteca crearConId: 6 direccion: 'República Bolivariana de Venezuela 1538' nombre: 'Biblioteca Martín del Barco Centenera' telefono: 12345 nombreRepresentante: 'Zo'.
bib6 setColLibros: colAllLibros deepCopy.

colAllB := OrderedCollection new.
colAllB add: bib1; add: bib2; add: bib3; add: bib4; add: bib5; add: bib6.

colBUser1 := OrderedCollection new. colBUser1 add: bib1; add: bib4; add: bib6.
colBUser2 := OrderedCollection new. colBUser2 add: bib1; add: bib2; add: bib3; add: bib5.

user1 := UsuarioComun crearConNombre: 'Ignacio' apellido: 'Navarro' dni: 44481878 contraseña: 'asd'. user1 setBibliotecasInteres: colBUser1  .
user2 := UsuarioPlus crearConNombre: 'Sebastián' apellido: 'Navarro' dni: 32123456 contraseña: 'zxc'. user2 setBibliotecasInteres: colBUser2 . user2 pagarCuota.
user3 := UsuarioComun crearConNombre: 'Pepe' apellido: 'Mujica' dni: 12345678 contraseña: 'asd'. user3 setBibliotecasInteres: colAllB  .

colAllU := OrderedCollection new.
colAllU add: user1; add: user2; add: user3.

col1 := OrderedCollection new. 
col1 add: (bib1 libros at: 1); add: (bib1 libros at: 5).
"col1 add: libro1; add: libro5. B1"

col2 := OrderedCollection new. 
"col2 add: libro2; add: libro3; add: libro4. B2"
col2 add: (bib1 libros at: 2); add: (bib1 libros at: 3); add: (bib1 libros at: 4).

col3 := OrderedCollection new. 
"col3 add: libro5; add: libro6. B3"
col3 add: (bib4 libros at: 5); add: (bib4 libros at: 6).

col4 := OrderedCollection new. 
"col4 add: libro5; add: libro6. B5"
col4 add: (bib5 libros at: 5); add: (bib5 libros at: 6).

col5 := OrderedCollection new. 
"col3 add: libro2; add: libro6. B1"
col5 add: (bib3 libros at: 2); add: (bib3 libros at: 3).

bib1 registrarPrestamoConLibros: col1 deUsuario: user1.
bib4 registrarPrestamoConLibros: col3 deUsuario: user1.
bib1 registrarPrestamoConLibros: col2 deUsuario: user2.
bib5 registrarPrestamoConLibros: col4 deUsuario: user3.
bib3 registrarPrestamoVencidoConLibros: col5 deUsuario: user3.

sistema := self new.
sistema inicializarSistemaConColBibliotecas: colAllB colUsuarios: colAllU colAutores: 1 cantDiasMulta: 7.

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
Sistema >> añadirAutor: unAutor [
(colAutores anySatisfy: [ :a | a = unAutor ]) ifFalse: [colAutores add: unAutor].
]

{ #category : #'as yet unclassified' }
Sistema >> añadirLibro: unLibro enBib: unaBiblioteca [
unaBiblioteca añadirLibro: unLibro.
(unLibro autores) do: [ :a | self añadirAutor: a ]. 
]

{ #category : #'as yet unclassified' }
Sistema >> buscarBibliotecaConId: unaId [
^ colBibliotecas detect: [ :b | b id = (unaId asInteger) ] ifNone: [ nil ].
]

{ #category : #'as yet unclassified' }
Sistema >> buscarUsuarioConDni: unDni [
^ colUsuarios detect: [ :u | u dni = unDni asNumber] ifNone: [ nil ].
]

{ #category : #accessing }
Sistema >> cantDiasMulta [
^ cantDiasMulta
]

{ #category : #'as yet unclassified' }
Sistema >> devolverPrestamo: unDni deBib: unaIdBib [
(self buscarBibliotecaConId: unaIdBib) devolverPrestamo: unDni.
self changed.
]

{ #category : #'as yet unclassified' }
Sistema >> eliminarUsuario: unDni [
colUsuarios remove: (self buscarUsuarioConDni: unDni) ifAbsent: [^false].
^true
]

{ #category : #'as yet unclassified' }
Sistema >> generarListadoUsuariosRetrasados [
|colRetorno|

colRetorno := OrderedCollection new.

colUsuarios do: [ :u | |idBiblioteca| idBiblioteca :=  self verificarMulta: u dni. idBiblioteca ifNotNil: [ colRetorno add: {u. self verificarMulta: u dni.} ] ].

^ colRetorno
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
colBibliotecas do: [ :b | colAux := (b getPrestamosDeUsuario: unDni). colAux ifNotEmpty: [colTotal addAll: colAux]. ].
^ colTotal 
]

{ #category : #'as yet unclassified' }
Sistema >> getUsuarios [
^ colUsuarios  
]

{ #category : #'as yet unclassified' }
Sistema >> inicializarSistemaConColBibliotecas: colB colUsuarios: colU colAutores: colA cantDiasMulta: unK [

colBibliotecas := colB.
colAutores := colA.
colUsuarios := colU.
cantDiasMulta := unK.

"
|controlDiario presTemp|
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
colBibliotecas ifNil: [ ^ 1 ].
^ colBibliotecas size + 1 
]

{ #category : #'as yet unclassified' }
Sistema >> verificarMulta: unDni [
|col retorno usuario|
usuario := self buscarUsuarioConDni: unDni.
col := (self getPrestamosDeUsuario: unDni).
retorno := (col detect: [ :p | (p fechaLimite) isBefore: (Date today) ] ifNone: [^ nil]).
(retorno) ifNotNil: [ usuario multarConDias: 7 ].
"retorna la primera biblioteca que detecta deuda, sino nil"
^ retorno idBiblioteca
]
