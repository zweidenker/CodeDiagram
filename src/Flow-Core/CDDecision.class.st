Class {
	#name : #CDDecision,
	#superclass : #CDSplittingBlock,
	#category : #'Flow-Core'
}

{ #category : #'as yet unclassified' }
CDDecision class >> stateObjectName [
	^ #decision
]

{ #category : #visiting }
CDDecision >> acceptStateVisitor: aStateObjectVisitor [ 
	^ aStateObjectVisitor visitDecision: self
]

{ #category : #accessing }
CDDecision >> no [
	^ secondBranch
]

{ #category : #accessing }
CDDecision >> shape [
	| shapeBuilder labelShape |
	shapeBuilder := RSMultilineLabelBuilder new.
	shapeBuilder labelShape
		fontSize: self fontSize;
		italic.
	labelShape := (shapeBuilder shapeFor: label).
	^ RSComposite new 
		model: self;
		shapes: {
			RSShapeFactory diamond
				size: labelShape width + 30; 
				border: self border;
				color: #lightYellow. 
			labelShape }
]

{ #category : #accessing }
CDDecision >> yes [
	^ firstBranch
]
