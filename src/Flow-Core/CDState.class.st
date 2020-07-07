Class {
	#name : #CDState,
	#superclass : #CDStateObject,
	#instVars : [
		'incoming'
	],
	#category : #'Flow-Core'
}

{ #category : #'as yet unclassified' }
CDState class >> stateObjectName [
	^ #state
]

{ #category : #visiting }
CDState >> acceptStateVisitor: aStateObjectVisitor [ 
	^ aStateObjectVisitor visitState: self
]

{ #category : #accessing }
CDState >> incoming [
	^ incoming
]

{ #category : #accessing }
CDState >> incoming: anObject [
	incoming ifNil: [
		incoming := anObject.  
		(anObject respondsTo: #outgoing:) ifTrue: [ 
			anObject outgoing: self ].
		 ]
]

{ #category : #accessing }
CDState >> outgoing [
	^ outgoing
]

{ #category : #accessing }
CDState >> outgoing: anObject [
	outgoing := anObject
]

{ #category : #'as yet unclassified' }
CDState >> resolve: aString outgoing: aCollection in: aBuilder [ 
	outgoing := aBuilder resolve: aString outgoing: aCollection.
	outgoing incoming: self.
]

{ #category : #'as yet unclassified' }
CDState >> shape [
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
