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

{ #category : #'as yet unclassified' }
CDCodeModelBuilder class >> allPragmas [
	^ (PragmaCollector new 
		filter: [ :each | each selector = self pragmaName ];
		reset) collected
]

{ #category : #'as yet unclassified' }
CDCodeModelBuilder class >> flowWithName: aString [ 
	| method |
	method := (self allPragmas detect: [ :each |
		each arguments first = aString &
		(each arguments second = #start) ]) method.
	^ self new
		flowName: aString;
		startAt: method methodClass method: method selector;
		model
]

{ #category : #'as yet unclassified' }
CDCodeModelBuilder class >> pragmaName [
	^ #flow:element:label:outgoing:
]

{ #category : #accessing }
CDCodeModelBuilder >> flowName: anObject [
	flowName := anObject
]

{ #category : #initialization }
CDCodeModelBuilder >> initialize [ 
	super initialize.
	seen := Dictionary new.
]

{ #category : #accessing }
CDCodeModelBuilder >> model [
	^ startState
]

{ #category : #resolving }
CDCodeModelBuilder >> newEntityNamed: aPragma [ 	

	^ (CDFlowEntity withName: aPragma arguments second) new
		label: aPragma arguments third
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
	^ self class pragmaName
]

{ #category : #resolving }
CDCodeModelBuilder >> resolve: aCollection [ 
	| method pragmas entities |
	method := self resolveMethod: aCollection.
	seen 
		at: method 
		ifPresent: [ :e | ^ e ].
		
	pragmas := method pragmas.
	entities := pragmas allButLast 
		collect: [ :nextPragma |
			self assert: (nextPragma arguments fourth = #self).
			self newEntityNamed: nextPragma ]
		as: OrderedCollection.
	
	entities add: (self newEntityNamed: pragmas last ).
	seen 
		at: method
		put: entities first.

	entities allButFirst withIndexDo: [ :entity :idx |
		 entity incoming: (entities at: idx) ].
	
	entities last
		resolve: (self outgoingSpecFor: pragmas last)
		builder: self.
	^ seen at: method
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

	
	startState := self resolve: { aClass name . aString }.
]
