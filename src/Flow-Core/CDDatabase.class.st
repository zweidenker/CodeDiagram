Class {
	#name : #CDDatabase,
	#superclass : #CDStateObject,
	#instVars : [
		'incoming'
	],
	#category : #'Flow-Core'
}

{ #category : #'as yet unclassified' }
CDDatabase class >> stateObjectName [
	^ #database
]

{ #category : #visiting }
CDDatabase >> acceptStateVisitor: aStateObjectVisitor [ 
	^ aStateObjectVisitor visitAction: self
]

{ #category : #accessing }
CDDatabase >> incoming [
	^ incoming
]

{ #category : #accessing }
CDDatabase >> incoming: anObject [
	incoming ifNil: [
		incoming := anObject.  
		(anObject respondsTo: #outgoing:) ifTrue: [ 
			anObject outgoing: self ].
		 ]
]

{ #category : #accessing }
CDDatabase >> outgoing [
	^ outgoing
]

{ #category : #accessing }
CDDatabase >> outgoing: anObject [
	outgoing := anObject
]

{ #category : #'as yet unclassified' }
CDDatabase >> shape [
	| shapeBuilder labelShape |
	shapeBuilder := RSMultilineLabelBuilder new.
	shapeBuilder labelShape
		fontSize: self fontSize.
	labelShape := (shapeBuilder shapeFor: label).

	^ RSComposite new 
		model: self;
		shapes: {
			RSShapeFactory ellipse
				size: self shapeSize; 
				border: self border;
				color: Color lightYellow. 
		labelShape
			"RSLabel new 
				text: label;
				fontSize: 11" }
]
