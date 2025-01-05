# Myg Chess Game

This is a chess game for Pharo based on Bloc, Toplo and Myg.

## What is this repository really about

The goal of this repository is not to be a complete full blown game, but a good enough implementation to practice software engineering skills:
 - testing
 - reading existing code
 - refactorings
 - profiling
 - debugging

## Getting started

### Getting the code

This code has been tested in Pharo 12. You can get it by installing the following baseline code:

```smalltalk
Metacello new
	repository: 'github://ThomasLienard/Chess:main';
	baseline: 'MygChess';
	onConflictUseLoaded;
	load.
```

### Using it

You can open the chess game using the following expression:

```smalltalk
board := MyChessGame freshGame.
board size: 800@600.
space := BlSpace new.
space root addChild: board.
space pulse.
space resizable: true.
space show.
```

## Katas

These are some ideas of exercises you may try:

### Fix pawn moves! By Thomas LIENARD

**Goal:** Practice debugging and testing

Pawns are one of the most complicated pieces of chess to implement.
They move forward, one square at a time, except for their first movement.
However, they can move diagonally to capture other pieces.
And in addition, there is the (in)famous "En passant" move that complicates everything (see https://en.wikipedia.org/wiki/En_passant, and the FEN documentation for ideas on how to encode this information https://www.chessprogramming.org/Forsyth-Edwards_Notation#En_passant_target_square).
As any *complicated* feature, the original developer (Guille P) left this for the end, and then left the project.
But you can do it.

Questions and ideas that can help you in the process:
- Can you write tests showing the bugs?
- What kind of tools can you use to spot the bug?
- Can you approach this incrementally? This is, splitting this task in many subtasks. How would you prioritize them?

### Make the game UI themable By Baptiste PARENT

**Goal:** Practice large refactorings to decouple game logic from rendering

Instead of using a font, try using assets from https://opengameart.org/art-search-advanced?field_art_tags_tid=chess or https://game-icons.net/.
As any *crazy* feature, the original developer (Guille P) did not prepare the engine for this.
But you can do it.

Questions and ideas that can help you in the process:
- How could you know that you're not breaking something while refactoring?
- Can you write tests that help you with the process?
- Refactoring and testing UI code can be challenging: this does not mean it is impossible!
- Can you do the refactoring in little steps that avoid breaking the code?
