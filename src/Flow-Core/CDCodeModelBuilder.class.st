Class {
	#name : #CDCodeModelBuilder,
	#superclass : #Object,
	#instVars : [
		'startState'
	],
	#category : #'Flow-Core'
}

{ #category : #'as yet unclassified' }
CDCodeModelBuilder >> flowPragmas: aMethod [
	| pragmas |
	pragmas := aMethod pragmas 
		select: [ :p | p selector = #flow:element:outgoing: ].
	pragmas ifEmpty: [ CDPragmaNotFound signal ].
	^ pragmas
]

{ #category : #'as yet unclassified' }
CDCodeModelBuilder >> model [
	^ startState
]

{ #category : #'as yet unclassified' }
CDCodeModelBuilder >> resolve: flowName outgoing: aCollection at: pragmaIndex [
	| method pragma state |
	method := self resolveMethod: aCollection.
	pragma := (self flowPragmas: method) at: pragmaIndex.
	state := (CDBlockObject withName: pragma arguments second) new.
	state label: pragma arguments first.
	^ pragma arguments third = #self
		ifTrue: [ state
				resolve: pragma arguments first
				in: aCollection
				at: pragmaIndex + 1
				builder: self ]
		ifFalse: [ state
				resolve: pragma arguments first
				in: pragma arguments third
				at: 1
				builder: self ]
]

{ #category : #'as yet unclassified' }
CDCodeModelBuilder >> resolveFrom: aPragma outgoing: aCollection [ 
	| method pragmas nextPragma state |
	method := self resolveMethod: aCollection from: aPragma.
	pragmas := (self flowPragmas: method).
	
	nextPragma := pragmas 
		after: aPragma
		ifAbsent: [  pragmas first ].

	state := (CDBlockObject withName: nextPragma arguments second) new.
	state label: nextPragma arguments first.

	^ state 
		resolveFrom: nextPragma
		in: nextPragma arguments third
		builder: self
]

{ #category : #'as yet unclassified' }
CDCodeModelBuilder >> resolveMethod: aCollection [ 

	| targetClass |
	targetClass := self class environment at: aCollection first.
	^ targetClass >> aCollection second
]

{ #category : #'as yet unclassified' }
CDCodeModelBuilder >> resolveMethod: aCollection from: aPragma [
	| targetClass |
	(aCollection = #self) 
		ifTrue: [ ^ aPragma method ].
	targetClass := self class environment at: aCollection first.
	^ targetClass >> aCollection second
]

{ #category : #setting }
CDCodeModelBuilder >> startAt: aClass method: aString [

	
	startState := CDStartState labelled: 'Start'.
	startState resolveFrom: #start in: { aClass name . aString } builder: self.
]
