Class {
	#name : #CDDecision,
	#superclass : #CDBlockObject,
	#instVars : [
		'no',
		'yes'
	],
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
	^ no
]

{ #category : #visiting }
CDDecision >> resolveOutgoing: aCollection at: index builder: aBuilder [
	yes := aBuilder resolveOutgoing: (aCollection first: 2) at: index.
	yes incoming: self.
	no := aBuilder resolveOutgoing:  (aCollection last: 2) at: index.
	no incoming: self
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
