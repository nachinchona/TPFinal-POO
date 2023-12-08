Class {
	#name : #VistaRegistro,
	#superclass : #'Sistema_UI',
	#instVars : [
		'campoDNI',
		'campoNombre',
		'campoApellido',
		'campoPass',
		'bibliotecas',
		'dataSource',
		'tabla',
		'bibliotecasElegidas',
		'bElegir',
		'bAyuda',
		'bCompletar',
		'bAtras',
		'bSeleccionarTodo'
	],
	#category : #'SistemaBiblioteca_GUI'
}

{ #category : #'as yet unclassified' }
VistaRegistro class >> crearConSistema: unSistema [
|vista|
vista := self crearVentanaConAncho: 850 altura: 580 titulo: 'ALTA DE NUEVO USUARIO'.
vista inicializarConSistema: unSistema.
^ vista

]

{ #category : #initialization }
VistaRegistro >> inicializarConSistema: unSistema [

self asignarSistema: unSistema .
"campos de ingreso de datos"
campoNombre := RubTextFieldMorph new extent: 800@20; ghostText: 'Ingrese su nombre'.
self añadirMorph: campoNombre conMargen: 40.

campoApellido := RubTextFieldMorph new extent: 800@20; ghostText: 'Ingrese su apellido'.
self añadirMorph: campoApellido conMargen: 20.

campoDNI := RubTextFieldMorph new extent: 800@20; ghostText: 'Ingrese su DNI'.
self añadirMorph: campoDNI conMargen: 20.

campoPass := RubTextFieldMorph new extent: 800@20; ghostText: 'Ingrese su contraseña'.
self añadirMorph: campoPass conMargen: 20.

"boton para efectivizar el registro con los datos de los campos"
bCompletar := (BotonGenerico_UI new textoBoton: 'Registrar').
self añadirMorph: bCompletar conMargen: 20.

"tabla para seleccionar bibliotecas de interes"
bibliotecas := (system getBibliotecas).
dataSource := BibliotecaDataSource elements: bibliotecas.
tabla := Tabla_UI crearBConDataSource: dataSource ancho: 800 altura: 120.
self añadirMorph: tabla conMargen: 20.

"boton que agarra la seleccion del checklist para elegir bibliotecas"
bElegir := BotonGenerico_UI new definirAccion: [ bibliotecasElegidas := (tabla selectedIndexes) collect: [ :i | dataSource elementAt: i ]. tabla deselectAll. bElegir color: Color darkGray . bElegir definirAccion: [  ] ] ; textoBoton: 'Elegir bibliotecas de interés'.
self añadirMorph: bElegir conMargen: 20.
bAyuda := BotonGenerico_UI new definirAccion: [bAyuda showBalloon: 'Para elegir muchas bibliotecas, mantén apretada la tecla Ctrl y selecciona más bibliotecas :)']; textoBoton: '?'; color: Color blue; extent: 30@30; helpText: 'Para elegir muchas bibliotecas, mantén apretada la tecla Ctrl y selecciona más bibliotecas :)'.
self añadirMorph: bAyuda alLadoDe: bElegir.

bSeleccionarTodo := BotonGenerico_UI new definirAccion: [ tabla selectAll. ]; textoBoton: 'Seleccionar todas'.
self añadirMorph: bSeleccionarTodo conMargen: 20.

bCompletar definirAccion: 
[
|nuevoUsuario| 
(bibliotecasElegidas isNotNil & (campoNombre getText ~= '') & (campoApellido getText ~= '') & (campoDNI getText ~= '') & (campoPass getText ~= '')) 
ifTrue: 
	[ 
	nuevoUsuario := UsuarioComun crearConNombre: (campoNombre getText) apellido: (campoApellido getText) dni: ((campoDNI getText) asNumber) contraseña: (campoPass getText). nuevoUsuario setBibliotecasInteres: bibliotecasElegidas. 	(system agregarUsuario: nuevoUsuario) ifTrue: [bCompletar owner delete. self mensaje: 'Registro completado con éxito!' conAccion: [self vistaPrincipal]. ] ifFalse: [ self mensaje: 'Usuario ya existente.' ]
	] 
ifFalse: 
	[self error: 'Ha ocurrido un error, intenta de nuevo'.] 
] .

"boton atras que vuelve a la vista principal"
bAtras := (BotonGenerico_UI new textoBoton: 'Atrás').
self añadirMorph: bAtras conMargen: 20.
bAtras definirAccion: [ bAtras owner delete. self vistaPrincipal ].

self openCenteredInWorld .

]

{ #category : #initialization }
VistaRegistro >> oldInicializarConSistema: unSistema [

self asignarSistema: unSistema .
"campos de ingreso de datos"
campoNombre := RubTextFieldMorph new extent: 300@20; ghostText: 'Ingrese su nombre'.
self añadirMorph: campoNombre conMargen: 40.

campoApellido := RubTextFieldMorph new extent: 300@20; ghostText: 'Ingrese su apellido'.
self añadirMorph: campoApellido conMargen: 20.

campoDNI := RubTextFieldMorph new extent: 300@20; ghostText: 'Ingrese su DNI'.
self añadirMorph: campoDNI conMargen: 20.

campoPass := RubTextFieldMorph new extent: 300@20; ghostText: 'Ingrese su contraseña'.
self añadirMorph: campoPass conMargen: 20.

"boton para efectivizar el registro con los datos de los campos"
bCompletar := (BotonGenerico_UI new inicializarConSistema: system label: 'Registrar').
self añadirMorph: bCompletar conMargen: 20.

"checklist para seleccionar bibliotecas de interes"
bibliotecas := Dictionary new.
(system getBibliotecas) do: [:b | bibliotecas at: b nombre put: b].

checklistModel := MorphTreeModel new rootItems: (bibliotecas keys).
checklistModel autoMultiSelection: true; headerLabel: 'Elegí alguna biblioteca de interés :)'; beCheckList.
checklist := checklistModel defaultTreeMorph buildContents; vResizing: #spaceFill; hResizing: #spaceFill; extent: 340@120.
self añadirMorph: checklist conMargen: 20.

"boton que agarra la seleccion del checklist para elegir bibliotecas"
bElegir := BotonGenerico_UI new inicializarConSistema: system label: 'Elegir bibliotecas de interés'.
self añadirMorph: bElegir conMargen: 20.
bElegir definirAccion: [ bibliotecasElegidas := (checklistModel selectedItems) collect:[ :b | bibliotecas at: b ]. bElegir color: Color darkGray; deshabilitar. checklist disable.].

bSeleccionarTodo := BotonGenerico_UI new inicializarConSistema: system label: 'Seleccionar todas'.
self añadirMorph: bSeleccionarTodo conMargen: 20.
bSeleccionarTodo definirAccion: [ checklistModel selectAll].

bCompletar definirAccion: 
[
|nuevoUsuario| 
(bibliotecasElegidas isNotNil & (campoNombre getText ~= '') & (campoApellido getText ~= '') & (campoDNI getText ~= '') & (campoPass getText ~= '')) 
ifTrue: 
	[ 
	nuevoUsuario := UsuarioComun crearConNombre: (campoNombre getText) apellido: (campoApellido getText) dni: ((campoDNI getText) asNumber) contraseña: (campoPass getText). nuevoUsuario setBibliotecasInteres: bibliotecasElegidas. 	(system agregarUsuario: nuevoUsuario) ifTrue: [bCompletar owner delete. self mensaje: 'Registro completado con éxito!' conAccion: [self vistaPrincipal]. ] ifFalse: [ self mensaje: 'Usuario ya existente.' ]
	] 
ifFalse: 
	[self error: 'Ha ocurrido un error, intenta de nuevo'.] 
] .

"boton atras que vuelve a la vista principal"
bAtras := (BotonGenerico_UI new inicializarConSistema: system label: 'Atrás').
self añadirMorph: bAtras conMargen: 20.
bAtras definirAccion: [ bAtras owner delete. self vistaPrincipal ].

self openCenteredInWorld .

^self
]
