Class {
	#name : 'MyPawnTest',
	#superclass : 'TestCase',
	#instVars : [
		'board',
		'whitePawn',
		'blackPawn',
		'state'
	],
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'running' }
MyPawnTest >> setUp [

	super setUp.
   board := MyChessBoard empty.
   board initializePieces.
   whitePawn := MyPawn white.
   blackPawn := MyPawn black.
   state := MyUnselectedState board: board.

	"Put here a common initialization logic for tests"
]

{ #category : 'tests' }
MyPawnTest >> testBlackPawnBlocked [ 
    | squares |
    board := MyChessBoard empty.
    board at: 'e7' put: (blackPawn := MyPawn black).
    board at: 'e6' put: (MyPawn white). "Pion blanc bloque la case e6"

    "Le pion noir ne devrait pas pouvoir avancer car il est bloqué"
    squares := blackPawn targetSquares.
    self assert: squares isEmpty.
]

{ #category : 'tests' }
MyPawnTest >> testBlackPawnMoves [ 
    | squares |
    board := MyChessBoard empty.
    board at: 'e7' put: (blackPawn := MyPawn black).

    "Le pion noir devrait pouvoir reculer d'une case"
    squares := blackPawn targetSquares.
    self assertCollection: squares includesAll: (#(e6) collect: [:name | board at: name]).

]

{ #category : 'tests' }
MyPawnTest >> testPawnCannotMoveBackwards [ 
    
        board at: 'e4' put: whitePawn.

        "Sélectionner la case e4 (pion blanc)"
        state := state clickOn: (board at: 'e4').

        "Essayer de déplacer le pion en e3 (recul)"
        self should: [ state clickOn: (board at: 'e3') ] raise: Error.
    
]

{ #category : 'tests' }
MyPawnTest >> testWhitePawnBlocked [ 
    | squares |
    board := MyChessBoard empty.
    board at: 'e2' put: (whitePawn := MyPawn white).
    board at: 'e3' put: (MyPawn black). "Pion noir bloque la case e3"

    "Le pion blanc ne devrait pas pouvoir avancer car il est bloqué"
    squares := whitePawn targetSquares.
    self assert: squares isEmpty.
]

{ #category : 'tests' }
MyPawnTest >> testWhitePawnMoves [ 
    | squares |
    board := MyChessBoard empty.
    board at: 'e2' put: (whitePawn := MyPawn white).

    "Le pion blanc devrait pouvoir avancer d'une case"
    squares := whitePawn targetSquares.
    self assertCollection: squares includesAll: (#(e3) collect: [:name | board at: name]).

]
