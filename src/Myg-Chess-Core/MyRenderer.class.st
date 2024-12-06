Class {
	#name : 'MyRenderer',
	#superclass : 'MySquareVisitor',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'rendering' }
MyRenderer >> render: aPiece [

	^ aPiece acceptVisitor: self.
]

{ #category : 'rendering' }
MyRenderer >> renderBishop: aPiece [
	
	aPiece isWhite 
	ifTrue: [^Form fromFileNamed: './pharo-local/iceberg/ThomasLienard/Chess/src/Myg-Chess-Style/bishopW3.png']
	ifFalse: [^Form fromFileNamed:'./pharo-local/iceberg/ThomasLienard/Chess/src/Myg-Chess-Style/bishopB3.png']
]

{ #category : 'rendering' }
MyRenderer >> renderKing: aPiece [
	
	aPiece isWhite 
	ifTrue: [^Form fromFileNamed:'./pharo-local/iceberg/ThomasLienard/Chess/src/Myg-Chess-Style/kingW3.png']
	ifFalse: [^Form fromFileNamed:'./pharo-local/iceberg/ThomasLienard/Chess/src/Myg-Chess-Style/kingB3.png']
]

{ #category : 'rendering' }
MyRenderer >> renderKnight: aPiece [
	
	aPiece isWhite 
	ifTrue: [^Form fromFileNamed:'./pharo-local/iceberg/ThomasLienard/Chess/src/Myg-Chess-Style/knightW3.png']
	ifFalse: [^Form fromFileNamed:'./pharo-local/iceberg/ThomasLienard/Chess/src/Myg-Chess-Style/knightB3.png']
]

{ #category : 'rendering' }
MyRenderer >> renderPawn: aPiece [
	
	aPiece isWhite 
	ifTrue: [^Form fromFileNamed:'./pharo-local/iceberg/ThomasLienard/Chess/src/Myg-Chess-Style/pawnW3.png']
	ifFalse: [^Form fromFileNamed:'./pharo-local/iceberg/ThomasLienard/Chess/src/Myg-Chess-Style/pawnB3.png']
]

{ #category : 'rendering' }
MyRenderer >> renderQueen: aPiece [
	
	aPiece isWhite 
	ifTrue: [^Form fromFileNamed:'./pharo-local/iceberg/ThomasLienard/Chess/src/Myg-Chess-Style/queenW3.png']
	ifFalse: [^Form fromFileNamed:'./pharo-local/iceberg/ThomasLienard/Chess/src/Myg-Chess-Style/queenB3.png']
]

{ #category : 'rendering' }
MyRenderer >> renderRook: aPiece [
	
	aPiece isWhite 
	ifTrue: [^Form fromFileNamed:'./pharo-local/iceberg/ThomasLienard/Chess/src/Myg-Chess-Style/rookW3.png']
	ifFalse: [^Form fromFileNamed:'./pharo-local/iceberg/ThomasLienard/Chess/src/Myg-Chess-Style/rookB3.png']
]
