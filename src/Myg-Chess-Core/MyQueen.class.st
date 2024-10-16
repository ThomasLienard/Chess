Class {
	#name : 'MyQueen',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'constants' }
MyQueen class >> black [

	^ self new
		  color: Color black;
		  image: './pharo-local/iceberg/ThomasLienard/Chess/src/Myg-Chess-Style/queenB3.png';
		  yourself
]

{ #category : 'constants' }
MyQueen class >> white [

	^ self new
		  color: Color white;
		  image: './pharo-local/iceberg/ThomasLienard/Chess/src/Myg-Chess-Style/queenW3.png';
		  yourself
]

{ #category : 'rendering' }
MyQueen >> targetSquaresLegal: aBoolean [

	| likeABishop likeARook |
	likeABishop := (self upRightDiagonalLegal: aBoolean)
	               , (self upLeftDiagonalLegal: aBoolean)
	               , (self downRightDiagonalLegal: aBoolean)
	               , (self downLeftDiagonalLegal: aBoolean).
	likeARook := (self upFileLegal: aBoolean)
	             , (self downFileLegal: aBoolean)
	             , (self leftFileLegal: aBoolean)
	             , (self rightFileLegal: aBoolean).
	^ likeABishop , likeARook
]
