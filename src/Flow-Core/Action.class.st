Class {
	#name : #Action,
	#superclass : #StateObject,
	#instVars : [
		'incoming',
		'outgoing'
	],
	#category : #'Flow-Core'
}

{ #category : #visiting }
Action >> acceptStateVisitor: aStateObjectVisitor [ 
	^ aStateObjectVisitor visitAction: self
]

{ #category : #accessing }
Action >> incoming [
	^ incoming
]

{ #category : #accessing }
Action >> incoming: anObject [
	incoming ifNil: [
		incoming := anObject.  
		(anObject respondsTo: #outgoing:) ifTrue: [ 
			anObject outgoing: self ].
		 ]
]

{ #category : #accessing }
Action >> outgoing [
	^ outgoing
]

{ #category : #accessing }
Action >> outgoing: anObject [
	outgoing := anObject
]

{ #category : #'as yet unclassified' }
Action >> shape [
	| shapeBuilder labelShape |
	shapeBuilder := RSMultilineLabelBuilder new.
	shapeBuilder labelShape
		fontSize: self fontSize.
	labelShape := (shapeBuilder shapeFor: label).

	^ RSComposite new 
		model: self;
		shapes: {
			RSShapeFactory box
				size: self shapeSize; 
				cornerRadius: (self shapeSize / 10);
				border: self border;
				color: Color lightYellow. 
		labelShape
			"RSLabel new 
				text: label;
				fontSize: 11" }
]
