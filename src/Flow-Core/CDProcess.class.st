Class {
	#name : #CDProcess,
	#superclass : #CDStateObject,
	#instVars : [
		'incoming'
	],
	#category : #'Flow-Core'
}

{ #category : #'as yet unclassified' }
CDProcess class >> stateObjectName [
	^ #process
]

{ #category : #visiting }
CDProcess >> acceptStateVisitor: aStateObjectVisitor [ 
	^ aStateObjectVisitor visitAction: self
]

{ #category : #accessing }
CDProcess >> incoming [
	^ incoming
]

{ #category : #accessing }
CDProcess >> incoming: anObject [
	incoming ifNil: [
		incoming := anObject.  
		(anObject respondsTo: #outgoing:) ifTrue: [ 
			anObject outgoing: self ].
		 ]
]

{ #category : #accessing }
CDProcess >> outgoing [
	^ outgoing
]

{ #category : #accessing }
CDProcess >> outgoing: anObject [
	outgoing := anObject
]

{ #category : #'as yet unclassified' }
CDProcess >> shape [
	| shapeBuilder labelShape |
	shapeBuilder := RSMultilineLabelBuilder new.
	shapeBuilder labelShape
		fontSize: self fontSize.
	labelShape := (shapeBuilder shapeFor: label).

	^ RSComposite new 
		model: self;
		shapes: {
			RSShapeFactory rectangle
				size: self shapeSize; 
				border: self border;
				color: Color lightYellow. 
		labelShape
			"RSLabel new 
				text: label;
				fontSize: 11" }
]
