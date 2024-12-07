"
# Example

```
board := MyChessGame freshGame.
board size: 800@600.
space := BlSpace new.
space root addChild: board.
space pulse.
space resizable: true.
space show.
```
"
Class {
	#name : 'MyChessGame',
	#superclass : 'BlElement',
	#instVars : [
		'board',
		'currentPlayer',
		'whitePlayer',
		'blackPlayer',
		'moveCount',
		'movesLabel',
		'moveCountLabel',
		'moves',
		'dsp'
	],
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'instance creation' }
MyChessGame class >> freshGame [

	^ self fromFENString: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1'
]

{ #category : 'instance creation' }
MyChessGame class >> fromFENString: aFENString [

	^ super new
		  initializeFromFENGame: (MyFENParser parse: aFENString);
		  yourself
]

{ #category : 'instance creation' }
MyChessGame class >> new [
	
	self error: 'Please use one of the other constructors'
]

{ #category : 'accessing' }
MyChessGame >> blackPlayer [ 
	
	^ blackPlayer 
]

{ #category : 'playing' }
MyChessGame >> checkForMate [

	whitePlayer king isCheckMated ifTrue: [ self halt: 'Black wins!' ].
	blackPlayer king isCheckMated ifTrue: [ self halt: 'White wins!' ].
]

{ #category : 'accessing' }
MyChessGame >> currentPlayer [ 
	
	^ currentPlayer 
]

{ #category : 'initialization' }
MyChessGame >> initialize [

	super initialize.

	moves := OrderedCollection new.
	whitePlayer := MyPlayer new white game: self.
	blackPlayer := MyPlayer new black game: self
]

{ #category : 'initialization' }
MyChessGame >> initializeFromFENGame: aFENGame [

	| button infoPane themeButton themeButton2 |
	aFENGame sideToMove = 'White'
		ifTrue: [ currentPlayer := whitePlayer ]
		ifFalse: [ currentPlayer := blackPlayer ].
		
	moveCount := aFENGame moveCount.

	board := MyChessBoard fromFENBoard: aFENGame board.
	board game: self.
	button := ToButton new.
	button labelText: 'Play!'.
	button whenClickedDo: [ self play ].
	
	themeButton := ToButton new.
	themeButton labelText: 'Theme 2'.
	themeButton whenClickedDo: [ self toTheme2 ].
	themeButton2 := ToButton new.
	themeButton2 labelText: 'Theme 1'.
	themeButton2 whenClickedDo: [ self toTheme1 ].
	
	infoPane := ToElement new.
	infoPane constraintsDo: [ :c | 
		        c vertical fitContent.
		        c horizontal matchParent ].
	infoPane layout: BlLinearLayout vertical.
	infoPane layout cellSpacing: 10.
	infoPane margin: (BlInsets all: 20).
	infoPane matchParent.
	
	movesLabel := ToLabel new beMultiLine.
	movesLabel matchParent.

	self addChild: board.
	self addChild: infoPane.
	infoPane addChild: movesLabel.
	infoPane addChild: button.
	infoPane addChild: themeButton.
	infoPane addChild: themeButton2.

	self layout: BlLinearLayout horizontal.
	self constraintsDo: [ :aLayoutConstraints |
		aLayoutConstraints horizontal fitContent.
		aLayoutConstraints vertical fitContent ]
]

{ #category : 'public' }
MyChessGame >> move: piece to: square [

	piece moveTo: square.
	self recordMovementOf: piece to: square
]

{ #category : 'accessing' }
MyChessGame >> pieces [

	^ board pieces
]

{ #category : 'playing' }
MyChessGame >> play [

	currentPlayer play.
	currentPlayer = whitePlayer
		ifTrue: [ currentPlayer := blackPlayer ]
		ifFalse: [ 
			moveCount := moveCount + 1.
			currentPlayer := whitePlayer ].
	self checkForMate
]

{ #category : 'moves' }
MyChessGame >> recordMovementOf: aPiece to: aSquare [
	"moves add: (MyMove piece: aPiece square: aSquare name)."

	| prefix movesText |
	prefix := currentPlayer isWhite
		          ifTrue: [ moveCount asString , '.' ]
		          ifFalse: [ '' ].
	moves add: prefix , ' ' , aPiece id , aSquare name.
	
	movesText := String streamContents: [ :stream |
		| currentLine |
		currentLine := ''.
		moves do: [ :m |
			currentLine := currentLine, ' ', m.
			currentLine size > 20 ifTrue: [ 
				stream nextPutAll: currentLine.
				stream cr.
				currentLine := ''.
			]
		].
		stream nextPutAll: currentLine
	].
	
	movesLabel text: movesText
]

{ #category : 'accessing' }
MyChessGame >> squares [

	^ board squares
]

{ #category : 'render' }
MyChessGame >> toTheme1 [ 
	| renderer squares|
	
	renderer := MyRenderer new.
	self squares do: [ :each | 
		each visitor: renderer;
		contents: (each contents)
		]
	
]

{ #category : 'render' }
MyChessGame >> toTheme2 [ 
	| renderer squares|
	
	renderer := MyRenderer2 new.
	self squares do: [ :each | 
		each visitor: renderer;
		contents: (each contents)
		]
	
]

{ #category : 'accessing' }
MyChessGame >> whitePlayer [ 
	
	^ whitePlayer 
]
