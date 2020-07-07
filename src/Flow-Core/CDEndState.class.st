Class {
	#name : #CDEndState,
	#superclass : #CDStateObject,
	#instVars : [
		'incoming'
	],
	#category : #'Flow-Core'
}

{ #category : #'as yet unclassified' }
CDEndState class >> stateObjectName [
	^ #end
]

{ #category : #visiting }
CDEndState >> acceptStateVisitor: aStateObjectVisitor [ 
	^ aStateObjectVisitor visitEnd: self
]

{ #category : #accessing }
CDEndState >> incoming [
	^ incoming
]

{ #category : #accessing }
CDEndState >> incoming: aState [ 
	incoming := aState
]

{ #category : #'as yet unclassified' }
CDEndState >> resolve: aString in: aClass builder: aFCCodeModelBuilder [ 
	
]

{ #category : #'as yet unclassified' }
CDEndState >> shape [
	^ RSEllipse new 
		model: self;
		size: 50;
		color: Color black;
		yourself
]
