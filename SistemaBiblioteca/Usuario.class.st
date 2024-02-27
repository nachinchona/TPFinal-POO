Class {
	#name : #Usuario,
	#superclass : #Object,
	#instVars : [
		'nombre',
		'apellido',
		'dni',
		'contrasenia',
		'multado',
		'fechaTerminacionMulta',
		'bibliotecasInteres'
	],
	#category : #SistemaBiblioteca
}

{ #category : #initialization }
Usuario class >> crearConNombre: unNombre apellido: unApellido dni: unDni contraseña: unaContraseña [
|unUsuario|
unUsuario := self new.
unUsuario inicializarConNombre: unNombre apellido: unApellido dni: unDni contraseña: unaContraseña.
^ unUsuario
]

{ #category : #accessing }
Usuario >> apellido [

	^ apellido
]

{ #category : #accessing }
Usuario >> apellido: anObject [

	apellido := anObject
]

{ #category : #initialization }
Usuario >> bibliotecasInteres [ 
^ bibliotecasInteres 
]

{ #category : #accessing }
Usuario >> contrasenia [

	^ contrasenia
]

{ #category : #accessing }
Usuario >> contrasenia: anObject [

	contrasenia := anObject
]

{ #category : #'as yet unclassified' }
Usuario >> crearPrestamoConBib: unaBiblioteca yLibros: unaColLibros [
|colVerificada|

colVerificada := OrderedCollection new.
unaColLibros do: [ :unLibro | (unLibro esAudioLibro) 
												ifFalse: [
																(unLibro estaEnDeuda)
																ifFalse: [ colVerificada add: unLibro. unLibro marcar. ].
																"aquellos libros en deuda son ignorados"
															]
									  "si algun libro es audiolibro no pasa nada, simplemente no se agrega al prestamo"
   					  ].
											   
(colVerificada isEmpty) ifFalse: 
	[
	unaBiblioteca agregarPrestamoConLibros: colVerificada de: self. 
 	]
ifTrue:  [ ^ false ]. 

^ true
]

{ #category : #'as yet unclassified' }
Usuario >> desmultar [
multado := false.
]

{ #category : #accessing }
Usuario >> dni [

	^ dni
]

{ #category : #accessing }
Usuario >> dni: anObject [

	dni := anObject
]

{ #category : #'as yet unclassified' }
Usuario >> esDeUsuario: unPrestamo [
^ dni = unPrestamo dni
]

{ #category : #'as yet unclassified' }
Usuario >> esPlus [
"se pretende crear usuarios de acuerdo a sus subclases"
^ self subclassResponsibility  
]

{ #category : #'as yet unclassified' }
Usuario >> estaMultado [
^ multado 
]

{ #category : #'as yet unclassified' }
Usuario >> getDeuda [
|retorno|
bibliotecasInteres do: [ :b | retorno := b getUsuarioDeudor: self. retorno ifNotNil: [^ retorno ]].
^ nil
]

{ #category : #'as yet unclassified' }
Usuario >> getPrestamos [
|col|
col := OrderedCollection new.
bibliotecasInteres do: [ :u | |colAux| colAux := u getPrestamosDeUsuario: self. colAux ifNotEmpty: [col addAll: colAux].].
^ col
]

{ #category : #'as yet unclassified' }
Usuario >> getPrestamosVencidos [
|col|
col := OrderedCollection new.
bibliotecasInteres do: [ :u | |colAux| colAux := u getPrestamosVencidosDeUsuario: dni. colAux ifNotEmpty: [col addAll: colAux].].
^ col
]

{ #category : #'as yet unclassified' }
Usuario >> inicializarConNombre: unNombre apellido: unApellido dni: unDni contraseña: unaContraseña [
apellido := unApellido.
nombre := unNombre.
dni := unDni.
contrasenia := unaContraseña.
multado := false.
fechaTerminacionMulta := nil.

]

{ #category : #'as yet unclassified' }
Usuario >> multar [
multado := true.
]

{ #category : #'as yet unclassified' }
Usuario >> multarConDias: cantDias [
multado := true.
fechaTerminacionMulta := (Date today) addDays: cantDias.
]

{ #category : #'instance creation' }
Usuario >> new [
"es abstracta, no se pueden crear instancias de Usuario (igual, esto no funciona)"
"^ self subclassResponsibility."
]

{ #category : #accessing }
Usuario >> nombre [

	^ nombre
]

{ #category : #accessing }
Usuario >> nombre: anObject [

	nombre := anObject
]

{ #category : #accessing }
Usuario >> puedePedirAudioLibros [
^ self subclassResponsibility 
]

{ #category : #initialization }
Usuario >> setBibliotecasInteres: colBib [
bibliotecasInteres := colBib .
]

{ #category : #'as yet unclassified' }
Usuario >> verificarMulta [
|rta|
rta := self getDeuda.
rta ifNil: [^ nil].
self multarConDias: 7.
"retorna la primera biblioteca que detecta deuda, sino nil"
^ rta
]
