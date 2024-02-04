Class {
	#name : #Biblioteca,
	#superclass : #Object,
	#instVars : [
		'id',
		'direccion',
		'nombre',
		'telefono',
		'nombreRepresentante',
		'colLibros',
		'colPrestamos',
		'cantDiasPrestamo',
		'ultIdPrestamo'
	],
	#category : #SistemaBiblioteca
}

{ #category : #'as yet unclassified' }
Biblioteca class >> crearConId: unId direccion: unaDireccion nombre: unNombre telefono: unTelefono nombreRepresentante: unNombreRepresentante [
|unaBiblioteca|
unaBiblioteca := self new.
unaBiblioteca inicializarConId:  unId direccion: unaDireccion nombre: unNombre telefono: unTelefono    nombreRepresentante: unNombreRepresentante.
^unaBiblioteca
]

{ #category : #'as yet unclassified' }
Biblioteca >> añadirLibro: unLibro [
colLibros add: unLibro.
self changed.
^ true
]

{ #category : #'as yet unclassified' }
Biblioteca >> desmarcarPrestamo: unPrestamo [
unPrestamo libros do: [ :l | l desmarcar ]
]

{ #category : #'as yet unclassified' }
Biblioteca >> devolverPrestamo: unDni [
|prestamo|
prestamo := colPrestamos detect: [ :p | p esDeUsuario: unDni ].
colPrestamos remove: prestamo.
self desmarcarPrestamo: prestamo.
self changed: {2. prestamo.}.
]

{ #category : #'as yet unclassified' }
Biblioteca >> devolverPrestamoAL: unDni [
|prestamo|
prestamo := colPrestamos detect: [ :p | p dni = unDni & ('*P' match: p id)].
colPrestamos remove: prestamo.
self desmarcarPrestamo: prestamo.
self changed: {2. prestamo.}.
]

{ #category : #accessing }
Biblioteca >> direccion [

	^ direccion
]

{ #category : #accessing }
Biblioteca >> direccion: anObject [

	direccion := anObject
]

{ #category : #'as yet unclassified' }
Biblioteca >> getPrestamos [
^ colPrestamos 
]

{ #category : #'as yet unclassified' }
Biblioteca >> getPrestamosDeUsuario: unDni [
|colRetorno|
colRetorno := colPrestamos select: [ :p | (p esDeUsuario: unDni) ].
^ colRetorno
]

{ #category : #'as yet unclassified' }
Biblioteca >> getPrestamosVencidosDeUsuario: unDni [

"método antes utilizado para generarListadoUsuariosRetrasados (sin uso actual pero puede ser útil)"
|colRetorno|
colRetorno := colPrestamos select: [ :p | (p esDeUsuario: unDni) and: (p estaVencido) ].
^ colRetorno
]

{ #category : #'as yet unclassified' }
Biblioteca >> getUsuarioDeudor: unDni [

"a diferencia de obtener todos los préstamos vencidos, este método se detiene al encontrar el primer préstamo vencido, retornando entonces el dni del usuario deudor y su biblioteca correspondiente"
(colPrestamos anySatisfy: [ :p | (p esDeUsuario: unDni) and: (p estaVencido) ])
ifTrue: [^ {unDni. id.}] ifFalse: [^ nil ].
]

{ #category : #accessing }
Biblioteca >> id [

	^ id
]

{ #category : #accessing }
Biblioteca >> id: anObject [

	id := anObject
]

{ #category : #'as yet unclassified' }
Biblioteca >> inicializarConId: unId direccion: unaDireccion nombre: unNombre telefono: unTelefono nombreRepresentante: unNombreRepresentante [

id := unId.
direccion := unaDireccion.
nombre := unNombre .
telefono := unTelefono.
nombreRepresentante := unNombreRepresentante.
colLibros := OrderedCollection new.
colPrestamos := OrderedCollection new.
cantDiasPrestamo := 7.
ultIdPrestamo := 0.
]

{ #category : #'as yet unclassified' }
Biblioteca >> libros [
^ colLibros
]

{ #category : #accessing }
Biblioteca >> nombre [

	^ nombre
]

{ #category : #accessing }
Biblioteca >> nombre: anObject [

	nombre := anObject
]

{ #category : #accessing }
Biblioteca >> nombreRepresentante [

	^ nombreRepresentante
]

{ #category : #accessing }
Biblioteca >> nombreRepresentante: anObject [

	nombreRepresentante := anObject
]

{ #category : #'as yet unclassified' }
Biblioteca >> quitarLibro: unLibro [
colLibros remove: unLibro .
self changed.
^ true

]

{ #category : #'as yet unclassified' }
Biblioteca >> registrarPrestamoConLibros: unaColLibros deUsuario: unUsuario [
|unPrestamo cantLibros tienePrestamo nuevaId colVerificada colPlus esPlus|
"chequeos:
	detecta si el usuario está multado
	detecta si el usuario tiene un préstamo activo en la colección de préstamos
	1. Cantidad de libros entre 1 y 5
	2. Que los libros pertenezcan a la biblioteca
	3. Que los libros pedidos que ya estén en préstamo se quiten de la solicitud (se creará una nueva colección con libros disponibles)
"
esPlus := unUsuario esPlus.
colPlus := OrderedCollection new.
(unUsuario estaMultado) ifTrue: [^ false ]
ifFalse:
[ 
colVerificada := OrderedCollection new.
ultIdPrestamo := ultIdPrestamo + 1.
nuevaId := ((id)asString, '-', (ultIdPrestamo)asString)asString.

"detecta si el Usuario tiene un préstamo activo en la colección de préstamos"
tienePrestamo := self usuarioTienePrestamo: unUsuario.
tienePrestamo ifTrue: [^ false ]
ifFalse: 
	[
	cantLibros := unaColLibros size.
	
	(cantLibros > 0 & cantLibros <= 5) ifFalse: [^ false ]
	ifTrue: 
	[ unaColLibros do: [ :unLibro | (unLibro estaEnDeuda) 
												ifFalse: [
																(unLibro esAudioLibro)
																ifTrue: [ 
																			esPlus 
																			ifTrue: [ colPlus add: unLibro. unLibro marcarConDni: unUsuario dni ]
																			ifFalse: [ ^ false ] ] 
																ifFalse: [ colVerificada add: unLibro. unLibro marcarConDni: unUsuario dni ].
															]
												ifTrue:  [^ false].
   ].
											   
	(colVerificada isEmpty) ifFalse: 
		[
		"Si la colección de libros verificada no es vacía, se crea el préstamo con los libros disponibles"	
		unPrestamo := Prestamo new. 
		unPrestamo inicializarPrestamoConId: nuevaId conLibros: colVerificada deUsuario: unUsuario conDias: cantDiasPrestamo enBib: id.
		colPrestamos add: unPrestamo 
		].
	(colPlus isEmpty) ifFalse: 
		[
		"Si la colección de libros verificada plus no es vacía, se crea el préstamo con los libros disponibles"	
		unPrestamo := Prestamo new. 
		unPrestamo inicializarPrestamoConId: (nuevaId,'P') conLibros: colPlus deUsuario: unUsuario conDias: ((cantDiasPrestamo/2) ceiling) enBib: id.
		colPrestamos add: unPrestamo 
		].
	]

	]
] .

"
changed envia como argumento un arreglo dinamico con 1. la operacion realizada (1 adicion 2 removicion) y el prestamo en cuestion.
"
self changed: {1. unPrestamo.}.

^ true
]

{ #category : #'as yet unclassified' }
Biblioteca >> registrarPrestamoVencidoConLibros: unaColLibros deUsuario: unUsuario [ 
"metodo utilizado en mensaje default de Sistema para registrar un prestamo vencido a modo de testeo"
|unPrestamo cantLibros tienePrestamo nuevaId colVerificada colPlus esPlus|
"chequeos:
	detecta si el usuario está multado
	detecta si el usuario tiene un préstamo activo en la colección de préstamos
	1. Cantidad de libros entre 1 y 5
	2. Que los libros pertenezcan a la biblioteca
	3. Que los libros pedidos que ya estén en préstamo se quiten de la solicitud (se creará una nueva colección con libros disponibles)
"
esPlus := unUsuario esPlus.
colPlus := OrderedCollection new.
(unUsuario estaMultado) ifTrue: [Transcript show: 1.^ false ]
ifFalse:
[ 
colVerificada := OrderedCollection new.
ultIdPrestamo := ultIdPrestamo + 1.
nuevaId := ((id)asString, '-', (ultIdPrestamo)asString)asString.

"detecta si el Usuario tiene un préstamo activo en la colección de préstamos"
tienePrestamo := (colPrestamos anySatisfy:  [ :xPrestamo | xPrestamo dni = unUsuario dni]).
tienePrestamo ifTrue: [Transcript show: 2. ^ false ]
ifFalse: 
	[
	cantLibros := unaColLibros size.
	
	(cantLibros > 0 & cantLibros <= 5) ifFalse: [Transcript show: 3. ^ false ]
	ifTrue: 
	[ unaColLibros do: [ :unLibro | (unLibro estaEnDeuda) 
												ifFalse: [
																(unLibro esAudioLibro)
																ifTrue: [ 
																			esPlus 
																			ifTrue: [ colPlus add: unLibro ]
																			ifFalse: [ Transcript show: 4.^ false ] ] 
																ifFalse: [ colVerificada add: unLibro. ].
															]
												ifTrue:  [Transcript show: 6.^ false].
   ].
											   
	(colVerificada isEmpty) ifFalse: 
		[
		"Si la colección de libros verificada no es vacía, se crea el préstamo con los libros disponibles"	
		unPrestamo := Prestamo new. 
		unPrestamo inicializarPrestamoConId: nuevaId conLibros: colVerificada deUsuario: unUsuario conDias: cantDiasPrestamo enBib: id.
		colPrestamos add: unPrestamo 
		].
	(colPlus isEmpty) ifFalse: 
		[
		"Si la colección de libros verificada plus no es vacía, se crea el préstamo con los libros disponibles"	
		unPrestamo := Prestamo new. 
		unPrestamo inicializarPrestamoConId: nuevaId conLibros: colPlus deUsuario: unUsuario conDias: ((cantDiasPrestamo/2) ceiling) enBib: id.
		colPrestamos add: unPrestamo 
		].
	]

	]
] .

unPrestamo vencer.

"devuelve un arreglo dinamico con 1. la operacion realizada (1 adicion 2 removicion) y el prestamo en cuestion"
self changed: {1. unPrestamo.}.


^ true

]

{ #category : #initialization }
Biblioteca >> setColLibros: unaCol [
colLibros := unaCol.
]

{ #category : #initialization }
Biblioteca >> setDiasPrestamo: unaCantDias [
cantDiasPrestamo := unaCantDias .
]

{ #category : #accessing }
Biblioteca >> telefono [

	^ telefono
]

{ #category : #accessing }
Biblioteca >> telefono: anObject [

	telefono := anObject
]

{ #category : #'as yet unclassified' }
Biblioteca >> usuarioTienePrestamo: unUsuario [
^ colPrestamos anySatisfy:  [ :xPrestamo | xPrestamo dni = unUsuario dni]
]
