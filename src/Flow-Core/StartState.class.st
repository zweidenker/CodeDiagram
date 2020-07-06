Class {
	#name : #StartState,
	#superclass : #StateObject,
	#instVars : [
		'outgoing'
	],
	#category : #'Flow-Core'
}

{ #category : #visiting }
StartState >> acceptStateVisitor: aStateObjectVisitor [ 
	^ aStateObjectVisitor visitStartState: self
]

{ #category : #accessing }
StartState >> outgoing [
	^ outgoing
]

{ #category : #accessing }
StartState >> outgoing: anObject [
	anObject incoming: self.
	outgoing := anObject
]

{ #category : #'as yet unclassified' }
StartState >> shape [
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
				color: Color lightGreen. 
		labelShape
			"RSLabel new 
				text: label;
				fontSize: 8" }
	
]
