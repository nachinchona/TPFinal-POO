Class {
	#name : #VistaPrestamo,
	#superclass : #'Sistema_UI',
	#instVars : [
		'usuario',
		'bTabla',
		'bDataSource',
		'lTabla',
		'lDataSource',
		'bElegirBiblioteca',
		'bElegirLibros',
		'librosElegidos',
		'bibliotecaElegida',
		'bCompletar',
		'bAtras'
	],
	#category : #'SistemaBiblioteca_GUI'
}

{ #category : #'as yet unclassified' }
VistaPrestamo class >> crearConSistema: unSistema usuario: unDni [
|vista|
vista := self crearVentanaConAncho:  850 altura: 650 titulo: 'GESTIÓN NUEVO PRÉSTAMO'.
vista inicializarConSistema: unSistema usuario: unDni.
^vista
]

{ #category : #initialization }
VistaPrestamo >> inicializarConSistema: unSistema usuario: unDni [
|cajaNegra|

"cajaNegra es el espacio que ocupa lTabla luego de seleccionar una biblioteca"
cajaNegra := Morph new color: Color black; extent: 830@150.

system := unSistema .
usuario := system buscarUsuarioConDni: unDni.

self añadirMorph: (TextMorph new contents: 'Selecciona la biblioteca en la cual deseas realizar tu préstamo') conMargen: 20.

bDataSource := BibliotecaDataSource elements: (usuario bibliotecasInteres).
bTabla := Tabla_UI crearBConDataSource: bDataSource ancho: 830 altura: 150.
bTabla beSingleSelection.
self añadirMorph: bTabla conMargen: 20.

bElegirBiblioteca := BotonGenerico_UI new textoBoton: 'Elegir biblioteca'.
self añadirMorph: bElegirBiblioteca conMargen: 20.
bElegirBiblioteca definirAccion:
[
bibliotecaElegida := bDataSource elementAt: (bTabla selectedIndex).
lDataSource := LibroDataSource elements: bibliotecaElegida libros.
lTabla := Tabla_UI crearLConDataSource: lDataSource ancho: 830 altura: 150.
self replaceSubmorph: cajaNegra by: lTabla.
].

self añadirMorph: cajaNegra conMargen: 20.

librosElegidos := OrderedCollection new.

bElegirLibros := BotonGenerico_UI new textoBoton: 'Elegir libros'.
self añadirMorph: bElegirLibros conMargen: 20.
bElegirLibros definirAccion: [ librosElegidos := (lTabla selectedIndexes) collect: [ :i | lDataSource elementAt: i ]. lTabla deselectAll. bElegirLibros deshabilitar  ].

bCompletar := BotonGenerico_UI new textoBoton: 'Completar'.
self añadirMorph: bCompletar conMargen: 20.
bCompletar definirAccion: [ (bibliotecaElegida registrarPrestamoConLibros: librosElegidos deUsuario: usuario) ifFalse: [ self error: ('Ha ocurrido un error.') ] ifTrue: [self mensaje: 'Su préstamo ha sido registrado correctamente.' conAccion: [self delete. self vistaUsuario: unDni ] ]].

"boton atras que vuelve a la vista usuario"
bAtras := (BotonGenerico_UI new textoBoton: 'Atrás').
self añadirMorph: bAtras conMargen: 20.
bAtras definirAccion: [ self delete. self vistaUsuario: unDni ].

self openCenteredInWorld .
]
