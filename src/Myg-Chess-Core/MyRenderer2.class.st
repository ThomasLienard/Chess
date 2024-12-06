Class {
	#name : 'MyRenderer2',
	#superclass : 'MySquareVisitor',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'rendering' }
MyRenderer2 >> render: aPiece [

	^ aPiece acceptVisitor: self.
]

{ #category : 'rendering' }
MyRenderer2 >> renderBishop: aPiece [
	
	aPiece isWhite 
	ifTrue: [^Form fromFileNamed: './pharo-local/iceberg/ThomasLienard/Chess/src/Myg-Chess-Style/bishopW.png']
	ifFalse: [^Form fromFileNamed:'./pharo-local/iceberg/ThomasLienard/Chess/src/Myg-Chess-Style/bishopB.png']
]

{ #category : 'rendering' }
MyRenderer2 >> renderKing: aPiece [
	
	aPiece isWhite 
	ifTrue: [^Form fromFileNamed:'./pharo-local/iceberg/ThomasLienard/Chess/src/Myg-Chess-Style/kingW.png']
	ifFalse: [^Form fromFileNamed:'./pharo-local/iceberg/ThomasLienard/Chess/src/Myg-Chess-Style/kingB.png']
]

{ #category : 'rendering' }
MyRenderer2 >> renderKnight: aPiece [
	
	aPiece isWhite 
	ifTrue: [^Form fromFileNamed:'./pharo-local/iceberg/ThomasLienard/Chess/src/Myg-Chess-Style/knightW.png']
	ifFalse: [^Form fromFileNamed:'./pharo-local/iceberg/ThomasLienard/Chess/src/Myg-Chess-Style/knightB.png']
]

{ #category : 'rendering' }
MyRenderer2 >> renderPawn: aPiece [
	
	aPiece isWhite 
	ifTrue: [^Form fromFileNamed:'./pharo-local/iceberg/ThomasLienard/Chess/src/Myg-Chess-Style/pawnW.png']
	ifFalse: [^Form fromFileNamed:'./pharo-local/iceberg/ThomasLienard/Chess/src/Myg-Chess-Style/pawnB.png']
]

{ #category : 'rendering' }
MyRenderer2 >> renderQueen: aPiece [
	
	aPiece isWhite 
	ifTrue: [^Form fromFileNamed:'./pharo-local/iceberg/ThomasLienard/Chess/src/Myg-Chess-Style/queenW.png']
	ifFalse: [^Form fromFileNamed:'./pharo-local/iceberg/ThomasLienard/Chess/src/Myg-Chess-Style/queenB.png']
]

{ #category : 'rendering' }
MyRenderer2 >> renderRook: aPiece [
	
	aPiece isWhite 
	ifTrue: [^Form fromFileNamed:'./pharo-local/iceberg/ThomasLienard/Chess/src/Myg-Chess-Style/rookW.png']
	ifFalse: [^Form fromFileNamed:'./pharo-local/iceberg/ThomasLienard/Chess/src/Myg-Chess-Style/rookB.png']
]
