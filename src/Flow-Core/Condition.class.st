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
