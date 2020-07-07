Class {
	#name : #FCCodeModelBuilder,
	#superclass : #Object,
	#instVars : [
		'startState'
	],
	#category : #'Flow-Core'
}

{ #category : #'as yet unclassified' }
FCCodeModelBuilder >> model [
	^ startState
]

{ #category : #setting }
FCCodeModelBuilder >> processFlow: flowName stateClass: aState for: anObject [
	aState
		label: flowName.
	aState resolve: flowName in: anObject builder: self.
	^ aState
]

{ #category : #'as yet unclassified' }
FCCodeModelBuilder >> resolve: flowName no: aCollection [
	^ self resolve: flowName outgoing: aCollection 
]

{ #category : #'as yet unclassified' }
FCCodeModelBuilder >> resolve: aString outgoing: aCollection [ 
	| method pragma state |
	method := self resolveMethod: aCollection.
	pragma := method pragmaAt: #flow:element:outgoing:.
	state := (StateObject withName: pragma arguments second) new.
	state label: pragma arguments first.
	^ state 
		resolve: pragma arguments first
		in: pragma arguments third
		builder: self
]

{ #category : #'as yet unclassified' }
FCCodeModelBuilder >> resolve: flowName yes: aCollection [
	^ self resolve: flowName outgoing: aCollection 
]

{ #category : #'as yet unclassified' }
FCCodeModelBuilder >> resolveMethod: aCollection [ 
	| targetClass |
	self assert: aCollection size = 2.
	targetClass := self class environment at: aCollection first.
	^ targetClass >> aCollection second
]

{ #category : #setting }
FCCodeModelBuilder >> startAt: aClass method: aString [

	
	startState := StartState labelled: 'Start'.
	 self 
		processFlow: #start 
		stateClass: startState
		for: { aClass name . aString }
]

{ #category : #setting }
FCCodeModelBuilder >> startStateClass: aCompiledMethod [

	startState := self 
		processFlow: #start 
		stateClass: StartState new 
		for: aCompiledMethod 
]
