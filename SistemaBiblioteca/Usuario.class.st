Class {
	#name : #Usuario,
	#superclass : #Object,
	#instVars : [
		'nombre',
		'apellido',
		'dni',
		'contrasenia',
		'multado',
		'fechaLimite',
		'bibInteres',
		'estaAlDiaConCuota'
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
^ bibInteres 
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
Usuario >> esPlus [
"se pretende crear usuarios de acuerdo a sus subclases"
^ self subclassResponsibility  
]

{ #category : #accessing }
Usuario >> estaAlDiaConCuota [
^estaAlDiaConCuota
]

{ #category : #'as yet unclassified' }
Usuario >> estaMultado [
^ multado 
]

{ #category : #'as yet unclassified' }
Usuario >> inicializarConNombre: unNombre apellido: unApellido dni: unDni contraseña: unaContraseña [
apellido := unApellido.
nombre := unNombre.
dni := unDni.
contrasenia := unaContraseña.
multado := false.
estaAlDiaConCuota := false.


]

{ #category : #'as yet unclassified' }
Usuario >> multar [
multado := true.
]

{ #category : #'as yet unclassified' }
Usuario >> multarConDias: cantDias [
multado := true.
fechaLimite := (Date today) addDays: cantDias.
]

{ #category : #'instance creation' }
Usuario >> new [
"es abstracta, no se pueden crear instancias de Usuario (igual, esto no funciona)"
^ self subclassResponsibility.
]

{ #category : #accessing }
Usuario >> nombre [

	^ nombre
]

{ #category : #accessing }
Usuario >> nombre: anObject [

	nombre := anObject
]

{ #category : #'as yet unclassified' }
Usuario >> pagarCuota [
estaAlDiaConCuota := true.
]

{ #category : #initialization }
Usuario >> setBibliotecasInteres: colBib [
bibInteres := colBib .
]
