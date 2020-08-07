Class {
	#name : #CDEndState,
	#superclass : #CDBlockObject,
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

{ #category : #'as yet unclassified' }
CDEndState >> resolve: flowName in: aCollection at: index builder: aBuilder [ 
	
]

{ #category : #'as yet unclassified' }
CDEndState >> resolveFrom: aString in: aClass builder: aFCCodeModelBuilder [ 
	
]

{ #category : #'as yet unclassified' }
CDEndState >> shape [
	^ RSEllipse new 
		model: self;
		size: 50;
		color: Color black;
		yourself
]
