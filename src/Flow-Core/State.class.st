Class {
	#name : #State,
	#superclass : #StateObject,
	#instVars : [
		'incoming',
		'outgoing'
	],
	#category : #'Flow-Core'
}

{ #category : #visiting }
State >> acceptStateVisitor: aStateObjectVisitor [ 
	^ aStateObjectVisitor visitState: self
]

{ #category : #accessing }
State >> incoming [
	^ incoming
]

{ #category : #accessing }
State >> incoming: anObject [
	incoming ifNil: [
		incoming := anObject.  
		(anObject respondsTo: #outgoing:) ifTrue: [ 
			anObject outgoing: self ].
		 ]
]

{ #category : #accessing }
State >> outgoing [
	^ outgoing
]

{ #category : #accessing }
State >> outgoing: anObject [
	outgoing := anObject
]

{ #category : #'as yet unclassified' }
State >> shape [
	| shapeBuilder labelShape |
	shapeBuilder := RSMultilineLabelBuilder new.
	shapeBuilder labelShape
		fontSize: self fontSize;
		bold.
	labelShape := (shapeBuilder shapeFor: label).

	^ RSComposite new 
		model: self;
		shapes: {
			RSShapeFactory box
				size: self shapeSize; 
				cornerRadius: (self shapeSize / 10);
				border: self border;
				color: Color lightBlue. 
		labelShape
			"RSLabel new 
				text: label;
				fontSize: 8" }
]
