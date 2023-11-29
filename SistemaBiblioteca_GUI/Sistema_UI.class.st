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
|ventana|
ventana := self class crearVentanaConAncho:  250 altura: 100  titulo: 'ERROR'.
ventana añadirBoton: (TextMorph new contents: unTexto) conMargen: 20.
ventana openCenteredInWorld .
^ventana
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
Sistema_UI >> mensaje: unTexto [
|ventana texto|
ventana := self class crearVentanaConAncho: 200 altura: 100..
texto := TextMorph new contents: unTexto.
ventana addMorphCentered: texto.
ventana openCenteredInWorld .
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
Sistema_UI >> vistaAdmin [
|vista bienvenida lista|
vista := self class crearVentanaConAncho: 300 altura: 300 titulo: 'ADMIN'.

bienvenida := TextMorph new contents: 'Bienvenido/a admin! :)'.
vista añadirBoton: bienvenida conMargen: 30.

lista := BorderedMorph new extent: 280@180; color: Color darkGray; borderWidth: 1.
lista addMorph: (TextMorph new contents: 'Usuarios:'; position: lista position + (10@0)).
system getUsuarios do: [ :u | lista addMorphBack: (TextMorph new contents: (u dni) asString; position: lista lastSubmorph position + (0@20))].

vista añadirBoton: lista conMargen: 20.

vista openCenteredInWorld .
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
|vista campoDNI campoNombre campoApellido campoPass bibliotecas checklistModel bibliotecasElegidas checklist bElegir bCompletar bAtras|
vista := self class crearVentanaConAncho:  400 altura: 550 titulo: 'ALTA DE NUEVO USUARIO'.
"campos de ingreso de datos"
campoNombre := RubTextFieldMorph new extent: 300@20; ghostText: 'Ingrese su nombre'.
vista añadirBoton: campoNombre conMargen: 40.

campoApellido := RubTextFieldMorph new extent: 300@20; ghostText: 'Ingrese su apellido'.
vista añadirBoton: campoApellido conMargen: 20.

campoDNI := RubTextFieldMorph new extent: 300@20; ghostText: 'Ingrese su DNI'.
vista añadirBoton: campoDNI conMargen: 20.

campoPass := RubTextFieldMorph new extent: 300@20; ghostText: 'Ingrese su contraseña'.
vista añadirBoton: campoPass conMargen: 20.

"boton para efectivizar el registro con los datos de los campos"
bCompletar := (BotonGenerico_UI new inicializarConSistema: system label: 'Registrar').
vista añadirBoton: bCompletar conMargen: 20.

"boton que invoca una checklist con bibliotecas"
bElegir := BotonGenerico_UI new inicializarConSistema: system label: 'Elegir bibliotecas de interés'.
vista añadirBoton: bElegir conMargen: 20.
bElegir definirAccion: [ bibliotecasElegidas := (checklistModel selectedItems) collect:[ :b | bibliotecas at: b ]. bElegir color: Color darkGray; deshabilitar. checklist disable.].

"checklist para seleccionar bibliotecas de interes"
bibliotecas := Dictionary new.
(system getBibliotecas) do: [:b | bibliotecas at: b nombre put: b].

checklistModel := MorphTreeModel new rootItems: (bibliotecas keys).
checklistModel autoMultiSelection: true; headerLabel: 'Elegí alguna biblioteca de interés :)'; beCheckList.
checklist := checklistModel defaultTreeMorph buildContents; vResizing: #spaceFill; hResizing:#spaceFill; extent: 370@160.
vista añadirBoton: checklist conMargen: 20.

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
vista añadirBoton: bAtras conMargen: 20.

bAtras definirAccion: [ bAtras owner delete. self vistaPrincipal ].

vista openCenteredInWorld .

^vista
]

{ #category : #'as yet unclassified' }
Sistema_UI >> vistaRegistroOld [
|vista campoDNI campoNombre campoApellido campoPass bibliotecas checklist bibliotecasElegidas bibliotecasElegidasMorph bElegir bCompletar bAtras|
vista := self class crearVentanaConAncho:  400 altura: 600 titulo: 'ALTA DE NUEVO USUARIO'.
"campos de ingreso de datos"
campoNombre := RubTextFieldMorph new extent: 300@20; ghostText: 'Ingrese su nombre'.
vista añadirBoton: campoNombre conMargen: 40.

campoApellido := RubTextFieldMorph new extent: 300@20; ghostText: 'Ingrese su apellido'.
vista añadirBoton: campoApellido conMargen: 20.

campoDNI := RubTextFieldMorph new extent: 300@20; ghostText: 'Ingrese su DNI'.
vista añadirBoton: campoDNI conMargen: 20.

campoPass := RubTextFieldMorph new extent: 300@20; ghostText: 'Ingrese su contraseña'.
vista añadirBoton: campoPass conMargen: 20.

"boton para efectivizar el registro con los datos de los campos"
bCompletar := (BotonGenerico_UI new inicializarConSistema: system label: 'Registrar').
vista añadirBoton: bCompletar conMargen: 20.

"boton que invoca una checklist con bibliotecas"
bElegir := BotonGenerico_UI new inicializarConSistema: system label: 'Elegir bibliotecas de interés'.
vista añadirBoton: bElegir conMargen: 20.

"checklist para seleccionar bibliotecas de interes"
bibliotecas := Dictionary new.
(system getBibliotecas) do: [:b | bibliotecas at: b nombre put: b].

checklist := TickDialogWindow itemsList: (bibliotecas keys) itemsHeaderName: 'Elija las bibliotecas que desee' title: 'Bibliotecas de interés' .
bElegir definirAccion: [ bibliotecasElegidas := (checklist choose) . bElegir deshabilitar .  bibliotecasElegidas ifNotNil: [bibliotecasElegidas do: [ :b | bibliotecasElegidasMorph addMorphBack: (TextMorph new contents: b; position: (bibliotecasElegidasMorph lastSubmorph position + (0@20))). ].]].

"morph para mostrar las bibliotecas seleccionadas (se agregan las seleccionadas despues de completar el checklist en bElegir)"
bibliotecasElegidasMorph := BorderedMorph new extent: 370@200; color: Color darkGray; borderWidth: 1.
bibliotecasElegidasMorph addMorph: (TextMorph new contents: 'Bibliotecas elegidas:'; position: bibliotecasElegidasMorph position + (10@0)).
vista añadirBoton: bibliotecasElegidasMorph conMargen: 20.

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
vista añadirBoton: bAtras conMargen: 20.

bAtras definirAccion: [ bAtras owner delete. self vistaPrincipal ].

vista openCenteredInWorld .

^vista
]

{ #category : #'as yet unclassified' }
Sistema_UI >> vistaUsuario: unUsuario [
|vista bienvenida |
vista := self class crearVentanaConAncho:  450 altura: 350 titulo: 'LIBRERÍA NACIONAL I.A'.

bienvenida := TextMorph new contents: 'Bienvenido/a ',unUsuario nombre,'! :)'.
vista añadirBoton: bienvenida conMargen: 40.

vista openCenteredInWorld .

^vista
]
