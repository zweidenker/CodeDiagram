Class {
	#name : #CDTransitionFork,
	#superclass : #CDBlockObject,
	#instVars : [
		'first',
		'second'
	],
	#category : #'Flow-Core'
}

{ #category : #'as yet unclassified' }
CDTransitionFork class >> stateObjectName [
	^ #transitionFork
]

{ #category : #visiting }
CDTransitionFork >> acceptStateVisitor: aStateObjectVisitor [ 
	^ aStateObjectVisitor visitCondition: self
]

{ #category : #accessing }
CDTransitionFork >> first [
	^ first
]

{ #category : #accessing }
CDTransitionFork >> no [
	^ second
]

{ #category : #'as yet unclassified' }
CDTransitionFork >> resolveFrom: aPragma in: aCollection builder: aBuilder [ 
	first := aBuilder resolveFrom: aPragma outgoing: (aCollection first: 2).
	first incoming: self.
	second := aBuilder resolveFrom: aPragma outgoing: (aCollection last: 2).
	second incoming: self
]

{ #category : #accessing }
CDTransitionFork >> second [
	^ second
]

{ #category : #accessing }
CDTransitionFork >> second: anObject [
	anObject incoming: self.
	second := anObject
]

{ #category : #accessing }
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

{ #category : #accessing }
CDTransitionFork >> yes [
	^ first
]
