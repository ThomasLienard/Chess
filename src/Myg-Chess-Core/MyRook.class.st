Class {
	#name : 'MyRook',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'constants' }
MyRook class >> black [

	^ self new
		  color: Color black;
		  image: './pharo-local/iceberg/ThomasLienard/Chess/src/Myg-Chess-Style/rookB3.png';
		  yourself
]

{ #category : 'constants' }
MyRook class >> white [

	^ self new
		  color: Color white;
		  image: './pharo-local/iceberg/ThomasLienard/Chess/src/Myg-Chess-Style/rookW3.png';
		  yourself
]

{ #category : 'accessing' }
MyRook >> id [
	^ 'R'
]

{ #category : 'rendering' }
MyRook >> targetSquares [

	^ self upFile , self downFile , self leftFile , self rightFile
]

{ #category : 'rendering' }
MyRook >> targetSquaresLegal: aBoolean [

	^ (self upFileLegal: aBoolean) , (self downFileLegal: aBoolean)
	  , (self leftFileLegal: aBoolean) , (self rightFileLegal: aBoolean)
]
