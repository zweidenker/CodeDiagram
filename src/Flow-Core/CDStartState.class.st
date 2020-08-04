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
	^ RSEllipse new 
		model: self;
		size: 50;
		color: Color green;
		yourself
	
]
