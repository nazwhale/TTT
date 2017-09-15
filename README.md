
# Tic-Tac-Toe
[![Build Status](https://api.travis-ci.org/nazwhale/Tic-Tac-Toe.svg?branch=master)](https://travis-ci.org/nazwhale/Tic-Tac-Toe)
[![Coverage Status](https://coveralls.io/repos/github/nazwhale/Tic-Tac-Toe/badge.svg?branch=master)](https://coveralls.io/github/nazwhale/Tic-Tac-Toe?branch=master)

A command-line game of Noughts and Crosses (or, for the non-British, [Tic-Tac-Toe](https://en.wikipedia.org/wiki/Tic-tac-toe)), refactored from an untested and buggy piece of code.

### Installation and Initiation
Clone repository:

```
$ git clone git@github.com:nazwhale/Tic-Tac-Toe.git
$ cd Tic-Tac-Toe
```
Install dependencies with [Bundler](http://bundler.io/):
```
$ gem install bundler     
$ bundle install
```
To start the game, enter `ruby play.rb` follow the instructions.

### Challenge

My brief was from a fictional product manager, who had previously hired a consultant to create a game of Tic-Tac-Toe for children to play. I had been subsequently hired to improve the quality of the code and implement some additional features.

### Approach

I first read though the brief a number of times, picking out the changes highlighted by my fictional product manager and turning them into user stories (see below).

As I had been given a game of Tic-Tac-Toe which essentially worked, my plan was to implement as many tests as possible before writing any new code. That way I could ensure I wasn't breaking the mechanics of the game whilst refactoring it. Once this was completed, I set upon renaming variables and refactoring the code into smaller methods with single responsibilities.

After that, I spent some time diagramming, planning out the architecture of my game. I decided on a 'Game' object to handle the start of the game, cycles of play, and end of the game. My 'Board' object would handle the rules of Tic-Tac-Toe, while the 'Human' player would store a symbol. Finally, my 'Computer' player also stored a symbol, while also being aware of it's opponent's symbol and having the functionality of choosing a move by itself. One-by-one, I extracted each object from my Game class, test-driving the development of each.

Once I was happy with each of my objects, I began implementing the features I had identified in my user stories. While doing this, it became apparent that a 'Game Maker' object would be beneficial to handle the initial setup of the Game and instantiate the players, leaving the Game object to only be responsible for the gameplay. I also extracted all of my output messages to a class of their own ('Messages'), in order to remove view information from my back-end logic.

Before submitting my solution, I re-read through the brief and realised that I had misread the desired difficulty of the Computer player (implementing medium, instead of unbeatable). I then did some research on creating an unbeatable Tic-Tac-Toe AI, and decided that the Minimax algorithm was the right tool for the job.

I found some great blog posts ([this](http://neverstopbuilding.com/minimax) and [this](http://malcolmnewsome.com/post/74172036027/unbeatable-tic-tac-toe-with-minimax)) explaining implementations of Minimax in Ruby, and tried to adapt these to my implementation of Tic-Tac-Toe. However, I couldn't seem to get anything working. My Computer player was behaving in confusing ways and debugging a recursive algorithm proved difficult.

After a **lot** of struggling, I eventually had something that worked. The breakthroughs came when I took a step back, wrote more tests, and logged everything I could think of to the console (see below). Outputting all my data in the correct order really deepened my understanding of the algorithm.

![Screenshot](https://i.imgur.com/LhxdJ0L.png)

Following that, I noticed that my algorithm was taking a very long time to calculate the first move on an empty board, but was arriving at the same conclusion every time. I did a bit of research and found a [delicious xkcd drawing](https://xkcd.com/832/), showing that the corners give the first player the best winning possibilities. After test-driving this, I had an unbeatable (and slightly more efficient) AI for Tic-Tac-Toe!

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
So that I can the difficulty of the game is set at hard,
I would like the computer player to be unbeatable.

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

### Example Game

![Screenshot](https://i.imgur.com/BNdmWEb.png)

A few moves later...

![Screenshot](https://i.imgur.com/JADDlwN.png)
