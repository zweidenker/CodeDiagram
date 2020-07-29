Class {
	#name : #CDProcess,
	#superclass : #CDBlockObject,
	#category : #'Flow-Core'
}

{ #category : #'as yet unclassified' }
CDProcess class >> stateObjectName [
	^ #process
]

{ #category : #visiting }
CDProcess >> acceptStateVisitor: aStateObjectVisitor [ 
	^ aStateObjectVisitor visitAction: self
]

{ #category : #'as yet unclassified' }
CDProcess >> shape [
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
				color: self color. 
		labelShape
			"RSLabel new 
				text: label;
				fontSize: 11" }
]
