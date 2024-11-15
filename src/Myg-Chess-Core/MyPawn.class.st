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

{ #category : 'path commands' }
MyPawn >> moveTo: aSquare [

	((self targetSquaresLegal: true) includes: aSquare)
    ifTrue: [ 
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

	| forwardSquare doubleForwardSquare attackLeft attackRight legalMoves |

	forwardSquare := self isWhite
		ifTrue: [ square up ]
		ifFalse: [ square down ].
		
	doubleForwardSquare := self isWhite
		ifTrue: [ forwardSquare up ]
		ifFalse: [ forwardSquare down ].
		
	attackLeft := self isWhite
		ifTrue: [ square up left ]
		ifFalse: [ square down left ].
		
	attackRight := self isWhite
		ifTrue: [ square up right ]
		ifFalse: [ square down right ].

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

	^ legalMoves

]
