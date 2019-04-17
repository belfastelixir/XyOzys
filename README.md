# Xy Ozys

Aka. Tic-Tac-Toe, Noughts and Crosses etc.

## Description

A solution of the code kata challenge hosted by [April Meetup](https://www.meetup.com/BelfastFP/events/260305305/) of the [Belfast FP](https://www.meetup.com/BelfastFP/) group. 

This solution is written in [Elixir](https://elixir-lang.org/) and was paired by [@holsee](http://github.com/holsee) and [@swmcc](http://github.com/swmcc) using smiple functions and data with on the fly computation.


## Challenge

Implement a library which enables playing games of Xy Ozys.

### Rules

* Expose similar API to that defined in the _Spec_, however you may diverge for lang idiom reasons.
* Implement using [functional programming](https://en.wikipedia.org/wiki/Functional_programming).
* Write tests for the public API.

## Spec

### Functions

Start a new game:
```
new() # => Game
```

Player makes a move:
```
turn(Game, Cell, Player) # => Ok(Game) | Error(Reason)
```

Query the game state:
```
status(Game) # => Status
```

### Types

```
Game    # Reference to the game
Cell    # Reference to a position within the game board
Player  # 'X' or 'O'
Status  # "Tie", "X Wins", "O Wins", "X's Turn", "O's Turn"
Reason  # Reason that `turn` operation was invalid e.g. "Game over", "Not X's turn" etc.
```

