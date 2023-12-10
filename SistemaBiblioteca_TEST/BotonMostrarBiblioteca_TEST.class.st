Class {
	#name : #'BotonMostrarBiblioteca_TEST',
	#superclass : #SimpleButtonMorph,
	#instVars : [
		'system',
		'ventana',
		'colInfo',
		'colLibros'
	],
	#category : #'SistemaBiblioteca_TEST'
}

{ #category : #'as yet unclassified' }
BotonMostrarBiblioteca_TEST >> asignarSistema: unSistema [
system := unSistema .
]

{ #category : #'as yet unclassified' }
BotonMostrarBiblioteca_TEST >> inicializarConSistema: unSistema [
self asignarSistema: unSistema.
self label: 'Mostrar biblioteca' font: (LogicalFont familyName: 'Roboto' pointSize: 14). 
]

{ #category : #'as yet unclassified' }
BotonMostrarBiblioteca_TEST >> mostrarInfoDeBiblioteca: unaBiblioteca [
|coleccionLibros|
ventana := Sistema_UI crearVentanaConAncho: 600 altura: 402.
colInfo := BorderedMorph new color: Color gray; borderColor: Color lightGray; borderWidth: 3; extent: 590@145.
colLibros := BorderedMorph new color: Color gray; borderColor: Color lightGray; borderWidth: 3; extent: 590@245.

colInfo añadirFilaCon: (('INFORMACIÓN DE LA BIBLIOTECA' asText) allBold).
colInfo añadirFilaCon: 'ID: ', (unaBiblioteca id) asString.
colInfo añadirFilaCon: 'Nombre: ', (unaBiblioteca nombre).
colInfo añadirFilaCon: 'Nombre de representante: ', (unaBiblioteca nombreRepresentante).
colInfo añadirFilaCon: 'Dirección: ', (unaBiblioteca direccion).
colInfo añadirFilaCon: 'Teléfono:  ', (unaBiblioteca telefono) asString.

colLibros añadirFilaCon: (('INFORMACIÓN DE SUS LIBROS (nombre, año, autores, editorial, esAudioLibro, estaEnDeuda)' asText) allBold).
coleccionLibros := unaBiblioteca libros.
coleccionLibros do: [ :l | colLibros añadirFilaCon: (l nombre) asString,', ',(l anioEdicion) asString,', ', (l autores) asString,', ', (l editorial) asString,', ', (l esAudioLibro) asString,', ', (l estaEnDeuda) asString  ].

ventana addMorph: colInfo.
ventana addMorph: colLibros.
colInfo position: ventana position + 5.
colLibros position: (colInfo position + (0@(colInfo height+2))).

ventana openCenteredInWorld .

]

{ #category : #'event handling' }
BotonMostrarBiblioteca_TEST >> mouseUp: anEvent [
|userInput unaBiblioteca|
super mouseUp: anEvent .
userInput := UIManager default request: 'Ingrese la ID de biblioteca que desea buscar: '.
userInput
ifNil:
[ UIManager default abort: 'La ID no ha sido ingresada correctamente. ' ]
ifNotNil: 
[ 
unaBiblioteca := (system buscarBibliotecaConId: (userInput asInteger)) .
unaBiblioteca
ifNil:
[ UIManager default abort: 'La biblioteca con la ID ingresada no existe. ' ]
ifNotNil:
[ self mostrarInfoDeBiblioteca: unaBiblioteca ]
].
]
