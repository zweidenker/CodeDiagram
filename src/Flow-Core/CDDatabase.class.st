Class {
	#name : #CDDatabase,
	#superclass : #CDBlockObject,
	#category : #'Flow-Core'
}

{ #category : #'as yet unclassified' }
CDDatabase class >> stateObjectName [
	^ #database
]

{ #category : #visiting }
CDDatabase >> acceptStateVisitor: aStateObjectVisitor [ 
	^ aStateObjectVisitor visitAction: self
]

{ #category : #'as yet unclassified' }
CDDatabase >> shape [
	| shapeBuilder labelShape |
	shapeBuilder := RSMultilineLabelBuilder new.
	shapeBuilder labelShape
		fontSize: self fontSize.
	labelShape := (shapeBuilder shapeFor: label).

	^ RSComposite new 
		model: self;
		shapes: {
			RSShapeFactory ellipse
				size: labelShape width + 20; 
				border: self border;
				color: self color. 
		labelShape }
]
