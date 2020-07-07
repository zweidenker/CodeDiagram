Class {
	#name : #CDStateObjectVisitor,
	#superclass : #Object,
	#instVars : [
		'positions',
		'solver',
		'seen',
		'edges'
	],
	#category : #'Flow-Core'
}

{ #category : #visiting }
CDStateObjectVisitor >> columnSize [
	^ self shapeSize * 2
]

{ #category : #accessing }
CDStateObjectVisitor >> edges [
	^ edges
]

{ #category : #initialization }
CDStateObjectVisitor >> initialize [ 	
	super initialize.
	positions := Dictionary new.
	solver := ClSimplexSolver new.
	seen := OrderedDictionary new.
	edges := OrderedCollection new
]

{ #category : #visiting }
CDStateObjectVisitor >> layout: aState [ 
	self visit: aState.
	"self postProcess"
]

{ #category : #accessing }
CDStateObjectVisitor >> objects [
	^ positions keys
]

{ #category : #accessing }
CDStateObjectVisitor >> positionAt: aState [ 
	aState ifNil: [ Error signal: 'nil does not work' ].
	^ self positions 
		at: aState
		ifAbsentPut: [ 
			(ClVariable newWith: 0 name: aState asString, ':X')
				@ (ClVariable newWith: 0 name: aState asString, ':Y') ]
]

{ #category : #accessing }
CDStateObjectVisitor >> positions [
	^ positions
]

{ #category : #'as yet unclassified' }
CDStateObjectVisitor >> postProcess [
	| assocs |
	assocs := positions associations.
	assocs do: [ :outer |
		"solver
			addConstraint: (outer value x cnGEQ: 0 strength: ClStrength required);
			addConstraint: (outer value y cnLEQ: 2000 strength: ClStrength required)."
		assocs do: [ :inner |
			( (assocs indexOf: outer) < (assocs indexOf: inner) )  ifTrue: [ 
				solver 
					addConstraint: (outer value x cnLEQ: inner value x - self columnSize strength: ClStrength strong weight: 2.0);
					addConstraint: (outer value x cnGEQ: inner value x + self columnSize strength: ClStrength strong weight: 1.0);
					addConstraint: (outer value y cnGEQ: inner value y + self rowSize strength: ClStrength strong weight: 2.0)";
					addConstraint: (outer value y cnLEQ: inner value y - self rowSize strength: ClStrength strong weight: 1.0)".
 ] ]
		 ]

]

{ #category : #visiting }
CDStateObjectVisitor >> rowSize [
	^ self shapeSize * 1.5
]

{ #category : #accessing }
CDStateObjectVisitor >> shapeSize [
	^ 150
]

{ #category : #accessing }
CDStateObjectVisitor >> solver [
	^ solver
]

{ #category : #visiting }
CDStateObjectVisitor >> visit: aState [ 
	^ seen 
		at: aState
		ifAbsent: [ 
			seen at: aState put: Object new.
			aState acceptStateVisitor: self ]
]

{ #category : #visiting }
CDStateObjectVisitor >> visitAction: anAction [ 
	| position incomingPosition outgoingPosition |
	position := self positionAt: anAction.
	incomingPosition := self positionAt: anAction incoming.

	solver 
		addConstraint: (position x cnGEQ: incomingPosition x + self columnSize strength: ClStrength medium);
		addConstraint: (position y cnGEQ: incomingPosition y strength: ClStrength medium).
	anAction outgoing ifNotNil: [ 
		edges add: (anAction -> (anAction outgoing)).
		outgoingPosition := self positionAt: anAction outgoing.
		solver 
			addConstraint: (position x + self columnSize cnLEQ: outgoingPosition x strength: ClStrength medium).
		self visit: anAction outgoing ]
]

{ #category : #visiting }
CDStateObjectVisitor >> visitCondition: aCondition [ 
	| position yesPosition noPosition incomingPosition |
	position := self positionAt: aCondition.
	yesPosition := self positionAt: aCondition yes.
	noPosition := self positionAt: aCondition no.
	incomingPosition := self positionAt: aCondition incoming. 
	solver 
		addConstraint: (position y cnEqual: yesPosition y strength: ClStrength required);
		addConstraint: (position x cnEqual: noPosition x strength: ClStrength required);
		addConstraint: (yesPosition x cnGEQ: position x + self columnSize strength: ClStrength required);
		addConstraint: (noPosition y cnGEQ: position y + self rowSize strength: ClStrength strong);
		addConstraint: (position y cnGEQ: incomingPosition y + self rowSize strength: ClStrength medium).
	edges add: (aCondition -> (aCondition yes)).
	edges add: (aCondition -> (aCondition no)).

	self visit: aCondition yes.
	self visit: aCondition no.
]

{ #category : #visiting }
CDStateObjectVisitor >> visitEnd: anEndState [ 
	| position incomingPosition |
	position := self positionAt: anEndState.
	incomingPosition := self positionAt: anEndState incoming.
	self solver
		addConstraint: (position x cnEqual: incomingPosition x + (anEndState incoming shape width / 2) strength: ClStrength strong);
		addConstraint: (position y cnGEQ: incomingPosition y + self rowSize strength: ClStrength strong).

]

{ #category : #visiting }
CDStateObjectVisitor >> visitStartState: aStartState [ 
	| startPosition nextPosition |
	startPosition := self positionAt: aStartState.
	nextPosition := self positionAt: aStartState outgoing.
	self solver
		addConstraint: (startPosition x cnEqual: nextPosition x strength: ClStrength required);
		addConstraint: (nextPosition y  cnGEQ: startPosition y + self rowSize strength: ClStrength required).
	edges add: (aStartState -> (aStartState outgoing)).

	^ self visit: aStartState outgoing
]

{ #category : #visiting }
CDStateObjectVisitor >> visitState: aState [ 
	| position incomingPosition |
	position := self positionAt: aState.
	incomingPosition := self positionAt: aState incoming.
	solver 
		"addConstraint: (position x cnEqual: incomingPosition x strength: ClStrength strong);"
		addConstraint: (position y cnGEQ: incomingPosition y + self rowSize strength: ClStrength medium).
		
	aState outgoing ifNotNil: [ 
		edges add: (aState -> (aState outgoing)).
		self visit: aState outgoing ]
]