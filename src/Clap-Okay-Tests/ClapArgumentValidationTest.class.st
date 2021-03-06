Class {
	#name : #ClapArgumentValidationTest,
	#superclass : #TestCase,
	#category : #'Clap-Okay-Tests'
}

{ #category : #tests }
ClapArgumentValidationTest >> testFailValidationWhenMissingMandatoryArgument [
	| flag match report |
	flag := (ClapFlag id: #lang)
		add: (ClapPositional id: #langCode);
		validations: [ :arg | {
			Okay if: [ :it | (it at: #langCode) isExplicit ]
		} collect: [ :each | each validate: arg ] ].
	
	match := flag match: #('--lang').
	report := ClapValidationReport success.
	match validateOn: report.
	
	self assert: report isFailure
]

{ #category : #tests }
ClapArgumentValidationTest >> testPassValidationWithMandatoryArgument [
	| flag match report |
	flag := (ClapFlag id: #lang)
		add: (ClapPositional id: #langCode);
		validations: [ :arg | {
			Okay if: [ :it | (it at: #langCode) isExplicit ]
		} collect: [ :each | each validate: arg ] ].
	
	match := flag match: #('--lang' 'eo').
	report := ClapValidationReport success.
	match validateOn: report.
	
	self assert: report isSuccess
]
