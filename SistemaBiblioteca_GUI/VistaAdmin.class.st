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
		'tablaRetrasados',
		'bGenerarListadoRetrasados',
		'bCerrarSesion'
	],
	#category : #'SistemaBiblioteca_GUI'
}

{ #category : #'as yet unclassified' }
VistaAdmin class >> crearConSistema: unSistema [
|vista|
vista := self crearVentanaConAncho: 1000 altura: 700.
vista inicializarConSistema: unSistema .
^ vista

]

{ #category : #'as yet unclassified' }
VistaAdmin >> agregarBiblioteca [
|ventana nuevaBiblioteca campoDias campoNombre campoDireccion campoTelefono campoNombreR bCompletar bAtras|

ventana := self class crearVentanaConAncho: 850 altura: 800 titulo: 'AGREGAR BIBLIOTECA'.

"campos de ingreso de datos"
campoNombre := RubTextFieldMorph new extent: 700@20; ghostText: 'Ingrese nombre'.
ventana añadirMorph: campoNombre conMargen: 40.

campoDireccion := RubTextFieldMorph new extent: 700@20; ghostText: 'Ingrese dirección'.
ventana añadirMorph: campoDireccion conMargen: 20.

ventana añadirMorph: (TextMorph new contents: 'Días préstamo') alLadoDe: campoDireccion.

campoTelefono := RubTextFieldMorph new extent: 700@20; ghostText: 'Ingrese teléfono'.
ventana añadirMorph: campoTelefono conMargen: 20.

campoDias := DropListMorph new list: (1 to: 30); extent: 40@20.
ventana añadirMorph: campoDias alLadoDe: campoTelefono.

campoNombreR := RubTextFieldMorph new extent: 700@20; ghostText: 'Ingrese nombre de representante'.
ventana añadirMorph: campoNombreR conMargen: 20.

bCompletar := BotonGenerico_UI new textoBoton: 'Agregar'; definirAccion:
[
	(campoDias selectedItem notNil) & (campoDireccion getText ~= '') & (campoNombre getText ~= '') & (campoNombreR getText ~= '') & (campoTelefono getText ~= '') 
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

{ #category : #'as yet unclassified' }
VistaAdmin >> agregarLibroA: unaBiblioteca [
|ventana nuevoLibro campoNombre campoEditorial campoAnio campoAutor colAutores bAgregarA bCompletar bAtras|

ventana := self class crearVentanaConAncho: 700 altura: 500 titulo: 'AGREGAR LIBRO'.

colAutores := OrderedCollection new.

"campos de ingreso de datos"
campoNombre := RubTextFieldMorph new extent: 680@20; ghostText: 'Ingrese nombre'.
ventana añadirMorph: campoNombre conMargen: 40.

campoEditorial := RubTextFieldMorph new extent: 680@20; ghostText: 'Ingrese editorial'.
ventana añadirMorph: campoEditorial conMargen: 20.

campoAnio := RubTextFieldMorph new extent: 680@20; ghostText: 'Ingrese el año de edición'.
ventana añadirMorph: campoAnio conMargen: 20.

campoAutor := RubTextFieldMorph new extent: 680@20; ghostText: 'Ingrese aquí el nombre completo de un autor y pulse el botón para agregarlo'.
ventana añadirMorph: campoAutor conMargen: 20.

bAgregarA := BotonGenerico_UI new textoBoton: 'Agregar autor'; definirAccion: [ (campoAutor getText ~= '') ifTrue: [ colAutores add: (campoAutor getText)asString. campoAutor setText: ''. self mensaje: 'Autor agregado correctamente.' ] ifFalse: [ self error: 'Ingrese el nombre completo del autor antes de presionar el botón' ]].
ventana añadirMorph: bAgregarA conMargen: 20. 

bCompletar := BotonGenerico_UI new textoBoton: 'Agregar libro'; definirAccion:
[
	(campoEditorial getText ~= '') & (campoNombre getText ~= '') & (campoAnio getText ~= '') & (colAutores notEmpty)
	ifTrue: 
		[ 
			nuevoLibro := Libro crearConNombre: (campoNombre getText)asString editorial: (campoEditorial getText)asString  anioEdicion: (campoAnio getText) asNumber autores: colAutores.
			system añadirLibro: nuevoLibro enBib: unaBiblioteca.
			self mensaje: 'El libro ', nuevoLibro nombre, ' ha sido agregado correctamente.'.
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
uTabla := Tabla_UI crearUConDataSource: uDataSource ancho: 970 altura: 150.
self añadirMorph: uTabla conMargen: 10.

self añadirMorph: (TextMorph new contents: 'Bibliotecas') conMargen: 10.

bDataSource := BibliotecaDataSource elements: (system getBibliotecas).
bTabla := Tabla_UI crearBConDataSource: bDataSource ancho: 970 altura: 150.
bTabla addColumn: (FTColumn id: 'Préstamos').
bTabla beSingleSelection.
(bTabla columns at: 6) width: 100.
self añadirMorph: bTabla conMargen: 10.

bAgregarB := BotonGenerico_UI new textoBoton: 'Agregar biblioteca'.
self añadirMorph: bAgregarB conMargen: 10.
bAgregarB definirAccion: [ self delete. self agregarBiblioteca ].

bModificarB := BotonGenerico_UI new textoBoton: 'Modificar biblioteca'.
bModificarB definirAccion: [ |seleccion| seleccion := (bTabla selectedIndex). (seleccion = 0) ifTrue:  [ self error: 'No seleccionó una biblioteca.' ] ifFalse: [ self delete. self modificarBiblioteca: (bDataSource elementAt: seleccion)] ].
self añadirMorph: bModificarB alLadoDe: bAgregarB. 

bGenerarListadoRetrasados := BotonGenerico_UI new textoBoton: 'Generar listado de usuarios retrasados'.
bGenerarListadoRetrasados definirAccion: [ tablaRetrasados := Tabla_UI crearUConDataSource2: (UsuarioAtrasadoDataSource elements: (system generarListadoUsuariosRetrasados) conSistema: system) ancho: 870 altura: 200 . Ventana_UI crearConMorph: tablaRetrasados ].
self añadirMorph: bGenerarListadoRetrasados conMargen: 10.

bCerrarSesion := BotonGenerico_UI new textoBoton: 'Cerrar sesión'; definirAccion: [ self delete. self vistaPrincipal ].
self añadirMorph: bCerrarSesion conMargen: 10.

self openCenteredInWorld .
]

{ #category : #'as yet unclassified' }
VistaAdmin >> modificarBiblioteca: unaBiblioteca [
|ventana lDataSource lTabla bAgregarLibro bQuitarLibro bAtras|

ventana := self class crearVentanaConAncho: 850 altura: 800 titulo: 'MODIFICAR BIBLIOTECA'.

lDataSource := LibroDataSource elements: unaBiblioteca libros.
lTabla := Tabla_UI crearLConDataSource: lDataSource ancho: 830 altura: 150.
lTabla beSingleSelection.
unaBiblioteca addDependent: lDataSource.
ventana añadirMorph: lTabla conMargen: 20.

bAgregarLibro := BotonGenerico_UI new textoBoton: 'Agregar libro'.
bAgregarLibro definirAccion: [ self agregarLibroA: unaBiblioteca ].
ventana añadirMorph: bAgregarLibro conMargen: 20.

bQuitarLibro := BotonGenerico_UI new textoBoton: 'Quitar libro'.
bQuitarLibro definirAccion: [ unaBiblioteca quitarLibro: (lDataSource elementAt: lTabla selectedIndex). self mensaje: 'El libro seleccionado ha sido quitado correctamente.' ].
ventana añadirMorph: bQuitarLibro conMargen: 20.

bAtras := (BotonGenerico_UI new textoBoton: 'Atrás').
ventana añadirMorph: bAtras conMargen: 20.
bAtras definirAccion: [ bAtras owner delete. self vistaAdmin ].

ventana openCenteredInWorld.

^ventana
]
