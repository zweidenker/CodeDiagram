Class {
	#name : #CDTerminal,
	#superclass : #CDStateObject,
	#instVars : [
		'incoming'
	],
	#category : #'Flow-Core'
}

{ #category : #'as yet unclassified' }
CDTerminal class >> stateObjectName [
	^ #terminal
]

{ #category : #visiting }
CDTerminal >> acceptStateVisitor: aStateObjectVisitor [ 
	^ aStateObjectVisitor visitState: self
]

{ #category : #accessing }
CDTerminal >> incoming [
	^ incoming
]

{ #category : #accessing }
CDTerminal >> incoming: anObject [
	incoming ifNil: [
		incoming := anObject.  
		(anObject respondsTo: #outgoing:) ifTrue: [ 
			anObject outgoing: self ].
		 ]
]

{ #category : #accessing }
CDTerminal >> outgoing [
	^ outgoing
]

{ #category : #accessing }
CDTerminal >> outgoing: anObject [
	outgoing := anObject
]

{ #category : #'as yet unclassified' }
CDTerminal >> resolve: aString outgoing: aCollection in: aBuilder [ 
	outgoing := aBuilder resolve: aString outgoing: aCollection.
	outgoing incoming: self.
]

{ #category : #'as yet unclassified' }
CDTerminal >> shape [
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
