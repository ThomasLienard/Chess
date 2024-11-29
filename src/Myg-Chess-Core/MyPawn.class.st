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

	^ super black isFirstMove: true
]

{ #category : 'constants' }
MyPawn class >> white [ 

	^ super white isFirstMove: true
]

{ #category : 'path commands' }
MyPawn >> enPassantTargetSquare [ 
    
	| lastMovedPiece lastMoveTo lastMoveFrom |
    lastMovedPiece := self board lastMovedPiece.
    lastMoveTo := self board lastMoveTo.
    lastMoveFrom := self board lastMoveFrom.

    self isOnFifthRank ifFalse: [ ^ nil ].

    "Vérifie si le pion ennemi a fait un mouvement double."
    (lastMovedPiece class = MyPawn and: [
        (lastMoveFrom name asInteger = (lastMovedPiece isWhite ifTrue: [2] ifFalse: [7])) and: [
        (lastMoveTo name asInteger = (lastMovedPiece isWhite ifTrue: [4] ifFalse: [5]))]])
        ifTrue: [
            "Vérifie la présence d'un pion ennemi à gauche ou à droite"
            (self square left contents = lastMovedPiece ifTrue: [
                ^ (self isWhite ifTrue: [ square upLeft ] ifFalse: [ square downLeft ]) ]).

            (self square right contents = lastMovedPiece ifTrue: [
                ^ (self isWhite ifTrue: [ square upRight ] ifFalse: [ square downRight ]) ]) ].

    ^ nil
]

{ #category : 'accessing' }
MyPawn >> id [

	^ 'P'
]

{ #category : 'testing' }
MyPawn >> isEnemyPiece: aPiece [
	^ (aPiece isWhite not and: [ self isWhite ]) or: (aPiece isWhite and: [ self isWhite not ])

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

	^ self isWhite 
		ifTrue: [ ((self square name) asInteger = 5) ] 
		ifFalse: [ ((self square name) asInteger = 4) ]
]

{ #category : 'path commands' }
MyPawn >> moveTo: aSquare [

	((self targetSquaresLegal: true) includes: aSquare)
    ifTrue: [ 
		self board lastMoveFrom: self square .
		self board lastMoveTo: aSquare .
		super moveTo: aSquare.
		self isFirstMove: false.
		
    ]
    ifFalse: [ 
        self
    ]

	
]

{ #category : 'rendering' }
MyPawn >> renderPieceOn: aSquare [ 
	
	^ aSquare renderPawn: self
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
