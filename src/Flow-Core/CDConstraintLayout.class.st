Class {
	#name : #CDConstraintLayout,
	#superclass : #RSLayout,
	#instVars : [
		'edges',
		'positions'
	],
	#category : #'Flow-Core'
}

{ #category : #hook }
CDConstraintLayout >> doExecute: elements [ 
	| position |
	elements do: [ :element |
		element @ RSDraggable.
		position := positions at: element model.
		translator translateTopLeftOf: element to: (position x value @ position y value) ]

]

{ #category : #accessing }
CDConstraintLayout >> edges: aCollection [ 
	edges := aCollection
]

{ #category : #accessing }
CDConstraintLayout >> positions: aCollection [ 
	positions := aCollection 
]
