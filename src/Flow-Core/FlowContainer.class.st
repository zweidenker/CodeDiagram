Class {
	#name : #FlowContainer,
	#superclass : #Object,
	#instVars : [
		'start'
	],
	#category : #'Flow-Core'
}

{ #category : #'as yet unclassified' }
FlowContainer >> drawCanvas [

	| visitor canvas eb |
	visitor := StateObjectVisitor new.
	visitor layout: start.
	visitor.

	canvas := RSCanvas new.

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

{ #category : #accessing }
FlowContainer >> script [ 

	| employeeNumber userExists selectProducts inDB enterPersonal createdReg pendingReg userSetUp created |
	start := StartState labelled: 'User clicks registration'.
	employeeNumber := Action labelled: 'Enters employee number'.
	start outgoing: employeeNumber.
	userExists := Action labelled: 'User exists error'.
	selectProducts := Action labelled: 'Select products'.
	inDB := (Condition labelled: 'user in DB?')
		yes: userExists;
		no: selectProducts.
	inDB incoming: employeeNumber.
	enterPersonal := Action labelled: 'Enters person details'.
	enterPersonal incoming: selectProducts.
	selectProducts outgoing: enterPersonal.
	createdReg := Action labelled: 'Create Registration'.
	pendingReg := Action labelled: 'Registration pending'.
	userSetUp := (Condition labelled: 'User already set up?')
		yes: pendingReg;
		no: createdReg.

	created := State labelled: 'Created'.

	^ FlowContainer new
		start: start;
		drawCanvas
]

{ #category : #accessing }
FlowContainer >> start: anObject [
	start := anObject
]
