Class {
	#name : #CDTransitionFork,
	#superclass : #CDBlockObject,
	#instVars : [
		'firstBranch',
		'secondBranch'
	],
	#category : #'Flow-Core'
}

{ #category : #'as yet unclassified' }
CDTransitionFork class >> stateObjectName [
	^ #transitionFork
]

{ #category : #visiting }
CDTransitionFork >> acceptStateVisitor: aStateObjectVisitor [ 
	^ aStateObjectVisitor visitFork: self
]

{ #category : #accessing }
CDTransitionFork >> firstBranch [
	^ firstBranch
]

{ #category : #accessing }
CDTransitionFork >> firstBranch: anObject [
	anObject incoming: self.
	firstBranch := anObject
]

{ #category : #visiting }
CDTransitionFork >> resolveOutgoing: aCollection at: index builder: aBuilder [
	firstBranch := aBuilder resolveOutgoing: (aCollection first: 2) at: index.
	firstBranch incoming: self.
	secondBranch := aBuilder resolveOutgoing:  (aCollection last: 2) at: index.
	secondBranch incoming: self
]

{ #category : #accessing }
CDTransitionFork >> secondBranch [
	^ secondBranch
]

{ #category : #accessing }
CDTransitionFork >> secondBranch: anObject [
	anObject incoming: self.
	secondBranch := anObject
]

{ #category : #'as yet unclassified' }
CDTransitionFork >> shape [
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
