Class {
	#name : #CDDecision,
	#superclass : #CDFlowEntity,
	#instVars : [
		'yes',
		'no'
	],
	#category : #'Flow-Core-Model'
}

{ #category : #'as yet unclassified' }
CDDecision class >> stateObjectName [
	^ #decision
]

{ #category : #visiting }
CDDecision >> acceptStateVisitor: aStateObjectVisitor [ 
	^ aStateObjectVisitor visitCondition: self
]

{ #category : #accessing }
CDDecision >> no [
	^ no
]

{ #category : #accessing }
CDDecision >> no: anObject [
	anObject incoming: self.
	no := anObject
]

{ #category : #'as yet unclassified' }
CDDecision >> resolve: aCollection builder: aBuilder [ 
	yes := aBuilder resolve: (aCollection first).
	yes addIncoming: self.
	no := aBuilder resolve: (aCollection second).
	no addIncoming: self
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
	^ yes
]

{ #category : #accessing }
CDDecision >> yes: anObject [
	anObject incoming: self.
	yes := anObject
]
