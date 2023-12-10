Class {
	#name : #VistaAdmin,
	#superclass : #'Sistema_UI',
	#instVars : [
		'uTabla',
		'uDataSource',
		'bTabla',
		'bDataSource',
		'pTabla',
		'pDataSource',
		'bMostrarU',
		'bMostrarB',
		'bMostrarP',
		'bAgregarB',
		'bModificarB',
		'bCerrarSesion'
	],
	#category : #'SistemaBiblioteca_GUI'
}

{ #category : #'as yet unclassified' }
VistaAdmin class >> crearConSistema: unSistema [
|vista|
vista := self crearVentanaConAncho: 900 altura: 700.
vista inicializarConSistema: unSistema .
^ vista

]

{ #category : #'as yet unclassified' }
VistaAdmin >> agregarBiblioteca [
|ventana nuevaBiblioteca campoDias campoNombre campoDireccion campoEditorial campoTelefono campoNombreR bCompletar bAtras|

ventana := self class crearVentanaConAncho: 850 altura: 800 titulo: 'AGREGAR BIBLIOTECA'.

"campos de ingreso de datos"
campoNombre := RubTextFieldMorph new extent: 700@20; ghostText: 'Ingrese nombre'.
ventana añadirMorph: campoNombre conMargen: 40.

campoDireccion := RubTextFieldMorph new extent: 700@20; ghostText: 'Ingrese dirección'.
ventana añadirMorph: campoDireccion conMargen: 20.

campoEditorial := RubTextFieldMorph new extent: 700@20; ghostText: 'Ingrese editorial'.
ventana añadirMorph: campoEditorial conMargen: 20.

ventana añadirMorph: (TextMorph new contents: 'Días préstamo') alLadoDe: campoEditorial.

campoTelefono := RubTextFieldMorph new extent: 700@20; ghostText: 'Ingrese teléfono'.
ventana añadirMorph: campoTelefono conMargen: 20.

campoDias := DropListMorph new list: (1 to: 30); extent: 40@20.
ventana añadirMorph: campoDias alLadoDe: campoTelefono.

campoNombreR := RubTextFieldMorph new extent: 700@20; ghostText: 'Ingrese nombre de representante'.
ventana añadirMorph: campoNombreR conMargen: 20.

bCompletar := BotonGenerico_UI new textoBoton: 'Agregar'; definirAccion:
[
	(campoDias selectedItem notNil) & (campoEditorial getText ~= '') & (campoDireccion getText ~= '') & (campoNombre getText ~= '') & (campoNombreR getText ~= '') & (campoTelefono getText ~= '') 
	ifTrue: 
		[ 
			nuevaBiblioteca := Biblioteca crearConId: system obtenerIDBibliotecaSiguiente direccion: campoDireccion getText nombre: campoNombre getText telefono: (campoTelefono getText) asNumber nombreRepresentante: campoNombreR getText. nuevaBiblioteca setDiasPrestamo: campoDias selectedItem.
			system agregarBiblioteca: nuevaBiblioteca .
			self mensaje: 'La biblioteca ',nuevaBiblioteca nombre,' ha sido agregada correctamente.' conAccion: [ventana delete. self vistaAdmin].
		]
	ifFalse: 
		[ self error: 'Algún dato no ha sido ingresado correctamente.' ].
].

ventana añadirMorph: bCompletar conMargen: 20.

bAtras := (BotonGenerico_UI new textoBoton: 'Atrás').
ventana añadirMorph: bAtras conMargen: 20.
bAtras definirAccion: [ bAtras owner delete. self vistaAdmin ].

ventana openCenteredInWorld .
^ventana
]

{ #category : #initialization }
VistaAdmin >> inicializarConSistema: unSistema [

self asignarSistema: unSistema.

(system getUsuarios) do: [ :u | system verificarMulta: (u dni) ].

self añadirMorph: (TextMorph new contents: 'Usuarios') conMargen: 10.

uDataSource := UsuarioDataSource crear: system.
uTabla := Tabla_UI crearUConDataSource: uDataSource ancho: 870 altura: 150.
self añadirMorph: uTabla conMargen: 10.

self añadirMorph: (TextMorph new contents: 'Bibliotecas') conMargen: 10.

bDataSource := BibliotecaDataSource elements: (system getBibliotecas).
bTabla := Tabla_UI crearBConDataSource: bDataSource ancho: 870 altura: 150.
self añadirMorph: bTabla conMargen: 10.

bAgregarB := BotonGenerico_UI new textoBoton: 'Agregar biblioteca'.
self añadirMorph: bAgregarB conMargen: 10.
bAgregarB definirAccion: [ self delete. self agregarBiblioteca ].

bModificarB := BotonGenerico_UI new textoBoton: 'Modificar biblioteca'.
self añadirMorph: bModificarB alLadoDe: bAgregarB.

bCerrarSesion := BotonGenerico_UI new textoBoton: 'Cerrar sesión'; definirAccion: [ self delete. self vistaPrincipal ].
self añadirMorph: bCerrarSesion conMargen: 10.

self openCenteredInWorld .
]
