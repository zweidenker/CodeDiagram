Class {
	#name : #CDStateObject,
	#superclass : #Object,
	#instVars : [
		'label',
		'outgoing'
	],
	#category : #'Flow-Core'
}

{ #category : #'instance creation' }
CDStateObject class >> labelled: aString [ 
	^ self new 
		label: aString
]

{ #category : #'instance creation' }
CDStateObject class >> withName: aString [
	^ self allSubclasses 
		detect: [ :each | each stateObjectName = aString ]
		ifNone: [  nil ]
]

{ #category : #accessing }
CDStateObject >> basicSize [ 
	^ 150
]

{ #category : #'public - shape' }
CDStateObject >> border [
	^ RSBorder new 
		width: 5; 
		color: Color darkGray
]

{ #category : #accessing }
CDStateObject >> fontSize [
	^ 15
]

{ #category : #accessing }
CDStateObject >> label [
	^ label
]

{ #category : #accessing }
CDStateObject >> label: anObject [
	label := anObject
]

{ #category : #printing }
CDStateObject >> printOn: aStream [
	aStream << self class name << ' - ' << label asString
]

{ #category : #'as yet unclassified' }
CDStateObject >> resolve: flowName in: aCollection builder: aBuilder [ 
	outgoing := aBuilder resolve: flowName outgoing: aCollection.
	outgoing incoming: self.
]

{ #category : #accessing }
CDStateObject >> shapeSize [
	^ self basicSize 
]
