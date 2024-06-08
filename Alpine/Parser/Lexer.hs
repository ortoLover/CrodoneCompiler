module Alpine.Parser.Lexer
(
    lexProgram
) where
import Alpine.Parser.Tokens as Tokens
import Data.Char
import Data.Bifunctor
import Data.Binary.Get (remaining)


-- Lex the entire program
lexProgram :: String -> [Token]
lexProgram [] = []
lexProgram program =
    let singleLexed = lexSingle program
    in
        fst singleLexed : lexProgram (snd singleLexed)


