Class {
	#name : #CDInputOutput,
	#superclass : #CDBlockObject,
	#category : #'Flow-Core'
}

{ #category : #'as yet unclassified' }
CDInputOutput class >> stateObjectName [
	^ #inputoutput
]

{ #category : #visiting }
CDInputOutput >> acceptStateVisitor: aStateObjectVisitor [ 
	^ aStateObjectVisitor visitAction: self
]

{ #category : #'as yet unclassified' }
CDInputOutput >> shape [
	| shapeBuilder labelShape |
	shapeBuilder := RSMultilineLabelBuilder new.
	shapeBuilder labelShape
		fontSize: self fontSize.
	labelShape := (shapeBuilder shapeFor: label).

	^ RSComposite new 
		model: self;
		shapes: {
			RSShapeFactory rhomboid
				extent: (Point x: labelShape width + 200 y: 200);
				border: self border;
				color: self color. 
		labelShape }
]
