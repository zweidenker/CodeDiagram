Class {
	#name : #CDCondition,
	#superclass : #CDStateObject,
	#instVars : [
		'incoming',
		'yes',
		'no'
	],
	#category : #'Flow-Core'
}

{ #category : #'as yet unclassified' }
CDCondition class >> stateObjectName [
	^ #condition
]

{ #category : #visiting }
CDCondition >> acceptStateVisitor: aStateObjectVisitor [ 
	^ aStateObjectVisitor visitCondition: self
]

{ #category : #accessing }
CDCondition >> incoming [
	^ incoming
]

{ #category : #accessing }
CDCondition >> incoming: anObject [
	incoming ifNil: [
		incoming := anObject.  
		(anObject respondsTo: #outgoing:) ifTrue: [ 
			anObject outgoing: self ].
		 ]
]

{ #category : #accessing }
CDCondition >> no [
	^ no
]

{ #category : #accessing }
CDCondition >> no: anObject [
	anObject incoming: self.
	no := anObject
]

{ #category : #'as yet unclassified' }
CDCondition >> resolve: flowName in: aCollection builder: aBuilder [ 
	yes := aBuilder resolve: flowName yes: (aCollection first: 2).
	yes incoming: self.
	no := aBuilder resolve: flowName no: (aCollection last: 2).
	no incoming: self
]

{ #category : #accessing }
CDCondition >> shape [
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
CDCondition >> yes [
	^ yes
]

{ #category : #accessing }
CDCondition >> yes: anObject [
	anObject incoming: self.
	yes := anObject
]
