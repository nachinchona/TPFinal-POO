Class {
	#name : #'Sistema_UI',
	#superclass : #'Ventana_UI',
	#instVars : [
		'system'
	],
	#category : #'SistemaBiblioteca_GUI'
}

{ #category : #'as yet unclassified' }
Sistema_UI >> asignarSistema: unSistema [
system := unSistema .
]

{ #category : #'as yet unclassified' }
Sistema_UI >> getSistema [
^system
]

{ #category : #'as yet unclassified' }
Sistema_UI >> iniciarMenuPrincipalConSistema: unSistema [

system := unSistema.

(self vistaPrincipal) openCenteredInWorld .

]

{ #category : #'as yet unclassified' }
Sistema_UI >> mensaje: unTexto conAccion: unaAccion [
|ventana texto|
ventana := self class crearVentanaConAncho: 200 altura: 100.
ventana añadirAccion: unaAccion .
texto := TextMorph new contents: unTexto.
ventana addMorphCentered: texto.
ventana openCenteredInWorld .
]

{ #category : #'as yet unclassified' }
Sistema_UI >> vistaPrincipal [
|vista bienvenida campoDNI campoPass bIniciarSesion bRegistrar|
vista := self class crearVentanaConAncho:  450 altura: 350 titulo: 'LIBRERÍA NACIONAL I.A'.

bienvenida := TextMorph new contents: 'Bienvenido a LIBRERÍAS I.A.! :)'.
vista añadirBoton: bienvenida conMargen: 40.

campoDNI := RubTextFieldMorph new extent: 300@20; ghostText: 'Ingrese su DNI'.
vista añadirBoton: campoDNI conMargen: 20.

campoPass := RubTextFieldMorph new extent: 300@20; ghostText: 'Ingrese su contraseña'.
vista añadirBoton: campoPass conMargen: 20.

bIniciarSesion := (BotonIniciarSesion_UI new inicializarConSistema: self campoDNI: campoDNI campoPass: campoPass ).
vista añadirBoton: bIniciarSesion conMargen: 20.

bRegistrar := (BotonRegistrar_UI new inicializarConSistema: self).
vista añadirBoton: bRegistrar conMargen: 20.

vista openCenteredInWorld .

^vista
]

{ #category : #'as yet unclassified' }
Sistema_UI >> vistaRegistro [
|vista campoDNI campoNombre campoApellido campoPass bCompletar bAtras|
vista := self class crearVentanaConAncho:  400 altura: 300 titulo: 'ALTA DE NUEVO USUARIO'.

campoNombre := RubTextFieldMorph new extent: 300@20; ghostText: 'Ingrese su nombre'.
vista añadirBoton: campoNombre conMargen: 20.

campoApellido := RubTextFieldMorph new extent: 300@20; ghostText: 'Ingrese su apellido'.
vista añadirBoton: campoApellido conMargen: 20.

campoDNI := RubTextFieldMorph new extent: 300@20; ghostText: 'Ingrese su DNI'.
vista añadirBoton: campoDNI conMargen: 20.

campoPass := RubTextFieldMorph new extent: 300@20; ghostText: 'Ingrese su contraseña'.
vista añadirBoton: campoPass conMargen: 20.

bCompletar := (BotonGenerico_UI new inicializarConSistema: system label: 'Registrar').
vista añadirBoton: bCompletar conMargen: 20.
bCompletar definirAccion: [|nuevoUsuario| nuevoUsuario := Usuario crearConNombre: (campoNombre getText) apellido: (campoApellido getText) dni: (campoDNI getText) contraseña: (campoPass getText). system agregarUsuario: nuevoUsuario. bCompletar owner delete. self mensaje: 'Registro completado con éxito!' conAccion: [self vistaPrincipal]. ] .

bAtras := (BotonGenerico_UI new inicializarConSistema: system label: 'Atrás').
vista añadirBoton: bAtras conMargen: 20.
bAtras definirAccion: [ bAtras owner delete. self vistaPrincipal ].

vista openCenteredInWorld .

^vista
]
