Class {
	#name : #BaselineOfTPFinalPOO,
	#superclass : #BaselineOf,
	#category : #BaselineOfTPFinalPOO
}

{ #category : #baselines }
BaselineOfTPFinalPOO >> baseline: spec [
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

{ #category : #baselines }
BaselineOfTPFinalPOO >> projectClass [
	^ MetacelloCypressBaselineProject
	
]
