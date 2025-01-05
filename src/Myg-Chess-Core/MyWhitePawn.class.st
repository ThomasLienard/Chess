"
My white pawn class
"
Class {
	#name : 'MyWhitePawn',
	#superclass : 'MyPawn',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'constants' }
MyWhitePawn class >> white [ 

    ^ self new
        color: Color white;
        isFirstMove: true;
        yourself
]

{ #category : 'path commands' }
MyWhitePawn >> enPassantTargetSquare [ 
    
	| lastMovedPiece lastMoveTo lastMoveFrom |
    lastMovedPiece := self board lastMovedPiece.
    lastMoveTo := self board lastMoveTo.
    lastMoveFrom := self board lastMoveFrom.
	
    self isOnFifthRank ifFalse: [ ^ nil ].
	
    "Vérifie si le pion ennemi a fait un mouvement double."
    (lastMovedPiece class = MyBlackPawn and: [
        (lastMoveFrom name asInteger = 7) and: [
        (lastMoveTo name asInteger = 5)]])
        ifTrue: [
            "Vérifie la présence d'un pion ennemi à gauche ou à droite"
            (self square left contents = lastMovedPiece ifTrue: [
                ^ ( square upLeft ) ]).

            (self square right contents = lastMovedPiece ifTrue: [
                ^ ( square upRight ) ]) ].

    ^ nil
]

{ #category : 'testing' }
MyWhitePawn >> isEnemyPiece: aPiece [
	^ (aPiece isWhite not)

]

{ #category : 'checking' }
MyWhitePawn >> isOnFifthRank [

	^  ((self square name) asInteger = 5) 
		
]

{ #category : 'path commands' }
MyWhitePawn >> moveTo: aSquare [ 

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
MyWhitePawn >> targetSquaresLegal: aBoolean [

	| forwardSquare doubleForwardSquare attackLeft attackRight enPassant legalMoves |

	forwardSquare := square up .
		
	doubleForwardSquare := 
		forwardSquare ifNotNil: [ forwardSquare up ].
	
	attackLeft := square upLeft .
		
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
