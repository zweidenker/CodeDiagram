Class {
	#name : #CDEndState,
	#superclass : #CDFlowEntity,
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
CDEndState >> resolve: aString  builder: aFCCodeModelBuilder [ 
	
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
