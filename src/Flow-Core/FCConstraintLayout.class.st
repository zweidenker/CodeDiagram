Class {
	#name : #FCConstraintLayout,
	#superclass : #RSLayout,
	#instVars : [
		'edges',
		'positions'
	],
	#category : #'Flow-Core'
}

{ #category : #hook }
FCConstraintLayout >> doExecute: elements [ 
	| position |
	elements do: [ :element |
		element @ RSDraggable.
		position := positions at: element model.
		translator translateTopLeftOf: element to: (position x value @ position y value) ]

]

{ #category : #accessing }
FCConstraintLayout >> edges: aCollection [ 
	edges := aCollection
]

{ #category : #accessing }
FCConstraintLayout >> positions: aCollection [ 
	positions := aCollection 
]
