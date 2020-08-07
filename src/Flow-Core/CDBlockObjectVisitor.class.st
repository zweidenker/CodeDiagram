Class {
	#name : #CDBlockObjectVisitor,
	#superclass : #Object,
	#instVars : [
		'solver',
		'seen',
		'edges',
		'dimensions'
	],
	#category : #'Flow-Core'
}

{ #category : #accessing }
CDBlockObjectVisitor >> dimensionAt: aState [ 
	aState ifNil: [ Error signal: 'nil does not work' ].
	^ self dimensions 
		at: aState
		ifAbsentPut: [ 
			CDShapeDimension labelled: aState label ]
]

{ #category : #accessing }
CDBlockObjectVisitor >> dimensions [ 
	^ dimensions 
]

{ #category : #accessing }
CDBlockObjectVisitor >> edges [
	^ edges
]

{ #category : #visiting }
CDBlockObjectVisitor >> horizontalGap [
	^ self shapeSize * 2
]

{ #category : #initialization }
CDBlockObjectVisitor >> initialize [ 	
	super initialize.
	dimensions := Dictionary new.
	solver := ClSimplexSolver new.
	seen := OrderedDictionary new.
	edges := OrderedCollection new
]

{ #category : #visiting }
CDBlockObjectVisitor >> layout: aState [ 
	self visit: aState
]

{ #category : #accessing }
CDBlockObjectVisitor >> objects [
	^ dimensions keys
]

{ #category : #visiting }
CDBlockObjectVisitor >> position: next centerOf: prev strength: aNumber [
	solver 
		addConstraint: (prev x cnEqual: next x strength: aNumber).
]

{ #category : #visiting }
CDBlockObjectVisitor >> position: next leftOf: prev strength: aNumber [
"	solver 
		addConstraint: (prev x cnGEQ: next x + next width + self horizontalGap strength: aNumber)"
	self position: prev rightOf: next strength: aNumber 
]

{ #category : #visiting }
CDBlockObjectVisitor >> position: next middleOf: prev strength: aNumber [
	solver 
		addConstraint: (prev y cnEqual: next y strength: aNumber).
]

{ #category : #visiting }
CDBlockObjectVisitor >> position: next rightOf: prev strength: aNumber [
	solver 
		addConstraint: (next x cnGEQ: prev x + self horizontalGap strength: aNumber)
]

{ #category : #visiting }
CDBlockObjectVisitor >> position: next under: prev strength: aNumber [
	solver 
		addConstraint: (next y cnGEQ: prev y + "prev height + "self verticalGap strength: aNumber)
]

{ #category : #accessing }
CDBlockObjectVisitor >> shapeSize [
	^ 150
]

{ #category : #accessing }
CDBlockObjectVisitor >> solver [
	^ solver
]

{ #category : #visiting }
CDBlockObjectVisitor >> verticalGap [
	^ self shapeSize * 1.5
]

{ #category : #visiting }
CDBlockObjectVisitor >> visit: aState [ 
	^ seen 
		at: aState
		ifAbsent: [ 
			seen at: aState put: Object new.
			aState acceptStateVisitor: self ]
]

{ #category : #visiting }
CDBlockObjectVisitor >> visitAction: anAction [ 
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
CDBlockObjectVisitor >> visitDecision: aDecision [ 

	self visitSplittingBlock: aDecision
]

{ #category : #visiting }
CDBlockObjectVisitor >> visitEnd: anEndState [ 
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
CDBlockObjectVisitor >> visitFork: aFork [ 

	self visitSplittingBlock: aFork
]

{ #category : #visiting }
CDBlockObjectVisitor >> visitSplittingBlock: aSplittingBlock [ 
	| condition firstBranch secondBranch previous |
	condition := self dimensionAt: aSplittingBlock.
	firstBranch := self dimensionAt: aSplittingBlock firstBranch.
	secondBranch := self dimensionAt: aSplittingBlock secondBranch.
	previous := self dimensionAt: aSplittingBlock incoming. 
	self 
		position: firstBranch rightOf: condition strength: ClStrength strong;
		position: firstBranch middleOf: condition strength: ClStrength strong; 
		position: secondBranch under: condition strength: ClStrength strong;
		position: secondBranch centerOf: condition strength: ClStrength strong;
		position: condition under: previous strength: ClStrength strong. 

	edges add: (aSplittingBlock -> (aSplittingBlock firstBranch)).
	edges add: (aSplittingBlock -> (aSplittingBlock secondBranch)).

	self visit: aSplittingBlock firstBranch.
	self visit: aSplittingBlock secondBranch.
]

{ #category : #visiting }
CDBlockObjectVisitor >> visitStartState: aStartState [ 
	| start next |
	start := self dimensionAt: aStartState.
	next := self dimensionAt: aStartState outgoing.
	self 
		position: next centerOf: start strength: ClStrength required.
	edges add: (aStartState -> (aStartState outgoing)).

	^ self visit: aStartState outgoing
]

{ #category : #visiting }
CDBlockObjectVisitor >> visitState: aState [ 
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
