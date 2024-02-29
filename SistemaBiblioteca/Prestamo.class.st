Class {
	#name : #Prestamo,
	#superclass : #Object,
	#instVars : [
		'id',
		'usuario',
		'fechaRealizacion',
		'fechaLimite',
		'fechaEntrega',
		'libros'
	],
	#category : #SistemaBiblioteca
}

{ #category : #'as yet unclassified' }
Prestamo >> esDeUsuario: unUsuario [
^ usuario = unUsuario
]

{ #category : #accessing }
Prestamo >> esPlus [
"chequea si esPlus (solo tiene audioLibros)"
^ libros first esAudioLibro

]

{ #category : #accessing }
Prestamo >> estaActivo [
^ fechaEntrega isNil
]

{ #category : #'as yet unclassified' }
Prestamo >> estaVencido [
self estaActivo
ifTrue:
[ (fechaLimite isBefore: (Date today)) ifTrue: [ ^ true ] ifFalse: [ ^ false ] ]
ifFalse: 
[ ^ false ]
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
usuario := unUsuario.
fechaRealizacion := Date today.
fechaLimite := (fechaRealizacion addDays: unaCantDias).
fechaEntrega := nil.
]

{ #category : #accessing }
Prestamo >> libros [

	^ libros
]

{ #category : #'as yet unclassified' }
Prestamo >> marcarComoEntregado [
libros do: [ :l | l desmarcar ].
fechaEntrega := Date today.
]

{ #category : #'as yet unclassified' }
Prestamo >> reasignarUsuario: unUsuario [
usuario := unUsuario .
]

{ #category : #accessing }
Prestamo >> usuario [
^usuario
]

{ #category : #'as yet unclassified' }
Prestamo >> vencer [
"metodo utilizado a modo de testeo"
fechaRealizacion := fechaRealizacion subtractDays: 12.
fechaLimite := fechaLimite subtractDays: 12.
]
