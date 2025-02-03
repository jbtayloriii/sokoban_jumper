# Sokoban Jumper

A small sokoban game using a "jumper" mechanic. The charater can move in the cardinal directions. Upon moving three times in a row in a single direction, the character shoots forward until they collide with a wall or immovable object (metal crate). The goal is to try a small experiment with adding different movement mechanics to see if it makes a sokoban game more interesting/varied.

Some ideas:

- Jumping will be the core mechanic and will open up some interesting things:
    - Destroying enemies via teleporting through them
    - Hopping over gaps via jumping
    - Pushing blocks might become more interesting depending on what the block does when jumping. It also might just become more tedious
    - Corridors that force the player to jump, when they don't want to (maybe there will be some sort of "anti jump" tile too)
- Having the first couple of levels restrict the player's movement so they can't "jump" until they learn it on a later level.


# Running

I'm running this on my Mac:

1. Open the root directory in VSCode
2. Open a terminal in VSCode
3. Run the Love program with the current directory: `/Applications/love.app/Contents/MacOS/love .`
