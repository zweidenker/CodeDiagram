Class {
	#name : #CDTerminal,
	#superclass : #CDBlockObject,
	#category : #'Flow-Core'
}

{ #category : #'as yet unclassified' }
CDTerminal class >> stateObjectName [
	^ #terminal
]

{ #category : #visiting }
CDTerminal >> acceptStateVisitor: aStateObjectVisitor [ 
	^ aStateObjectVisitor visitState: self
]

{ #category : #'as yet unclassified' }
CDTerminal >> resolve: aString in: aClass builder: aFCCodeModelBuilder [ 
]

{ #category : #'as yet unclassified' }
CDTerminal >> shape [
	| shapeBuilder labelShape |
	shapeBuilder := RSMultilineLabelBuilder new.
	shapeBuilder labelShape
		fontSize: self fontSize.
	labelShape := (shapeBuilder shapeFor: label).

	^ RSComposite new 
		model: self;
		shapes: {
			RSShapeFactory box 
				cornerRadius: (self shapeSize / 10);
				border: self border;
				color: self color;
				extent: (Point x: labelShape width + 20 y: 150).
		labelShape }
]
