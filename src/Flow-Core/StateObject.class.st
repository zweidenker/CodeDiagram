Class {
	#name : #StateObject,
	#superclass : #Object,
	#instVars : [
		'label',
		'outgoing'
	],
	#category : #'Flow-Core'
}

{ #category : #'instance creation' }
StateObject class >> labelled: aString [ 
	^ self new 
		label: aString
]

{ #category : #'instance creation' }
StateObject class >> withName: aString [
	^ self allSubclasses 
		detect: [ :each | each stateObjectName = aString ]
		ifNone: [  nil ]
]

{ #category : #accessing }
StateObject >> basicSize [ 
	^ 150
]

{ #category : #'public - shape' }
StateObject >> border [
	^ RSBorder new 
		width: 5; 
		color: Color darkGray
]

{ #category : #accessing }
StateObject >> fontSize [
	^ 15
]

{ #category : #accessing }
StateObject >> label [
	^ label
]

{ #category : #accessing }
StateObject >> label: anObject [
	label := anObject
]

{ #category : #printing }
StateObject >> printOn: aStream [
	aStream << self class name << ' - ' << label asString
]

{ #category : #'as yet unclassified' }
StateObject >> resolve: flowName in: aCollection builder: aBuilder [ 
	outgoing := aBuilder resolve: flowName outgoing: aCollection.
	outgoing incoming: self.
]

{ #category : #accessing }
StateObject >> shapeSize [
	^ self basicSize 
]
