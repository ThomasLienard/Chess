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
	(wasEnPassant ) ifTrue: [ aSquare down emptyContents ].
	self board lastMoveFrom: lastSquare .
	self board lastMoveTo: aSquare .
	self isFirstMove: false.
		
   

	
]

{ #category : 'rendering' }
MyPawn >> targetSquaresLegal: aBoolean [

	| forwardSquare doubleForwardSquare attackLeft attackRight enPassant legalMoves |

	forwardSquare := self isWhite
		ifTrue: [ square up ]
		ifFalse: [ square down ].
		
	doubleForwardSquare := 
		forwardSquare ifNotNil: [ 
			self isWhite
				ifTrue: [ forwardSquare up ]
				ifFalse: [ forwardSquare down ]. 
		].
	
	attackLeft := self isWhite
		ifTrue: [ square upLeft ]
		ifFalse: [ square downLeft ].
		
	attackRight := self isWhite
		ifTrue: [ square upRight ]
		ifFalse: [ square downRight ].

	legalMoves := OrderedCollection new.

	"Ajout des mouvements de base"
	forwardSquare ifNotNil: [
		forwardSquare hasPiece ifFalse: [
			legalMoves add: forwardSquare.
			
			isFirstMove ifTrue: [
				doubleForwardSquare ifNotNil: [
					doubleForwardSquare hasPiece ifFalse: [
						legalMoves add: doubleForwardSquare ] ] ] ] ].

	"Ajout des attaques en diagonale, seulement si la pièce est ennemie"
	attackLeft ifNotNil: [
		attackLeft hasPiece ifTrue: [
			(self isEnemyPiece: attackLeft contents) ifTrue: [
				legalMoves add: attackLeft ] ] ].

	attackRight ifNotNil: [
		attackRight hasPiece ifTrue: [
			(self isEnemyPiece: attackRight contents) ifTrue: [
				legalMoves add: attackRight ] ] ].
	
	(enPassant := self enPassantTargetSquare) ifNotNil: [
		
			legalMoves add: enPassant ].

	^ legalMoves

]
