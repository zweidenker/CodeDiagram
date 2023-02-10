Class {
	#name : #CDFork,
	#superclass : #CDSplittingBlock,
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
