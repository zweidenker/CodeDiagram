Class {
	#name : #CDPragmaNotFound,
	#superclass : #Error,
	#category : #'Flow-Core-Exceptions'
}

{ #category : #accessing }
CDPragmaNotFound >> messageText [
	^ 'Missing or incorrect pragma in outgoing block'
]
