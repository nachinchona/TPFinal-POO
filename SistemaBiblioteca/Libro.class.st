Class {
	#name : #Libro,
	#superclass : #Object,
	#instVars : [
		'nombre',
		'editorial',
		'anioEdicion',
		'autores',
		'enDeuda',
		'dniTemp'
	],
	#category : #SistemaBiblioteca
}

{ #category : #'as yet unclassified' }
Libro class >> crearConNombre: unNombre editorial: unaEd anioEdicion: unAnio autores: unaColA [
|unLibro|
unLibro := self new.
unLibro inicializarConNombre:  unNombre editorial: unaEd anioEdicion: unAnio autores: unaColA.
^ unLibro

]

{ #category : #accessing }
Libro >> anioEdicion [

	^ anioEdicion
]

{ #category : #accessing }
Libro >> anioEdicion: anObject [

	anioEdicion := anObject
]

{ #category : #accessing }
Libro >> autores [

	^ autores
]

{ #category : #accessing }
Libro >> autores: anObject [

	autores := anObject
]

{ #category : #'as yet unclassified' }
Libro >> desmarcar [
enDeuda := false.
dniTemp := 0.
]

{ #category : #accessing }
Libro >> editorial [

	^ editorial
]

{ #category : #accessing }
Libro >> editorial: anObject [

	editorial := anObject
]

{ #category : #'as yet unclassified' }
Libro >> esAudioLibro [
^ false
]

{ #category : #'as yet unclassified' }
Libro >> estaEnDeuda [
^ enDeuda
]

{ #category : #'as yet unclassified' }
Libro >> inicializarConNombre: unNombre editorial: unaEd anioEdicion: unAnio autores: unaColA [
nombre := unNombre.
editorial := unaEd.
anioEdicion := unAnio .
autores := unaColA .
enDeuda := false.
dniTemp := 0.
]

{ #category : #'as yet unclassified' }
Libro >> marcarConDni: unDni [
enDeuda := true.
dniTemp := unDni.
]

{ #category : #accessing }
Libro >> nombre [

	^ nombre
]

{ #category : #accessing }
Libro >> nombre: anObject [

	nombre := anObject
]
