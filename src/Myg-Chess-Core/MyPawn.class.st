Class {
	#name : 'MyPawn',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'constants' }
MyPawn class >> black [

	^ self new
		  color: Color black;
		  yourself
]

{ #category : 'constants' }
MyPawn class >> white [

	^ self new
		  color: Color white;
		  yourself
]

{ #category : 'rendering' }
MyPawn >> acceptVisitor: aVisitor [
	
	^ aVisitor renderPawn: self.
]

{ #category : 'accessing' }
MyPawn >> id [

	^ 'P'
]

{ #category : 'rendering' }
MyPawn >> targetSquaresLegal: aBoolean [

	^ (self isWhite
		   ifTrue: [ { square up } ]
		   ifFalse: [ { square down } ]) select: [ :s |
		  s notNil and: [
			  s hasPiece not or: [ s contents color ~= color ] ] ]
]
