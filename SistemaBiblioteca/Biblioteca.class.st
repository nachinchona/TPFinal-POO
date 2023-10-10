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
		'cantDiasPrestamo'
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
Biblioteca class >> crearConId: unId direccion: unaDireccion nombre: unNombre telefono: unTelefono nombreRepresentante: unNombreRepresentante cantDiasPrestamo: unK [
|unaBiblioteca|
unaBiblioteca := self new.
unaBiblioteca inicializarConId:  unId direccion: unaDireccion nombre: unNombre telefono: unTelefono    nombreRepresentante: unNombreRepresentante cantDiasPrestamo: unK.
^unaBiblioteca
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
]

{ #category : #'as yet unclassified' }
Biblioteca >> inicializarConId: unId direccion: unaDireccion nombre: unNombre telefono: unTelefono nombreRepresentante: unNombreRepresentante cantDiasPrestamo: unK [

id := unId.
direccion := unaDireccion.
nombre := unNombre .
telefono := unTelefono.
nombreRepresentante := unNombreRepresentante.
colLibros := OrderedCollection new.
colPrestamos := OrderedCollection new.
cantDiasPrestamo := unK.
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
Biblioteca >> registrarPrestamoConLibros: unaColLibros deUsuario: unUsuario [
|unPrestamo cantLibros tienePrestamo nuevaId colVerificada|
"chequeos:
	detecta si el usuario está multado
	detecta si el usuario tiene un préstamo activo en la colección de préstamos
	1. Cantidad de libros entre 1 y 5
	2. Que los libros pertenezcan a la biblioteca
	3. Que los libros pedidos que ya estén en préstamo se quiten de la solicitud (se creará una nueva colección con libros disponibles)
"
(unUsuario estaMultado) ifFalse:
[ 
colVerificada := OrderedCollection new.
nuevaId := colPrestamos size + 1.
"detecta si el Usuario tiene un préstamo activo en la colección de préstamos"
tienePrestamo := (colPrestamos anySatisfy:  [ :xPrestamo | xPrestamo dni = unUsuario dni]).
tienePrestamo ifFalse: 
	[
	cantLibros := unaColLibros size.
	
	(cantLibros > 0 & cantLibros <= 5) ifTrue: (unaColLibros do: [ :unLibro |  (unLibro estaEnDeuda) ifFalse: [colVerificada add: unLibro. ]. 
	((colLibros includes: unLibro) & (unLibro estaEnDeuda)not) ifTrue: [unLibro marcarConDni: unUsuario ] ]).
	(colVerificada isEmpty) ifFalse: 
		[
		"Si la colección de libros verificada no es vacía, se crea el préstamo con los libros disponibles"	
		unPrestamo := Prestamo new. 
		unPrestamo inicializarPrestamoConId: nuevaId conLibros: colVerificada deUsuario: unUsuario conDias: cantDiasPrestamo.
		colPrestamos add: unPrestamo 
		]
	] .	
] .
"retorna el valor de éxito de la operación"
^ (unPrestamo notNil)
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
