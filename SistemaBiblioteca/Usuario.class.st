Class {
	#name : #Usuario,
	#superclass : #Object,
	#instVars : [
		'nombre',
		'apellido',
		'dni',
		'contrasenia',
		'multado',
		'fechaLimite'
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

{ #category : #initialization }
Usuario class >> crearUsuarioConNombre: unNombre apellido: unApellido dni: unDni contraseña: unaContraseña [
|unUsuario|
unUsuario := self new.
unUsuario inicializarUsuarioConNombre: unNombre apellido: unApellido dni: unDni contraseña: unaContraseña.
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
^ false
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

{ #category : #accessing }
Usuario >> nombre [

	^ nombre
]

{ #category : #accessing }
Usuario >> nombre: anObject [

	nombre := anObject
]
