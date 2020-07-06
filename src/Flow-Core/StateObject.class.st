Class {
	#name : #StateObject,
	#superclass : #Object,
	#instVars : [
		'label',
		'one'
	],
	#category : #'Flow-Core'
}

{ #category : #'instance creation' }
StateObject class >> labelled: aString [ 
	^ self new 
		label: aString
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

{ #category : #accessing }
StateObject >> shapeSize [
	^ self basicSize 
]
