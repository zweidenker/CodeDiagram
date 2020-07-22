Class {
	#name : #CDInputOutput,
	#superclass : #CDStateObject,
	#instVars : [
		'incoming'
	],
	#category : #'Flow-Core'
}

{ #category : #'as yet unclassified' }
CDInputOutput class >> stateObjectName [
	^ #inputoutput
]

{ #category : #visiting }
CDInputOutput >> acceptStateVisitor: aStateObjectVisitor [ 
	^ aStateObjectVisitor visitAction: self
]

{ #category : #accessing }
CDInputOutput >> incoming [
	^ incoming
]

{ #category : #accessing }
CDInputOutput >> incoming: anObject [
	incoming ifNil: [
		incoming := anObject.  
		(anObject respondsTo: #outgoing:) ifTrue: [ 
			anObject outgoing: self ].
		 ]
]

{ #category : #accessing }
CDInputOutput >> outgoing [
	^ outgoing
]

{ #category : #accessing }
CDInputOutput >> outgoing: anObject [
	outgoing := anObject
]

{ #category : #'as yet unclassified' }
CDInputOutput >> shape [
	| shapeBuilder labelShape |
	shapeBuilder := RSMultilineLabelBuilder new.
	shapeBuilder labelShape
		fontSize: self fontSize.
	labelShape := (shapeBuilder shapeFor: label).

	^ RSComposite new 
		model: self;
		shapes: {
			RSShapeFactory rhomboid
				size: self shapeSize;
				border: self border;
				color: Color lightYellow. 
		labelShape
			"RSLabel new 
				text: label;
				fontSize: 11" }
]
