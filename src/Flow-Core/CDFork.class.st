Class {
	#name : #CDFork,
	#superclass : #CDBlockObject,
	#instVars : [
		'branches'
	],
	#category : #'Flow-Core'
}

{ #category : #'as yet unclassified' }
CDFork class >> stateObjectName [
	^ #transitionFork
]

{ #category : #visiting }
CDFork >> acceptStateVisitor: aStateObjectVisitor [ 
	^ aStateObjectVisitor visitFork: self
]

{ #category : #accessing }
CDFork >> branches [ 

	^ branches ifNil: [ branches := OrderedCollection new ]
]

{ #category : #accessing }
CDFork >> branches: aCollectionOfBranches [

	branches := aCollectionOfBranches
]

{ #category : #visiting }
CDFork >> resolveOutgoing: aCollection at: index builder: aBuilder [
	| outgoings branch |
	outgoings := aCollection copy.
	[ outgoings isEmpty ]
		whileFalse: [ 
			branch := (aBuilder resolveOutgoing: (outgoings first: 2) at: index).
			self branches
				add: branch.
			outgoings := outgoings allButFirst: 2.
			branch incoming: self. ].
]

{ #category : #'as yet unclassified' }
CDFork >> shape [
| shapeBuilder labelShape |
	shapeBuilder := RSMultilineLabelBuilder new.
	shapeBuilder labelShape
		fontSize: self fontSize.
	labelShape := (shapeBuilder shapeFor: label).

	^ RSComposite new 
		model: self;
		shapes: {
			RSShapeFactory rectangle
				extent: (Point x: labelShape width + 20 y: 150);
				border: self border;
				color: #lightYellow. 
		labelShape}
]
