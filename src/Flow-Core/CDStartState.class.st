Class {
	#name : #CDStartState,
	#superclass : #CDBlockObject,
	#category : #'Flow-Core'
}

{ #category : #'as yet unclassified' }
CDStartState class >> stateObjectName [
	^ #start
]

{ #category : #visiting }
CDStartState >> acceptStateVisitor: aStateObjectVisitor [ 
	^ aStateObjectVisitor visitStartState: self
]

{ #category : #accessing }
CDStartState >> outgoing: anObject [
	anObject incoming: self.
	outgoing := anObject
]

{ #category : #'as yet unclassified' }
CDStartState >> resolve: aClass [ 
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
CDStartState >> shape [
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
				color: Color green. 
		labelShape }
	
]
