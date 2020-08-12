Class {
	#name : #CDAutoLayoutVisitor,
	#superclass : #CDFlowVisitor,
	#instVars : [
		'solver',
		'edges',
		'dimensions'
	],
	#category : #'Flow-Roassal'
}

{ #category : #accessing }
CDAutoLayoutVisitor >> dimensionAt: aState [ 
	aState ifNil: [ Error signal: 'nil does not work' ].
	^ self dimensions 
		at: aState
		ifAbsentPut: [ 
			CDShapeDimension labelled: aState label ]
]

{ #category : #accessing }
CDAutoLayoutVisitor >> dimensions [ 
	^ dimensions 
]

{ #category : #accessing }
CDAutoLayoutVisitor >> edges [
	^ edges
]

{ #category : #visiting }
CDAutoLayoutVisitor >> horizontalGap [
	^ self shapeSize * 2
]

{ #category : #initialization }
CDAutoLayoutVisitor >> initialize [ 	
	super initialize.
	dimensions := Dictionary new.
	solver := ClSimplexSolver new.
	edges := OrderedCollection new
]

{ #category : #visiting }
CDAutoLayoutVisitor >> layout: aState [ 
	self visit: aState
]

{ #category : #accessing }
CDAutoLayoutVisitor >> objects [
	^ dimensions keys
]

{ #category : #visiting }
CDAutoLayoutVisitor >> position: next centerOf: prev strength: aNumber [
	solver 
		addConstraint: (prev x cnEqual: next x strength: aNumber).
]

{ #category : #visiting }
CDAutoLayoutVisitor >> position: next leftOf: prev strength: aNumber [
"	solver 
		addConstraint: (prev x cnGEQ: next x + next width + self horizontalGap strength: aNumber)"
	self position: prev rightOf: next strength: aNumber 
]

{ #category : #visiting }
CDAutoLayoutVisitor >> position: next middleOf: prev strength: aNumber [
	solver 
		addConstraint: (prev y cnEqual: next y strength: aNumber).
]

{ #category : #visiting }
CDAutoLayoutVisitor >> position: next rightOf: prev strength: aNumber [
	solver 
		addConstraint: (next x cnGEQ: prev x + self horizontalGap strength: aNumber)
]

{ #category : #visiting }
CDAutoLayoutVisitor >> position: next under: prev strength: aNumber [
	solver 
		addConstraint: (next y cnGEQ: prev y + "prev height + "self verticalGap strength: aNumber)
]

{ #category : #accessing }
CDAutoLayoutVisitor >> shapeSize [
	^ 150
]

{ #category : #accessing }
CDAutoLayoutVisitor >> solver [
	^ solver
]

{ #category : #visiting }
CDAutoLayoutVisitor >> verticalGap [
	^ self shapeSize * 1.5
]

{ #category : #visiting }
CDAutoLayoutVisitor >> visitAction: anAction [ 
	| action previous outgoingPosition |
	action := self dimensionAt: anAction.
	previous := self dimensionAt: anAction incoming.

	"self position: action rightOf: previous strength: ClStrength medium."
	self position: action middleOf: previous strength: ClStrength medium.
	"self position: action under: previous strength: ClStrength weak."
	"solver 
		addConstraint: (state x cnGEQ: prevState x + self horizontalGap strength: ClStrength medium);
		addConstraint: (state y cnGEQ: prevState y strength: ClStrength medium)."
	anAction outgoing ifNotNil: [ 
		edges add: (anAction -> (anAction outgoing)). 
		outgoingPosition := self dimensionAt: anAction outgoing.
		self position: outgoingPosition rightOf: action strength: ClStrength weak.
		self visit: anAction outgoing ]
]

{ #category : #visiting }
CDAutoLayoutVisitor >> visitCondition: aCondition [ 
	| condition yes no previous |
	condition := self dimensionAt: aCondition.
	yes := self dimensionAt: aCondition yes.
	no := self dimensionAt: aCondition no.
	previous := self dimensionAt: aCondition incoming. 
	self 
		position: yes rightOf: condition strength: ClStrength strong;
		position: yes middleOf: condition strength: ClStrength strong; 
		position: no under: condition strength: ClStrength strong;
		position: no centerOf: condition strength: ClStrength strong;
		position: condition under: previous strength: ClStrength strong. 

	edges add: (aCondition -> (aCondition yes)).
	edges add: (aCondition -> (aCondition no)).

	self visit: aCondition yes.
	self visit: aCondition no.
]

{ #category : #visiting }
CDAutoLayoutVisitor >> visitEnd: anEndState [ 
	| end previous |
	end := self dimensionAt: anEndState.
	previous := self dimensionAt: anEndState incoming.
	self 
		position: end under: previous strength: ClStrength strong;
		position: end centerOf: previous strength:  ClStrength required.
	"self solver
		addConstraint: (position x cnEqual: incomingPosition x + (anEndState incoming shape width / 2) strength: ClStrength strong);
		addConstraint: (position y cnGEQ: incomingPosition y + self verticalGap strength: ClStrength strong).
"
]

{ #category : #visiting }
CDAutoLayoutVisitor >> visitStartState: aStartState [ 
	| start next |
	start := self dimensionAt: aStartState.
	next := self dimensionAt: aStartState outgoing.
	self 
		position: next centerOf: start strength: ClStrength required.
	edges add: (aStartState -> (aStartState outgoing)).

	^ self visit: aStartState outgoing
]

{ #category : #visiting }
CDAutoLayoutVisitor >> visitState: aState [ 
	| state previous next |
	state := self dimensionAt: aState.
	previous := self dimensionAt: aState incoming.

	self position: state under: previous strength: ClStrength medium. 
		
	aState outgoing ifNotNil: [ 
		edges add: (aState -> (aState outgoing)).
		next := self dimensionAt: aState outgoing.
		"self position: next under: state strength: ClStrength medium."
		self visit: aState outgoing ]
]
