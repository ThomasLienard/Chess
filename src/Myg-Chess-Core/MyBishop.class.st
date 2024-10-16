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
		  image: './pharo-local/iceberg/ThomasLienard/Chess/src/Myg-Chess-Style/bishopB3.png';
		  yourself
]

{ #category : 'constants' }
MyBishop class >> white [

	^ self new
		  color: Color white;
		  image: './pharo-local/iceberg/ThomasLienard/Chess/src/Myg-Chess-Style/bishopW3.png';
		  yourself
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
