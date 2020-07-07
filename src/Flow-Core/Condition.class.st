Class {
	#name : #Condition,
	#superclass : #StateObject,
	#instVars : [
		'incoming',
		'yes',
		'no'
	],
	#category : #'Flow-Core'
}

{ #category : #'as yet unclassified' }
Condition class >> stateObjectName [
	^ #condition
]

{ #category : #visiting }
Condition >> acceptStateVisitor: aStateObjectVisitor [ 
	^ aStateObjectVisitor visitCondition: self
]

{ #category : #accessing }
Condition >> incoming [
	^ incoming
]

{ #category : #accessing }
Condition >> incoming: anObject [
	incoming ifNil: [
		incoming := anObject.  
		(anObject respondsTo: #outgoing:) ifTrue: [ 
			anObject outgoing: self ].
		 ]
]

{ #category : #accessing }
Condition >> no [
	^ no
]

{ #category : #accessing }
Condition >> no: anObject [
	anObject incoming: self.
	no := anObject
]

{ #category : #'as yet unclassified' }
Condition >> resolve: flowName in: aCollection builder: aBuilder [ 
	yes := aBuilder resolve: flowName yes: (aCollection first: 2).
	yes incoming: self.
	no := aBuilder resolve: flowName no: (aCollection last: 2).
	no incoming: self
]

{ #category : #accessing }
Condition >> shape [
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
Condition >> yes [
	^ yes
]

{ #category : #accessing }
Condition >> yes: anObject [
	anObject incoming: self.
	yes := anObject
]
