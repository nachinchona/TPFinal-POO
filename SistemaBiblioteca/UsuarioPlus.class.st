Class {
	#name : #UsuarioPlus,
	#superclass : #Usuario,
	#instVars : [
		'estaAlDiaConCuota',
		'fechaVencimientoCuota'
	],
	#category : #SistemaBiblioteca
}

{ #category : #'as yet unclassified' }
UsuarioPlus >> cambiarModalidad: unSistema [
|usuarioCambiado|

usuarioCambiado := UsuarioComun crearConNombre: nombre apellido: apellido dni: dni contraseña: contrasenia .

"no hay errores en esta fase (no chequeo si devuelven true o false)"
unSistema reasignarPrestamosDe: self a: usuarioCambiado.
(unSistema eliminarUsuario: (self dni)).
(unSistema agregarUsuario: usuarioCambiado).
usuarioCambiado setBibliotecasInteres: (self bibliotecasInteres).

self changed: usuarioCambiado.

^ usuarioCambiado 
]

{ #category : #'as yet unclassified' }
UsuarioPlus >> crearPrestamoConBib: unaBiblioteca yLibros: unaColLibros [
|colPlus|
colPlus := OrderedCollection new.
super crearPrestamoConBib: unaBiblioteca yLibros: unaColLibros.
unaColLibros do: [ :unLibro | (unLibro esAudioLibro) 
												ifTrue: [
																(unLibro estaEnDeuda)
																ifFalse: [ colPlus add: unLibro. unLibro marcar. ].
																unLibro marcar.
															]
									  "ignora los libros comunes que ya fueron tratados con el llamado super"
   					  ].

(colPlus isEmpty) ifFalse: 
	[
	"Si la colección de audiolibros no es vacía, se crea el préstamo con los libros disponibles"
	unaBiblioteca agregarPrestamoConLibros: colPlus de: self. 
	]
ifTrue: [ ^ false ].

^ true
]

{ #category : #'as yet unclassified' }
UsuarioPlus >> esPlus [
^ true
]

{ #category : #accessing }
UsuarioPlus >> estaAlDiaConCuota [
(fechaVencimientoCuota ifNil: [^true]).
^(fechaVencimientoCuota isAfter: (Date today))
]

{ #category : #'as yet unclassified' }
UsuarioPlus >> inicializarConNombre: unNombre apellido: unApellido dni: unDni contraseña: unaContraseña [
super inicializarConNombre: unNombre apellido: unApellido dni: unDni contraseña: unaContraseña.
estaAlDiaConCuota := false.
fechaVencimientoCuota := nil.
]

{ #category : #accessing }
UsuarioPlus >> pagarCuota [ 
estaAlDiaConCuota := true.
fechaVencimientoCuota ifNil: [ fechaVencimientoCuota := (Date today) addDays: 30 ] ifNotNil: [ fechaVencimientoCuota := fechaVencimientoCuota addDays: 30 ].

]

{ #category : #accessing }
UsuarioPlus >> puedePedirAudioLibros [
^ self estaAlDiaConCuota
]

{ #category : #initialization }
UsuarioPlus >> setFechaVencimientoCuota: unaFecha [
fechaVencimientoCuota := unaFecha .
]
