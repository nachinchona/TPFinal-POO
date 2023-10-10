Class {
	#name : #Prestamo,
	#superclass : #Object,
	#instVars : [
		'id',
		'dniUsuario',
		'fechaRealizacion',
		'fechaLimite',
		'libros'
	],
	#category : #SistemaBiblioteca
}

{ #category : #'as yet unclassified' }
Prestamo >> dni [
^ dniUsuario 
]

{ #category : #accessing }
Prestamo >> fechaLimite [

	^ fechaLimite
]

{ #category : #accessing }
Prestamo >> fechaRealizacion [

	^ fechaRealizacion
]

{ #category : #accessing }
Prestamo >> id [

	^ id
]

{ #category : #'as yet unclassified' }
Prestamo >> inicializarPrestamoConId: unaId conLibros: unaColLibros deUsuario: unUsuario conDias: unaCantDias [
id := unaId.
libros := unaColLibros .
dniUsuario := unUsuario dni.
fechaRealizacion := Date today.
fechaLimite := (fechaRealizacion addDays: unaCantDias).
]

{ #category : #accessing }
Prestamo >> libros [

	^ libros
]
