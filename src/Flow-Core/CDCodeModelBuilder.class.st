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
CDCodeModelBuilder >> resolveMethod: aCollection [ 

	| targetClass |
	targetClass := self class environment at: aCollection first.
	^ targetClass >> aCollection second
]

{ #category : #'as yet unclassified' }
CDCodeModelBuilder >> resolveOutgoing: aCollection at: index [
	| method pragma state |
	method := self resolveMethod: aCollection.
	pragma := (self flowPragmas: method) at: index.
	state := (CDBlockObject withName: pragma arguments second) new.
	state label: pragma arguments first.
	^ pragma arguments third = #self
		ifTrue: [ state
				resolveOutgoing: aCollection
				at: index + 1
				builder: self ]
		ifFalse: [ state
				resolveOutgoing: pragma arguments third
				at: 1
				builder: self ]
]

{ #category : #setting }
CDCodeModelBuilder >> startAt: aClass method: aString [

	
	startState := CDStartState labelled: 'Start'.
	startState resolveOutgoing: { aClass name . aString } at: 1 builder: self.
]
