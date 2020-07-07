Class {
	#name : #EndState,
	#superclass : #StateObject,
	#instVars : [
		'incoming'
	],
	#category : #'Flow-Core'
}

{ #category : #'as yet unclassified' }
EndState class >> stateObjectName [
	^ #end
]

{ #category : #visiting }
EndState >> acceptStateVisitor: aStateObjectVisitor [ 
	^ aStateObjectVisitor visitEnd: self
]

{ #category : #accessing }
EndState >> incoming [
	^ incoming
]

{ #category : #accessing }
EndState >> incoming: aState [ 
	incoming := aState
]

{ #category : #'as yet unclassified' }
EndState >> resolve: aString in: aClass builder: aFCCodeModelBuilder [ 
	
]

{ #category : #'as yet unclassified' }
EndState >> shape [
	^ RSEllipse new 
		model: self;
		size: 50;
		color: Color black;
		yourself
]
