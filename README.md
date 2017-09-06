
# Tic-Tac-Toe
[![Build Status](https://travis-ci.org/nazwhale/TTT.svg?branch=master)](https://travis-ci.org/nazwhale/Tic-Tac-Toe)
[![Coverage Status](https://coveralls.io/repos/github/nazwhale/Tic-Tac-Toe/badge.svg?branch=master)](https://coveralls.io/github/nazwhale/Tic-Tac-Toe?branch=master)

A command-line game of Noughts and Crosses (or, for the non-British, [Tic-Tac-Toe](https://en.wikipedia.org/wiki/Tic-tac-toe)), refactored from an untested and buggy piece of code.

### Challenge

My brief was from a fictional product manager, who had previously hired a consultant to create a game of Tic-Tac-Toe for children to play. I had been subsequently hired to improve the quality of the code and implement some additional features.

### Approach

I first read though the brief a number of times, picking out the changes highlighted by my fictional product manager and turning them into user stories (see below).

As I had been given a game of Tic-Tac-Toe which essentially worked, my plan was to implement as many tests as possible before writing any new code. That way I could ensure I wasn't breaking the mechanics of the game whilst refactoring it.

After that, I spent some time diagramming, planning out the architecture of my game. I decided on a Game object to handle the start of the game, cycles of play, and end of the game. My Board object would handle the rules of Tic-Tac-Toe, while the Human player would store a symbol. Finally, my Computer player also stored a symbol, while also being aware of it's opponent's symbol and having the functionality of choosing a move by itself.

Later, while implementing features, I decided to also introduce a Game Maker object, which would handle the initial setup of the Game and instantiate the players, leaving the Game object to only be responsible for the gameplay. I also extracted all of my output messages to a class of their own (Messages), in order to remove view information from my back-end logic.

![Screenshot](https://i.imgur.com/e2n3iHT.jpg)

### User Stories

```
As a project manager,
So that I can add features in the future,
I would like the game to be coded in a flexible manner.

As a project manager,
So that the code for the game is maintainable,
I would like the code to be well-tested.

As a project manager,
So that the players don't get confused,
I would like clear user messages to keep the user aware of what is going on.

As a project manager,
Incase the children playing the game press the wrong buttons,
I would like the game to gracefully handle bad user input.

As a project manager,
So that the game is a fun level of difficulty,
I would like the computer player to sometimes be beatable.

As a project manager,
So that that I can play alone, with a friend, or watch two computers play,
I would like to have a choice of game types.

As a project manager,
So that the player can have more control over the game,
I would like the them to be able to choose who goes first.

As a project manager,
To give the game a personal touch,
I would like the players to be able to choose the symbol with which they mark their selections on the board.
```

### Installation and Initiation
Clone repository:

```
$ git clone git@github.com:nazwhale/TTT.git
$ cd TTT
```
Install dependencies with [Bundler](http://bundler.io/):
```
$ gem install bundler     
$ bundle install
```
To start the game, enter `ruby play.rb` in the command-line and follow the instructions.

### Example Game

![Screenshot](https://i.imgur.com/BNdmWEb.png)

A few moves later...

![Screenshot](https://i.imgur.com/JADDlwN.png)
