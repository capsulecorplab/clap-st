Class {
	#name : #ClapScratchTest,
	#superclass : #TestCase,
	#category : 'Clap-Tests'
}

{ #category : #tests }
ClapScratchTest >> testFooBarBaz [
	| matches argv |
	argv := Mock named: 'argv'.
	argv stub peek willReturnValueFrom: #('foo' 'bar' 'baz').
	argv stub next willReturnValueFrom: #('foo' 'bar' 'baz').
		
	matches := (ClapCommand withName: 'foo')
		add: (ClapPositional withName: 'one');
		add: (ClapPositional withName: 'two');
		matchOn: argv.
	
	matches should not be isMismatch.
	matches should be includesKey: 'one'.
	(matches at: 'one') should equal: 'bar'.
	matches should be includesKey: 'two'.
	(matches at: 'two') should equal: 'baz'
]

{ #category : #tests }
ClapScratchTest >> testHello [
	| hello argv matches |
	hello := ClapCommand withName: 'hello'.
	hello canonicalName should equal: 'hello'.
	
	argv := Mock named: 'argv'.
	argv stub peek willReturn: 'hello'.
	argv stub next willReturn: 'hello'.
	
	matches := hello matchOn: argv.
	
	argv should receive next.
	matches should not be isMismatch.
	matches alias should equal: 'hello'
]

{ #category : #tests }
ClapScratchTest >> testHelloAtEnd [
	| hello argv matches |
	hello := ClapCommand withName: 'hello'.
	
	argv := Mock named: 'argv'.
	argv stub peek willReturn: nil.
	
	matches := hello matchOn: argv.
	
	argv should not receive next.
	matches should be isMismatch
]

{ #category : #tests }
ClapScratchTest >> testHelloMismatch [
	| hello argv matches |
	hello := ClapCommand withName: 'hello'.
	
	argv := Mock named: 'argv'.
	argv stub peek willReturn: 'foo'.
	
	matches := hello matchOn: argv.
	
	argv should not receive next.
	matches should be isMismatch
]

{ #category : #tests }
ClapScratchTest >> testHelloWorld [
	| matches argv |
	argv := Mock named: 'argv'.
	argv stub peek willReturnValueFrom: #('hello' 'world').
	argv stub next willReturnValueFrom: #('hello' 'world').
		
	matches := (ClapCommand withName: 'hello')
		add: (ClapPositional withName: 'who');
		matchOn: argv.
	
	matches should not be isMismatch.
	matches alias should equal: 'hello'.
	matches should be includesKey: 'who'.
	(matches at: 'who') should equal: 'world'
]