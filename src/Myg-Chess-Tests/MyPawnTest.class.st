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
    board at: 'e6' put: blackPawn .
    board at: 'e5' put: whitePawn . "Pion blanc bloque la case e6"

    "Le pion noir ne devrait pas pouvoir avancer car il est bloqué"
    squares := blackPawn targetSquares.
    self assert: squares isEmpty.
]

{ #category : 'tests' }
MyPawnTest >> testBlackPawnBlockedAtStart [ 
    | squares |
    board at: 'e7' put: blackPawn .
    board at: 'e6' put: whitePawn . "Pion blanc bloque la case e6"

    "Le pion noir ne devrait pas pouvoir avancer car il est bloqué"
    squares := blackPawn targetSquares.
    self assert: squares isEmpty.
]

{ #category : 'tests' }
MyPawnTest >> testBlackPawnCanCaptureOnLeftDiagonal [

	| squares |
	board := MyChessBoard empty.
	board at: 'd2' put: whitePawn.
	board at: 'e3' put: blackPawn.
	
	"Le pion noir devrait pouvoir capturer le pion blanc en diagonale"
	squares := blackPawn targetSquares.

	"Vérification que d3 fait partie des mouvements possibles"
	self assertCollection: squares includesAll: (#(d2) collect: [:name | board at: name]).


]

{ #category : 'tests' }
MyPawnTest >> testBlackPawnCanCaptureOnRightDiagonal [

	| squares |
	board := MyChessBoard empty.
	board at: 'f2' put: whitePawn.
	board at: 'e3' put: blackPawn.
	

	"Le pion noir devrait pouvoir capturer le pion blanc en diagonale"
	squares := blackPawn targetSquares.

	"Vérification que d3 fait partie des mouvements possibles"
	self assertCollection: squares includesAll: (#(f2) collect: [:name | board at: name]).

]

{ #category : 'tests' }
MyPawnTest >> testBlackPawnCanMoveTwoSquaresOnFirstMove [

	| squares |
    board at: 'e7' put: blackPawn.

    "Le pion noir devrait pouvoir descendre d'une ou deux cases"
    squares := blackPawn targetSquares.
    self assertCollection: squares includesAll: (#(e6 e5) collect: [:name | board at: name]).
]

{ #category : 'tests' }
MyPawnTest >> testBlackPawnMoves [ 
    | squares |
    board at: 'e7' put: blackPawn .

    "Le pion noir devrait pouvoir reculer d'une case"
    squares := blackPawn targetSquares.
    self assertCollection: squares includesAll: (#(e6) collect: [:name | board at: name]).

]

{ #category : 'tests' }
MyPawnTest >> testCheckCanUseEnPassantAfterMove [
	
	| squares |
	board := MyChessBoard empty.
	board at: 'c4' put: whitePawn.
	
	whitePawn moveTo: 'c5'.
	squares := whitePawn targetSquares.

	self assertCollection: squares includesAll: (#(c5) collect: [:name | board at: name]).
	
	self assert: whitePawn canUseEnPassant
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
    board at: 'e3' put: whitePawn .
    board at: 'e4' put: blackPawn . "Pion noir bloque la case e3"

    "Le pion blanc ne devrait pas pouvoir avancer car il est bloqué"
    squares := whitePawn targetSquares.
    self assert: squares isEmpty.
]

{ #category : 'tests' }
MyPawnTest >> testWhitePawnBlockedAtStart [ 
    | squares |
    board at: 'e2' put: whitePawn .
    board at: 'e3' put: blackPawn . "Pion noir bloque la case e3"

    "Le pion blanc ne devrait pas pouvoir avancer car il est bloqué"
    squares := whitePawn targetSquares.
    self assert: squares isEmpty.
]

{ #category : 'tests' }
MyPawnTest >> testWhitePawnCanCaptureOnLeftDiagonal [

	| squares |
	board := MyChessBoard empty.
	board at: 'e2' put: whitePawn.
	board at: 'd3' put: blackPawn.
	

	"Le pion blanc devrait pouvoir capturer le pion noir en diagonale"
	squares := whitePawn targetSquares.

	"Vérification que d3 fait partie des mouvements possibles"
	self assertCollection: squares includesAll: (#(d3) collect: [:name | board at: name]).

]

{ #category : 'tests' }
MyPawnTest >> testWhitePawnCanCaptureOnRightDiagonal [

	| squares |
	board := MyChessBoard empty.
	board at: 'e2' put: whitePawn.
	board at: 'f3' put: blackPawn.
	

	"Le pion blanc devrait pouvoir capturer le pion noir en diagonale"
	squares := whitePawn targetSquares.

	"Vérification que d3 fait partie des mouvements possibles"
	self assertCollection: squares includesAll: (#(f3) collect: [:name | board at: name]).



	
]

{ #category : 'tests' }
MyPawnTest >> testWhitePawnCanMoveTwoSquaresOnFirstMove [

	| squares |
    board at: 'e2' put: whitePawn . 

    "Le pion blanc devrait pouvoir monter d'une ou deux cases"
    squares := whitePawn targetSquares.
    self assertCollection: squares includesAll: (#(e3 e4) collect: [:name | board at: name]).
]

{ #category : 'tests' }
MyPawnTest >> testWhitePawnMoves [ 
    | squares |
    board at: 'e2' put: whitePawn .

    "Le pion blanc devrait pouvoir avancer d'une case"
    squares := whitePawn targetSquares.
    self assertCollection: squares includesAll: (#(e3) collect: [:name | board at: name]).

]
