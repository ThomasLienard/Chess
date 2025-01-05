"
My black pawn class 
"
Class {
	#name : 'MyBlackPawn',
	#superclass : 'MyPawn',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'constants' }
MyBlackPawn class >> black [ 

^ self new
        color: Color black;
        isFirstMove: true;
        yourself
]

{ #category : 'path commands' }
MyBlackPawn >> enPassantTargetSquare [ 
    
	| lastMovedPiece lastMoveTo lastMoveFrom |
    lastMovedPiece := self board lastMovedPiece.
    lastMoveTo := self board lastMoveTo.
    lastMoveFrom := self board lastMoveFrom.

    self isOnFifthRank ifFalse: [ ^ nil ].

    "Vérifie si le pion ennemi a fait un mouvement double."
    (lastMovedPiece class = MyWhitePawn and: [
        (lastMoveFrom name asInteger = 2) and: [
        (lastMoveTo name asInteger = 4)]])
        ifTrue: [
            "Vérifie la présence d'un pion ennemi à gauche ou à droite"
            (self square left contents = lastMovedPiece ifTrue: [
                ^ (square downLeft) ]).

            (self square right contents = lastMovedPiece ifTrue: [
                ^ ( square downRight ) ]) ].

    ^ nil
]

{ #category : 'testing' }
MyBlackPawn >> isEnemyPiece: aPiece [
	^ (aPiece isWhite)
]

{ #category : 'checking' }
MyBlackPawn >> isOnFifthRank [

	^  ((self square name) asInteger = 4) 
]

{ #category : 'path commands' }
MyBlackPawn >> moveTo: aSquare [

	| lastSquare wasEnPassant|

	((self targetSquaresLegal: true) includes: aSquare) ifFalse: [ ^ self ].
	
	lastSquare := self square.
	wasEnPassant := aSquare hasPiece not.
	
	super moveTo: aSquare.
	(wasEnPassant ) ifTrue: [ aSquare up emptyContents ].
	self board lastMoveFrom: lastSquare .
	self board lastMoveTo: aSquare .
	self isFirstMove: false.
		
   

	
]

{ #category : 'rendering' }
MyBlackPawn >> targetSquaresLegal: aBoolean [

	| forwardSquare doubleForwardSquare attackLeft attackRight enPassant legalMoves |

	forwardSquare := square down .
		
	doubleForwardSquare := 
		forwardSquare ifNotNil: [forwardSquare down ].
	
	attackLeft :=  square downLeft .
		
	attackRight :=  square downRight .

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
