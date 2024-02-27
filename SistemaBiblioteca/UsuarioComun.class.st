Class {
	#name : #UsuarioComun,
	#superclass : #Usuario,
	#category : #SistemaBiblioteca
}

{ #category : #'as yet unclassified' }
UsuarioComun >> cambiarModalidad: unSistema [
|usuarioCambiado|

usuarioCambiado := UsuarioPlus crearConNombre: nombre apellido: apellido dni: dni contraseña: contrasenia .

unSistema reasignarPrestamosDe: self a: usuarioCambiado.
(unSistema eliminarUsuario: (self dni)).
(unSistema agregarUsuario: usuarioCambiado).

usuarioCambiado setBibliotecasInteres: (self bibliotecasInteres).

self changed: usuarioCambiado.

^ usuarioCambiado
]

{ #category : #'as yet unclassified' }
UsuarioComun >> esPlus [
^ false
]

{ #category : #accessing }
UsuarioComun >> puedePedirAudioLibros [
^ false
]
