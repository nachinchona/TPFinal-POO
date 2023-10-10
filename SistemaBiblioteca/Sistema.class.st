Class {
	#name : #Sistema,
	#superclass : #Object,
	#instVars : [
		'colBibliotecas',
		'colUsuarios',
		'colAutores'
	],
	#category : #SistemaBiblioteca
}

{ #category : #'as yet unclassified' }
Sistema >> inicializarSistemaConColBibliotecas: colB colUsuarios: colU yColAutores: colA [
|controlDiario presTemp|
colBibliotecas := colB.
colAutores := colA.
colUsuarios := colU.
controlDiario := 
	[ Delay forSeconds: 86400.
	colBibliotecas do: [ :b | presTemp := b getPrestamos. presTemp do: [ :p | (p fechaLimite = Date tomorrow) ifTrue: [ (colUsuarios detect: [ :u | u dni = p dni ]) multarConDias: 7]  ]  ]
	] newProcess.
controlDiario name: 'Control Prestamos'.
controlDiario resume.
]
