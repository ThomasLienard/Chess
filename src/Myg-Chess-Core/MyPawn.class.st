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

	^ MyBlackPawn black 
]

{ #category : 'constants' }
MyPawn class >> white [ 

	^ MyWhitePawn white 
]

{ #category : 'rendering' }
MyPawn >> acceptVisitor: aVisitor [
	
	^ aVisitor renderPawn: self.
]

{ #category : 'path commands' }
MyPawn >> enPassantTargetSquare [ 
    
self subclassResponsibility 
]

{ #category : 'accessing' }
MyPawn >> id [

	^ 'P'
]

{ #category : 'testing' }
MyPawn >> isEnemyPiece: aPiece [

	self subclassResponsibility 
]

{ #category : 'accessing' }
MyPawn >> isFirstMove [ 

	^ isFirstMove
]

{ #category : 'accessing' }
MyPawn >> isFirstMove: aBoolean [

	isFirstMove := aBoolean 
]

{ #category : 'checking' }
MyPawn >> isOnFifthRank [

self subclassResponsibility 
]

{ #category : 'path commands' }
MyPawn >> moveTo: aSquare [

	| lastSquare wasEnPassant|

	((self targetSquaresLegal: true) includes: aSquare) ifFalse: [ ^ self ].
	
	lastSquare := self square.
	wasEnPassant := aSquare hasPiece not.
	
	super moveTo: aSquare.
	(wasEnPassant ) ifTrue: [ self isWhite 
		ifTrue: [ aSquare down emptyContents ] 
		ifFalse: [aSquare up emptyContents ]].
	self board lastMoveFrom: lastSquare .
	self board lastMoveTo: aSquare .
	self isFirstMove: false.
		
   

	
]

{ #category : 'rendering' }
MyPawn >> targetSquaresLegal: aBoolean [

	self subclassResponsibility
]
