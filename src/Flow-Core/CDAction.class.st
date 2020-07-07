Class {
	#name : #CDAction,
	#superclass : #CDStateObject,
	#instVars : [
		'incoming'
	],
	#category : #'Flow-Core'
}

{ #category : #'as yet unclassified' }
CDAction class >> stateObjectName [
	^ #action
]

{ #category : #visiting }
CDAction >> acceptStateVisitor: aStateObjectVisitor [ 
	^ aStateObjectVisitor visitAction: self
]

{ #category : #accessing }
CDAction >> incoming [
	^ incoming
]

{ #category : #accessing }
CDAction >> incoming: anObject [
	incoming ifNil: [
		incoming := anObject.  
		(anObject respondsTo: #outgoing:) ifTrue: [ 
			anObject outgoing: self ].
		 ]
]

{ #category : #accessing }
CDAction >> outgoing [
	^ outgoing
]

{ #category : #accessing }
CDAction >> outgoing: anObject [
	outgoing := anObject
]

{ #category : #'as yet unclassified' }
CDAction >> shape [
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
