Class {
	#name : #CDBlockObject,
	#superclass : #Object,
	#instVars : [
		'label',
		'outgoing',
		'incoming',
		'color'
	],
	#category : #'Flow-Core'
}

{ #category : #'instance creation' }
CDBlockObject class >> labelled: aString [ 
	^ self new 
		label: aString
]

{ #category : #'instance creation' }
CDBlockObject class >> withName: aString [
	^ self allSubclasses 
		detect: [ :each | each stateObjectName = aString ]
		ifNone: [  nil ]
]

{ #category : #accessing }
CDBlockObject >> basicSize [ 
	^ 200
]

{ #category : #'public - shape' }
CDBlockObject >> border [
	^ RSBorder new 
		width: 5; 
		color: Color darkGray
]

{ #category : #accessing }
CDBlockObject >> color [
	^ color
]

{ #category : #accessing }
CDBlockObject >> color: anObject [
	color := anObject
]

{ #category : #accessing }
CDBlockObject >> fontSize [
	^ 15
]

{ #category : #accessing }
CDBlockObject >> incoming [
	^ incoming
]

{ #category : #accessing }
CDBlockObject >> incoming: anObject [
	incoming ifNil: [
		incoming := anObject.  
		(anObject respondsTo: #outgoing:) ifTrue: [ 
			anObject outgoing: self ].
		 ]
]

{ #category : #accessing }
CDBlockObject >> label [
	^ label
]

{ #category : #accessing }
CDBlockObject >> label: anObject [
	label := anObject
]

{ #category : #accessing }
CDBlockObject >> outgoing [
	^ outgoing
]

{ #category : #accessing }
CDBlockObject >> outgoing: anObject [
	outgoing := anObject
]

{ #category : #printing }
CDBlockObject >> printOn: aStream [
	aStream << self class name << ' - ' << label asString
]

{ #category : #'as yet unclassified' }
CDBlockObject >> resolve: aCollection builder: aBuilder [ 
	outgoing := aBuilder resolve: aCollection.
	outgoing incoming: self.
]

{ #category : #accessing }
CDBlockObject >> shapeSize [
	^ self basicSize 
]
