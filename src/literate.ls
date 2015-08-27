{memoize, map, all} = require 'prelude-ls'

fib = (x) ->
    | x <= 1     => 1
    | otherwise  => fibs (x-1) + fibs (x-2)

fibMem = memoize fib
