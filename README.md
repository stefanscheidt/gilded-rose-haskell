# Haskell port of the Gilded-Rose Kata

This is a Haskell port of the *Gilded-Rose-Kata*. For more information visit
https://github.com/emilybache/GildedRose-Refactoring-Kata.

## Prerequisits

[Stack](https://docs.haskellstack.org/en/stable/README/).

To install Stack on macOS with [Homebrew](https://brew.sh/) you can do `brew install haskell-stack`.

## Building and Running

Run `stack install --install-ghc` initially, then `stack test` to execute the tests after
each refactoring.

The tests are in `test/GildedRoseSpec.hs`. Refer to http://hspec.github.io/ for
more information about writing tests using `Hspec`.
https://www.fpcomplete.com/ide?git=git://github.com/sheyll/gilded-rose-haskell.git

Execute `stack build` to build the executable.

To execute the program run `stack exec gilded-rose [days]` where `[days]` denotes an optional
parameter for the number of days to simulate.
