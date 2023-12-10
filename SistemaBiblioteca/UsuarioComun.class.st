Class {
	#name : #UsuarioComun,
	#superclass : #Usuario,
	#category : #SistemaBiblioteca
}

{ #category : #'as yet unclassified' }
UsuarioComun >> cambiarModalidad: unSistema [
|usuarioCambiado|

usuarioCambiado := UsuarioPlus crearConNombre: nombre apellido: apellido dni: dni contraseña: contrasenia .

(self estaAlDiaConCuota) ifTrue: 
[  
(unSistema eliminarUsuario: (self dni)).
(unSistema agregarUsuario: usuarioCambiado).
usuarioCambiado setBibliotecasInteres: (self bibliotecasInteres).
] ifFalse:
[
^ self
].

self changed.

^ usuarioCambiado
]

{ #category : #'as yet unclassified' }
UsuarioComun >> esPlus [
^ false
]
