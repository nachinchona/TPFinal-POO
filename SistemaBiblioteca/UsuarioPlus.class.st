Class {
	#name : #UsuarioPlus,
	#superclass : #Usuario,
	#category : #SistemaBiblioteca
}

{ #category : #'as yet unclassified' }
UsuarioPlus >> cambiarModalidad: unSistema [
|usuarioCambiado|

usuarioCambiado := UsuarioComun crearConNombre: nombre apellido: apellido dni: dni contraseña: contrasenia .

"no hay errores en esta fase (no chequeo si devuelven true o false)"
(unSistema eliminarUsuario: (self dni)).
(unSistema agregarUsuario: usuarioCambiado).

self changed.

^ usuarioCambiado 
]

{ #category : #'as yet unclassified' }
UsuarioPlus >> esPlus [
^ true
]
