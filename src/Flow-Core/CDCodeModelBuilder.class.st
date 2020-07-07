Class {
	#name : #CDCodeModelBuilder,
	#superclass : #Object,
	#instVars : [
		'startState'
	],
	#category : #'Flow-Core'
}

{ #category : #'as yet unclassified' }
CDCodeModelBuilder >> model [
	^ startState
]

{ #category : #'as yet unclassified' }
CDCodeModelBuilder >> resolve: flowName no: aCollection [
	^ self resolve: flowName outgoing: aCollection 
]

{ #category : #'as yet unclassified' }
CDCodeModelBuilder >> resolve: aString outgoing: aCollection [ 
	| method pragma state |
	method := self resolveMethod: aCollection.
	pragma := method pragmaAt: #flow:element:outgoing:.
	state := (CDStateObject withName: pragma arguments second) new.
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
	targetClass := self class environment at: aCollection first.
	^ targetClass >> aCollection second
]

{ #category : #setting }
CDCodeModelBuilder >> startAt: aClass method: aString [

	
	startState := CDStartState labelled: 'Start'.
	startState resolve: #start in: { aClass name . aString } builder: self.
]
