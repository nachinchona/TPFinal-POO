"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestSistemaBiblioteca,
	#superclass : #PackageManifest,
	#category : #'SistemaBiblioteca-Manifest'
}

{ #category : #'code-critics' }
ManifestSistemaBiblioteca class >> ruleTempsReadBeforeWrittenRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#'Usuario class' #crearConNombre:apellido:dni:contraseña: #true)) #'2023-07-19T20:05:33.478-03:00') )
]

{ #category : #'code-critics' }
ManifestSistemaBiblioteca class >> ruleUnclassifiedMethodsRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGPackageDefinition #(#Libreria)) #'2023-09-05T22:08:16.015-03:00') )
]
