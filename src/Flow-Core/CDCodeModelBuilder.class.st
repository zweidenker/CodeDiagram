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
CDCodeModelBuilder >> outgoingMethodsFor: aPragma [ 
	| outgoing |
	
	outgoing := aPragma arguments fourth.
	^ outgoing isString 
		ifTrue: [ 
			(outgoing = #self) 
				ifTrue: [ aPragma method  ]]
		ifFalse: [ 
			outgoing pairsCollect: [ :className :selector | 
				(self class environment at: className) >> selector asSymbol ] ]
]

{ #category : #'as yet unclassified' }
CDCodeModelBuilder >> pragmaName [ 
	^ self class pragmaName
]

{ #category : #resolving }
CDCodeModelBuilder >> resolve: method [
	"Each has method has representative state. If there is a seqeuence of pragmas all but the
	last are considered to be local (outgoing being #self)"
	| pragmas entities |
	"if the method has been treated we return the cached entity. This enables multiple incoming
	connections"
	seen 
		at: method 
		ifPresent: [ :e | ^ e ].
		
	"treat a sequence of pragmas if there are multiple. As the pragmas are local bound we can 
	construct the flow entities immediately. Otherwise this conflicts with the recursive behavior"
	pragmas := method pragmas.
	entities := pragmas allButLast 
		collect: [ :nextPragma |
			self assert: (nextPragma arguments fourth = #self).
			self newEntityNamed: nextPragma ]
		as: OrderedCollection.
	
	"add the last entity which is always there. If there is only one pragma then first = last"
	entities add: (self newEntityNamed: pragmas last ).
	
	"store first encountered entity as representative"
	seen 
		at: method
		put: entities first.

	"connect all local generated entities with each other"
	entities allButFirst withIndexDo: [ :entity :idx |
		 entity incoming: (entities at: idx) ].
	
	"Now that the seen cache is set up and the local entities in place we can recursre to the next 
	entity which is the last"
	entities last
		resolve: (self outgoingMethodsFor: pragmas last)
		builder: self.
	
	^ entities first
]

{ #category : #setting }
CDCodeModelBuilder >> startAt: aClass method: aString [

	startState := self resolve: aClass >> aString asSymbol
]
