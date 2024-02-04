Class {
	#name : #BaselineOfSistemaGestorBibliotecas,
	#superclass : #Object,
	#category : #BaselineOfSistemaGestorBibliotecas
}

{ #category : #baselines }
BaselineOfSistemaGestorBibliotecas >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			"The main code of the baseline will go here"
			spec
				package: 'SistemaBiblioteca';
				package: 'SistemaBiblioteca_GUI'
		]
]

{ #category : #accessing }
BaselineOfSistemaGestorBibliotecas >> projectClass [
	^ MetacelloCypressBaselineProject
]
