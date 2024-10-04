"
The class for a pawn in my chess game
"
Class {
	#name : 'MyPawn',
	#superclass : 'MyPiece',
	#instVars : [
		'isFirstMove'
	],
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'constants' }
MyPawn class >> black [ 

	^ super black isFirstMove: true
]

{ #category : 'constants' }
MyPawn class >> white [ 

	^ super white isFirstMove: true
]

{ #category : 'accessing' }
MyPawn >> id [

	^ 'P'
]

{ #category : 'accessing' }
MyPawn >> isFirstMove [ 

	^ isFirstMove
]

{ #category : 'accessing' }
MyPawn >> isFirstMove: aBoolean [

	isFirstMove := aBoolean 
]

{ #category : 'path commands' }
MyPawn >> moveTo: aSquare [

	super moveTo: aSquare .
	self isFirstMove: false
]

{ #category : 'rendering' }
MyPawn >> renderPieceOn: aSquare [ 
	
	^ aSquare renderPawn: self
]

{ #category : 'rendering' }
MyPawn >> targetSquaresLegal: aBoolean [

	^ (self isWhite
		   ifTrue: [ { square up } ]
		   ifFalse: [ { square down } ]) select: [ :s |
		  s notNil and: [
			  s hasPiece not or: [ s contents color ~= color ] ] ]
]
