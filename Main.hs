module Main where

import qualified Alpine.Parser.Lexer as Lexer
main :: IO()
main = do
    let program = "let x = 10"
    let lexedProgram = lex program
    print program



