Class {
	#name : #CDConstraintLayout,
	#superclass : #RSLayout,
	#instVars : [
		'edges',
		'solver',
		'dimensions'
	],
	#category : #'Flow-Core'
}

{ #category : #accessing }
CDConstraintLayout >> dimensions: aDictionary [ 
	dimensions := aDictionary 
]

{ #category : #hook }
CDConstraintLayout >> doExecute: elements [ 
	| position dimension |
	elements do: [ :element |
		dimension := dimensions at: element model.
		solver addEditVar: dimension width strength: ClStrength strong.
		solver addEditVar: dimension height strength: ClStrength strong.
 	].
	
	solver beginEdit.
	
	elements do: [ :element |
		dimension := dimensions at: element model.
		solver suggestValue: dimension width newValue: element encompassingRectangle width.
		solver suggestValue: dimension height newValue: element encompassingRectangle height ].
	
	solver resolve.
	
	solver endEdit.
	elements do: [ :element |
		element @ RSDraggable.
		position := (dimensions at: element model) position.
		Transcript show: 'draw ', element model label,' on ', position x value asString , '@', position y value asString; cr.
		translator translateTopLeftOf: element to: (position x value @ position y value) ]

]

{ #category : #accessing }
CDConstraintLayout >> edges: aCollection [ 
	edges := aCollection
]

{ #category : #accessing }
CDConstraintLayout >> solver: aClSimplexSolver [ 
	solver := aClSimplexSolver 
]
