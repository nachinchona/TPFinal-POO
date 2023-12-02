Class {
	#name : #UsuarioComun,
	#superclass : #Usuario,
	#category : #SistemaBiblioteca
}

{ #category : #initialization }
UsuarioComun class >> crearConNombre: unNombre apellido: unApellido dni: unDni contraseña: unaContraseña modalidad: esPlus [
^ self crearConNombre: unNombre apellido: unApellido dni: unDni contraseña: unaContraseña modalidad: false
]

{ #category : #'as yet unclassified' }
UsuarioComun >> cambiarModalidad: unSistema [
|usuarioCambiado|

usuarioCambiado := UsuarioPlus crearConNombre: nombre apellido: apellido dni: dni contraseña: contrasenia .

"no hay errores en esta fase (no chequeo si devuelven true o false)"
(unSistema eliminarUsuario: (self dni)).
(unSistema agregarUsuario: usuarioCambiado).

self changed.

^ usuarioCambiado
]

{ #category : #'as yet unclassified' }
UsuarioComun >> esPlus [
^ false
]
