Class {
	#name : #'BaselineOfTPFinal-POO',
	#superclass : #Object,
	#category : #'BaselineOfTPFinal-POO'
}

{ #category : #baselines }
BaselineOfTPFinal-POO >> baseline: spec [
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
BaselineOfTPFinal-POO >> projectClass [
	^ MetacelloCypressBaselineProject
]
