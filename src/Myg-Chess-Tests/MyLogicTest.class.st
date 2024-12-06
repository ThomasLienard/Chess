Class {
	#name : 'MyLogicTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyLogicTest >> testCheckmateDetection [

    | game |
	 "FEN correspondant à un échec et mat"
    game := MyChessGame fromFENString: 'rnbqkbnr/pppppppp/8/8/4Q3/8/PPPPPPPP/RNB1KBNR b KQkq - 0 1'.  

    "Vérifier que le joueur noir est en échec et mat"
	 "Halt est un sous classe de Exception on peut donc catch comme une erreur"
    self should: [ game checkForMate ] raise: Error.

]

{ #category : 'tests' }
MyLogicTest >> testGameInitialization [

    | game pieces |
    game := MyChessGame freshGame.
    pieces := game pieces.
    
	 "Retirer les cases vides (= nil)"
	 pieces := pieces select: [ :each | each notNil ]	.
	
    "Vérifier qu'il y a 32 pièces sur le plateau"
    self assert: pieces size equals: 32.
    
    "Vérifier que les rois sont à leurs positions initiales"
	 "Comment vérifier la position ? -> board at:'e1'"
    "self assert: (pieces anySatisfy: [:p | (p id = 'k' or: p id = 'L') and: [(p square) name = 'e1']])."
    "self assert: (pieces anySatisfy: [:p | (p id = 'k' or: p id = 'L') and: [p position = 'e8']])."
    
    "Vérifier que les joueurs sont bien initialisés"
    self assert: game currentPlayer equals: game whitePlayer .

]

{ #category : 'tests' }
MyLogicTest >> testPlayerTurnSwitch [

    | game |
    game := MyChessGame freshGame.
    
    "Vérifier que le joueur initial est le joueur blanc"
    self assert: game currentPlayer equals: game whitePlayer.
    
    "Jouer un tour"
	 game play.
    
    "Vérifier que le joueur courant est maintenant le joueur noir"
    self assert: game currentPlayer equals: game blackPlayer.


]