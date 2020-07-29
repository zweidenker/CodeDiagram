Class {
	#name : #CDFlowDiagram,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #'Flow-Core'
}

{ #category : #accessing }
CDFlowDiagram class >> startAt: aClass method: aString [
	^ self new
		startAt: aClass method: aString
]

{ #category : #drawing }
CDFlowDiagram >> drawOn: canvas [

	| visitor  eb |
	visitor := CDBlockObjectVisitor new.
	visitor layout: model.
	visitor.
	visitor objects do: [ :object |
		canvas add: object shape ].

	eb := (RSEdgeBuilder arrowedLine) withBorderAttachPoint; width: 3.
	eb canvas: canvas.
	eb shapes: canvas nodes.
	eb useAssociations: visitor edges.
	CDConstraintLayout new 
		edges: visitor edges;
		solver: visitor solver;
		dimensions: visitor dimensions;
		applyOn: canvas nodes. 
	canvas edges do: [ :each | | c | (each model key isKindOf: CDDecision) ifTrue: [
		c := each model key.
		(c yes = each model value) ifTrue: [ |lbl|
			lbl := RSLabeled new model: 'YES'.
    		lbl location
            outer;
        		center.
    		each addInteraction: lbl].
		(c no = each model value) ifTrue: [ |lbl|
			lbl := RSLabeled new model: 'NO'.
    		lbl location
            left;
        		middle.
    		each addInteraction: lbl]]].
	canvas zoomToFit.
	^ canvas @RSCanvasController
]

{ #category : #visualization }
CDFlowDiagram >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: 0>
	
	composite roassal3
		title: ['Flow'];
		initializeCanvas: [ | canvas |
			canvas := RSCanvas new.
			self drawOn: canvas.
			canvas when: RSExtentChangedEvent do: [ canvas zoomToFit ].
			canvas ]
		
]

{ #category : #accessing }
CDFlowDiagram >> startAt: aClass method: aString [
	model := CDCodeModelBuilder new
		startAt: aClass method: aString asSymbol;
		model
]
