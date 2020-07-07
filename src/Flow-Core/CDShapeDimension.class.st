Class {
	#name : #CDShapeDimension,
	#superclass : #Object,
	#instVars : [
		'label',
		'position',
		'width',
		'height'
	],
	#category : #'Flow-Core'
}

{ #category : #'instance creation' }
CDShapeDimension class >> labelled: aString [
	^ self new 
		setLabel: aString
]

{ #category : #accessing }
CDShapeDimension >> height [
	^ height
]

{ #category : #initialization }
CDShapeDimension >> initializeVariables [
	position := (ClVariable newWith: 0 name: label, ':X')
				@ (ClVariable newWith: 0 name: label, ':Y').
	width := (ClVariable newWith: 0 name: label, ':Width').
	height := (ClVariable newWith: 0 name: label, ':Height')
]

{ #category : #accessing }
CDShapeDimension >> label [
	^ label
]

{ #category : #accessing }
CDShapeDimension >> position [
	^ position 
]

{ #category : #initialization }
CDShapeDimension >> setLabel: aString [
	label ifNotNil: [ Error signal: 'can only be set once' ].
	label := aString.
	self initializeVariables
	
]

{ #category : #accessing }
CDShapeDimension >> width [
	^ width
]

{ #category : #accessing }
CDShapeDimension >> x [
	^ position x
]

{ #category : #accessing }
CDShapeDimension >> y [
	^ position y
]
