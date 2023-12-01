Class {
	#name : #VistaRegistro,
	#superclass : #'Sistema_UI',
	#instVars : [
		'campoDNI',
		'campoNombre',
		'campoApellido',
		'campoPass',
		'bibliotecas',
		'checklistModel',
		'bibliotecasElegidas',
		'checklist',
		'bElegir',
		'bCompletar',
		'bAtras'
	],
	#category : #'SistemaBiblioteca_GUI'
}

{ #category : #'as yet unclassified' }
VistaRegistro class >> crearConSistema: unSistema [
|vista|
vista := self crearVentanaConAncho:  400 altura: 550 titulo: 'ALTA DE NUEVO USUARIO'.
vista inicializarConSistema: unSistema.
^ vista

]

{ #category : #initialization }
VistaRegistro >> inicializarConSistema: unSistema [

self asignarSistema: unSistema .
"campos de ingreso de datos"
campoNombre := RubTextFieldMorph new extent: 300@20; ghostText: 'Ingrese su nombre'.
self añadirBoton: campoNombre conMargen: 40.

campoApellido := RubTextFieldMorph new extent: 300@20; ghostText: 'Ingrese su apellido'.
self añadirBoton: campoApellido conMargen: 20.

campoDNI := RubTextFieldMorph new extent: 300@20; ghostText: 'Ingrese su DNI'.
self añadirBoton: campoDNI conMargen: 20.

campoPass := RubTextFieldMorph new extent: 300@20; ghostText: 'Ingrese su contraseña'.
self añadirBoton: campoPass conMargen: 20.

"boton para efectivizar el registro con los datos de los campos"
bCompletar := (BotonGenerico_UI new inicializarConSistema: system label: 'Registrar').
self añadirBoton: bCompletar conMargen: 20.

"checklist para seleccionar bibliotecas de interes"
bibliotecas := Dictionary new.
(system getBibliotecas) do: [:b | bibliotecas at: b nombre put: b].

checklistModel := MorphTreeModel new rootItems: (bibliotecas keys).
checklistModel autoMultiSelection: true; headerLabel: 'Elegí alguna biblioteca de interés :)'; beCheckList.
checklist := checklistModel defaultTreeMorph buildContents; vResizing: #spaceFill; hResizing:#spaceFill; extent: 370@160.
self añadirBoton: checklist conMargen: 20.

"boton que agarra la seleccion del checklist para elegir bibliotecas"
bElegir := BotonGenerico_UI new inicializarConSistema: system label: 'Elegir bibliotecas de interés'.
self añadirBoton: bElegir conMargen: 20.
bElegir definirAccion: [ bibliotecasElegidas := (checklistModel selectedItems) collect:[ :b | bibliotecas at: b ]. bElegir color: Color darkGray; deshabilitar. checklist disable.].

bCompletar definirAccion: 
[
|nuevoUsuario| 
(bibliotecasElegidas isNotNil & (campoNombre getText ~= '') & (campoApellido getText ~= '') & (campoDNI getText ~= '') & (campoPass getText ~= '')) 
ifTrue: 
	[ 
	nuevoUsuario := Usuario crearConNombre: (campoNombre getText) apellido: (campoApellido getText) dni: ((campoDNI getText) asNumber) contraseña: (campoPass getText). nuevoUsuario setBibliotecasInteres: bibliotecasElegidas. 	(system agregarUsuario: nuevoUsuario) ifTrue: [bCompletar owner delete. self mensaje: 'Registro completado con éxito!' conAccion: [self vistaPrincipal]. ] ifFalse: [ self mensaje: 'Usuario ya existente.' ]
	] 
ifFalse: 
	[self error: 'Ha ocurrido un error, intenta de nuevo'.] 
] .

"boton atras que vuelve a la vista principal"
bAtras := (BotonGenerico_UI new inicializarConSistema: system label: 'Atrás').
self añadirBoton: bAtras conMargen: 20.
bAtras definirAccion: [ bAtras owner delete. self vistaPrincipal ].

self openCenteredInWorld .

^self
]
