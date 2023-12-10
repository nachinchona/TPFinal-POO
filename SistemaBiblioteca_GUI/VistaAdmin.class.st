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
		'bModificarB'
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
|ventana nuevaBiblioteca campoDias campoNombre campoDireccion campoEditorial campoTelefono campoNombreR|

ventana := self class crearVentanaConAncho: 850 altura: 800 titulo: 'AGREGAR BIBLIOTECA'.

"campos de ingreso de datos"
campoNombre := RubTextFieldMorph new extent: 700@20; ghostText: 'Ingrese nombre'.
ventana añadirMorph: campoNombre conMargen: 40.

campoDireccion := RubTextFieldMorph new extent: 700@20; ghostText: 'Ingrese editorial'.
ventana añadirMorph: campoDireccion conMargen: 20.

campoEditorial := RubTextFieldMorph new extent: 700@20; ghostText: 'Ingrese editorial'.
ventana añadirMorph: campoEditorial conMargen: 20.

ventana añadirMorph: (TextMorph new contents: 'Días de suspensión') alLadoDe: campoEditorial.

campoTelefono := RubTextFieldMorph new extent: 700@20; ghostText: 'Ingrese teléfono'.
ventana añadirMorph: campoTelefono conMargen: 20.

campoDias := DropListMorph new list: (1 to: 30); extent: 40@20.
ventana añadirMorph: campoDias alLadoDe: campoTelefono.

campoNombreR := RubTextFieldMorph new extent: 700@20; ghostText: 'Ingrese nombre de representante'.
ventana añadirMorph: campoNombreR conMargen: 20.

ventana openCenteredInWorld .
^ventana
]

{ #category : #initialization }
VistaAdmin >> inicializarConSistema: unSistema [

self asignarSistema: unSistema.

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
bAgregarB definirAccion: [ self agregarBiblioteca ].


bModificarB := BotonGenerico_UI new textoBoton: 'Modificar biblioteca'.
self añadirMorph: bModificarB alLadoDe: bAgregarB.

self openCenteredInWorld .
]
