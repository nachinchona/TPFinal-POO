Class {
	#name : #Prestamo,
	#superclass : #Object,
	#instVars : [
		'id',
		'idBiblioteca',
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

{ #category : #accessing }
Prestamo >> idBiblioteca [
^ idBiblioteca 
]

{ #category : #'as yet unclassified' }
Prestamo >> inicializarPrestamoConId: unaId conLibros: unaColLibros deUsuario: unUsuario conDias: unaCantDias enBib: otraId [
id := unaId.
libros := unaColLibros .
idBiblioteca := otraId.
dniUsuario := unUsuario dni.
fechaRealizacion := Date today.
fechaLimite := (fechaRealizacion addDays: unaCantDias).
]

{ #category : #accessing }
Prestamo >> libros [

	^ libros
]

{ #category : #'as yet unclassified' }
Prestamo >> vencer [
"metodo utilizado a modo de testeo"
fechaRealizacion := fechaRealizacion subtractDays: 12.
fechaLimite := fechaLimite subtractDays: 12.
]
