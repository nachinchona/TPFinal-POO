Class {
	#name : #BaselineOfSistemaBiblioteca,
	#superclass : #BaselineOf,
	#category : #BaselineOfSistemaBiblioteca
}

{ #category : #baselines }
BaselineOfSistemaBiblioteca >> baseline: spec [
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
BaselineOfSistemaBiblioteca >> projectClass [
	^ MetacelloCypressBaselineProject
]
