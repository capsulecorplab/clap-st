Class {
	#name : #ClapMatchTest,
	#superclass : #TestCase,
	#instVars : [
		'subject',
		'specification',
		'word'
	],
	#category : 'Clap-Tests-Unit'
}

{ #category : #running }
ClapMatchTest >> classToTest [
	^ ClapMatch
]

{ #category : #running }
ClapMatchTest >> setUp [
	specification := Mock named: 'spec'.
	word := Mock named: 'word'.
	subject := self classToTest of: specification with: word
]

{ #category : #tests }
ClapMatchTest >> testAccessing [
	subject specification should be: specification.
	subject word should be: word
]

{ #category : #tests }
ClapMatchTest >> testAddingToParentAddsByName [
	| parent specName |
	specName := Mock new.
	specification stub canonicalName willReturn: specName.
	parent := Mock named: 'parent'.
	(parent stub recordParameterMatch: subject) willReturnYourself.
	
	subject recordIn: parent.
	
	(parent should receive recordParameterMatch: subject) once
]

{ #category : #'as yet unclassified' }
ClapMatchTest >> testMatchesAreNotMismatches [
	subject isMismatch should be: false.
	subject ifMismatch: [ self fail ]
]

{ #category : #'as yet unclassified' }
ClapMatchTest >> testValue [
	subject value.
	specification should receive meaningOf: subject
]