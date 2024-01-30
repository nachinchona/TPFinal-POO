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

{ #category : #'error handling' }
Sistema_UI >> error: unTexto [
|ventana texto|
texto := TextMorph new contents: unTexto; color: Color lightRed; bold.
ventana := self class crearVentanaConAncho: (texto width + 20) altura: (texto height + 20) titulo: 'ERROR'.
ventana addMorphCentered: texto.
ventana openCenteredInWorld .
]

{ #category : #'as yet unclassified' }
Sistema_UI >> getSistema [
^system
]

{ #category : #initialization }
Sistema_UI >> inicializarConSistema: unSistema [
"metodo abstracto"
]

{ #category : #'as yet unclassified' }
Sistema_UI >> iniciarMenuPrincipalConSistema: unSistema [

system := unSistema.

VistaPrincipal crearConSistema: unSistema .

]

{ #category : #'as yet unclassified' }
Sistema_UI >> mensaje: unTexto [
|ventana texto|
texto := TextMorph new contents: unTexto.
ventana := self class crearVentanaConAncho: (texto width + 20) altura: (texto height + 20).
ventana addMorphCentered: texto.
ventana openCenteredInWorld .
]

{ #category : #'as yet unclassified' }
Sistema_UI >> mensaje: unTexto conAccion: unaAccion [
|ventana texto|
texto := TextMorph new contents: unTexto.
ventana := self class crearVentanaConAncho: (texto width + 20) altura: (texto height + 20).
ventana definirAccion: unaAccion .
ventana addMorphCentered: texto.
ventana openCenteredInWorld .
]

{ #category : #'as yet unclassified' }
Sistema_UI >> vistaAdmin [
^ VistaAdmin crearConSistema: system
]

{ #category : #'as yet unclassified' }
Sistema_UI >> vistaPrestamo: unDni [
^ VistaPrestamo crearConSistema: system usuario: unDni
]

{ #category : #'as yet unclassified' }
Sistema_UI >> vistaPrincipal [
^ (VistaPrincipal crearConSistema: system)
]

{ #category : #'as yet unclassified' }
Sistema_UI >> vistaRegistro [
^ VistaRegistro crearConSistema: system
]

{ #category : #'as yet unclassified' }
Sistema_UI >> vistaRegistroOld [
|vista campoDNI campoNombre campoApellido campoPass bibliotecas checklist bibliotecasElegidas bibliotecasElegidasMorph bElegir bCompletar bAtras|
vista := self class crearVentanaConAncho:  400 altura: 600 titulo: 'ALTA DE NUEVO USUARIO'.
"campos de ingreso de datos"
campoNombre := RubTextFieldMorph new extent: 300@20; ghostText: 'Ingrese su nombre'.
vista añadirMorph: campoNombre conMargen: 40.

campoApellido := RubTextFieldMorph new extent: 300@20; ghostText: 'Ingrese su apellido'.
vista añadirMorph: campoApellido conMargen: 20.

campoDNI := RubTextFieldMorph new extent: 300@20; ghostText: 'Ingrese su DNI'.
vista añadirMorph: campoDNI conMargen: 20.

campoPass := RubTextFieldMorph new extent: 300@20; ghostText: 'Ingrese su contraseña'.
vista añadirMorph: campoPass conMargen: 20.

"boton para efectivizar el registro con los datos de los campos"
bCompletar := (BotonGenerico_UI new inicializarConSistema: system label: 'Registrar').
vista añadirMorph: bCompletar conMargen: 20.

"boton que invoca una checklist con bibliotecas"
bElegir := BotonGenerico_UI new inicializarConSistema: system label: 'Elegir bibliotecas de interés'.
vista añadirMorph: bElegir conMargen: 20.

"checklist para seleccionar bibliotecas de interes"
bibliotecas := Dictionary new.
(system getBibliotecas) do: [:b | bibliotecas at: b nombre put: b].

checklist := TickDialogWindow itemsList: (bibliotecas keys) itemsHeaderName: 'Elija las bibliotecas que desee' title: 'Bibliotecas de interés' .
bElegir definirAccion: [ bibliotecasElegidas := (checklist choose) . bElegir deshabilitar .  bibliotecasElegidas ifNotNil: [bibliotecasElegidas do: [ :b | bibliotecasElegidasMorph addMorphBack: (TextMorph new contents: b; position: (bibliotecasElegidasMorph lastSubmorph position + (0@20))). ].]].

"morph para mostrar las bibliotecas seleccionadas (se agregan las seleccionadas despues de completar el checklist en bElegir)"
bibliotecasElegidasMorph := BorderedMorph new extent: 370@200; color: Color darkGray; borderWidth: 1.
bibliotecasElegidasMorph addMorph: (TextMorph new contents: 'Bibliotecas elegidas:'; position: bibliotecasElegidasMorph position + (10@0)).
vista añadirMorph: bibliotecasElegidasMorph conMargen: 20.

bCompletar definirAccion: 
[
|nuevoUsuario| 
(bibliotecasElegidas isNotNil & (campoNombre getText ~= '') & (campoApellido getText ~= '') & (campoDNI getText ~= '') & (campoPass getText ~= '')) 
ifTrue: 
	[ 
	nuevoUsuario := Usuario crearConNombre: (campoNombre getText) apellido: (campoApellido getText) dni: ((campoDNI getText) asNumber) contraseña: (campoPass getText). nuevoUsuario setBibliotecasInteres: (bibliotecasElegidas collect: [:b | bibliotecas at: b]). 	(system agregarUsuario: nuevoUsuario) ifTrue: [bCompletar owner delete. self mensaje: 'Registro completado con éxito!' conAccion: [self vistaPrincipal]. ] ifFalse: [ self mensaje: 'Usuario ya existente.' ]
	] 
ifFalse: 
	[self error: 'Ha ocurrido un error, intenta de nuevo'.] 
] .

"boton atras que vuelve a la vista principal"
bAtras := (BotonGenerico_UI new inicializarConSistema: system label: 'Atrás').
vista añadirMorph: bAtras conMargen: 20.

bAtras definirAccion: [ bAtras owner delete. self vistaPrincipal ].

vista openCenteredInWorld .

^vista
]

{ #category : #'as yet unclassified' }
Sistema_UI >> vistaUsuario: unDni [
^ (VistaUsuario crearConSistema: system usuario: unDni)
]
