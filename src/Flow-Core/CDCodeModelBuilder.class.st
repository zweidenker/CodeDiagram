Class {
	#name : #CDCodeModelBuilder,
	#superclass : #Object,
	#instVars : [
		'startState'
	],
	#category : #'Flow-Core'
}

{ #category : #'as yet unclassified' }
CDCodeModelBuilder >> colorFromPragma: pragma [
	| colorString |
	colorString := pragma arguments at: 4 ifAbsent: [ #lightYellow ].
	^ (Color fromString: colorString) alpha: 0.7
]

{ #category : #'as yet unclassified' }
CDCodeModelBuilder >> flowPragmas: aMethod [
	| pragmas |
	pragmas := aMethod pragmas 
		select: [ :p | p selector includesSubstring: #flow:element:outgoing: ].
	pragmas ifEmpty: [ CDPragmaNotFound signal ].
	^ pragmas 
]

{ #category : #'as yet unclassified' }
CDCodeModelBuilder >> model [
	^ startState
]

{ #category : #'as yet unclassified' }
CDCodeModelBuilder >> resolveFrom: aPragma no: aCollection [
	^ self resolveFrom: aPragma outgoing: aCollection 
]

{ #category : #'as yet unclassified' }
CDCodeModelBuilder >> resolveFrom: aPragma outgoing: aCollection [ 
	| method nextPragma pragmas state |
	method := self resolveMethod: aCollection from: aPragma.
	
	pragmas := (self flowPragmas: method).
	
	nextPragma := pragmas 
		after: aPragma
		ifAbsent: [  pragmas first ].

	state := (CDBlockObject withName: nextPragma arguments second) new.
	state label: nextPragma arguments first.
	state color: (self colorFromPragma: nextPragma).

	^ state 
		resolveFrom: nextPragma
		in: nextPragma arguments third
		builder: self
]

{ #category : #'as yet unclassified' }
CDCodeModelBuilder >> resolveFrom: aPragma yes: aCollection [
	^ self resolveFrom: aPragma outgoing: aCollection 
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
