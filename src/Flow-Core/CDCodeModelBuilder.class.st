Class {
	#name : #CDCodeModelBuilder,
	#superclass : #Object,
	#instVars : [
		'flowName',
		'startState',
		'seen'
	],
	#category : #'Flow-Core'
}

{ #category : #accessing }
CDCodeModelBuilder >> flowName: anObject [
	flowName := anObject
]

{ #category : #initialization }
CDCodeModelBuilder >> initialize [ 
	super initialize.
	seen := OrderedCollection new.
]

{ #category : #accessing }
CDCodeModelBuilder >> model [
	^ startState
]

{ #category : #'as yet unclassified' }
CDCodeModelBuilder >> nextPragmaIn: aCompiledMethod [ 
	| candidates |
	candidates := aCompiledMethod pragmas
		select: [ :each | each selector = self pragmaName & (each arguments first = flowName) ].
	candidates do: [ :each | 
		(seen includes: each) ifFalse: [ 
			seen add: each.
			^ each ] ].
	CDPragmaNotFound signal: 'no pragma in sequence found'
	
	
]

{ #category : #'as yet unclassified' }
CDCodeModelBuilder >> outgoingSpecFor: aPragma [ 
	| outgoing |
	
	outgoing := aPragma arguments fourth.
	outgoing isString ifTrue: [ 
		(outgoing = #self) 
			ifTrue: [ ^ { aPragma method methodClass name. aPragma method selector } ] ].
	^ outgoing 
	
]

{ #category : #'as yet unclassified' }
CDCodeModelBuilder >> pragmaName [
	^ #flow:element:label:outgoing:
]

{ #category : #resolving }
CDCodeModelBuilder >> resolve: aCollection [ 
	| method pragma state |
	method := self resolveMethod: aCollection.
	pragma := self nextPragmaIn: method.
	state := (CDFlowEntity withName: pragma arguments second) new.
	state label: pragma arguments third.
	^ state 
		resolve: (self outgoingSpecFor: pragma)
		builder: self
]

{ #category : #'as yet unclassified' }
CDCodeModelBuilder >> resolve: flowName no: aCollection [
	^ self resolve: flowName outgoing: aCollection 
]

{ #category : #'as yet unclassified' }
CDCodeModelBuilder >> resolve: aString outgoing: aCollection [ 
	| method pragma state |
	method := self resolveMethod: aCollection.
	pragma := (method pragmaAt: #flow:element:outgoing:) 
	pragma ifNil: [ CDPragmaNotFound signal ].
	state := (CDBlockObject withName: pragma arguments second) new.
	state label: pragma arguments first.
	^ state 
		resolve: pragma arguments first
		in: pragma arguments third
		builder: self
]

{ #category : #'as yet unclassified' }
CDCodeModelBuilder >> resolve: flowName yes: aCollection [
	^ self resolve: flowName outgoing: aCollection 
]

{ #category : #'as yet unclassified' }
CDCodeModelBuilder >> resolveMethod: aCollection [ 
	| targetClass |
	self assert: aCollection size = 2.
	targetClass := self class environment at: aCollection first asSymbol.
	^ targetClass >> aCollection second
]

{ #category : #setting }
CDCodeModelBuilder >> startAt: aClass method: aString [

	
	startState := CDStartState labelled: 'Start'.
	startState resolve: { aClass name . aString } builder: self.
]
