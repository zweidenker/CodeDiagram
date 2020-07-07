Class {
	#name : #FlowDiagram,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #'Flow-Core'
}

{ #category : #accessing }
FlowDiagram class >> startAt: aClass method: aString [
	^ self new
		startAt: aClass method: aString
]

{ #category : #drawing }
FlowDiagram >> drawOn: canvas [

	| visitor  eb |
	visitor := StateObjectVisitor new.
	visitor layout: model.
	visitor.

	visitor objects do: [ :object |
		canvas add: object shape ].

	eb := (RSEdgeBuilder orthoVertical) withBorderAttachPoint.
	eb canvas: canvas.
	eb shapes: canvas nodes.
	eb useAssociations: visitor edges.
	FCConstraintLayout new 
		edges: visitor edges;
		positions: visitor positions;
		solver: visitor solver;
		applyOn: canvas nodes. 
	canvas edges do: [ :each | | c | (each model key isKindOf: Condition) ifTrue: [
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
FlowDiagram >> gtInspectorViewIn: composite [
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
FlowDiagram >> startAt: aClass method: aString [
	model := FCCodeModelBuilder new
		startAt: aClass method: aString asSymbol;
		model
]
