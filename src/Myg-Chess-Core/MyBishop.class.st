Class {
	#name : 'MyBishop',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'constants' }
MyBishop class >> black [

	^ self new
		  color: Color black;
		  yourself
]

{ #category : 'constants' }
MyBishop class >> white [

	^ self new
		  color: Color white;
		  yourself
]

{ #category : 'rendering' }
MyBishop >> acceptVisitor: aVisitor [
	
	^ aVisitor renderBishop: self.
]

{ #category : 'accessing' }
MyBishop >> id [
	
	^ 'B'
]

{ #category : 'rendering' }
MyBishop >> targetSquaresLegal: aBoolean [

	^ (self upRightDiagonalLegal: aBoolean)
	  , (self upLeftDiagonalLegal: aBoolean)
	  , (self downRightDiagonalLegal: aBoolean)
	  , (self downLeftDiagonalLegal: aBoolean)
]
