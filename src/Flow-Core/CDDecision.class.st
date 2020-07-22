Class {
	#name : #CDDecision,
	#superclass : #CDStateObject,
	#instVars : [
		'incoming',
		'yes',
		'no'
	],
	#category : #'Flow-Core'
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
CDDecision >> incoming [
	^ incoming
]

{ #category : #accessing }
CDDecision >> incoming: anObject [
	incoming ifNil: [
		incoming := anObject.  
		(anObject respondsTo: #outgoing:) ifTrue: [ 
			anObject outgoing: self ].
		 ]
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
CDDecision >> resolve: flowName in: aCollection builder: aBuilder [ 
	yes := aBuilder resolve: flowName yes: (aCollection first: 2).
	yes incoming: self.
	no := aBuilder resolve: flowName no: (aCollection last: 2).
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
				size: self shapeSize; 
				border: self border;
				color: Color lightRed. 
			labelShape
			"RSLabel new 
				text: label;
				fontSize: 8" }
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
