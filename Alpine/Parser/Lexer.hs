module Alpine.Parser.Lexer
(
    lexProgram
) where
import Alpine.Parser.Tokens as Tokens
import Data.Char
import Data.Bifunctor
import Data.Typeable


-- Lex the entire program
lexProgram :: String -> [Token]
lexProgram [] = []
lexProgram program =
    let singleLexed = lexSingle program
    in
        fst singleLexed : lexProgram (snd singleLexed)

-- Lex a single value
lexSingle :: [Char] -> (Token, [Char])

lexSingle remainingProgram
    | null cleanedProgram = (UndefinedString "", [])
    | firstChar == '#' = lexLabel remainingProgram
    | firstChar == '@' =  lexTypecast remainingProgram
    | firstChar == '\"' = lexStringliteral remainingProgram
    | isDigit firstChar = lexIntOrFloat remainingProgram
    | isAlpha firstChar = lexIdentifierOrKeyword remainingProgram
    | isSymbol firstChar = lexOperator remainingProgram
    | otherwise = lexPunctuationOrUndefined remainingProgram
    where cleanedProgram = skipWhiteSpaces remainingProgram
          firstChar = if null cleanedProgram then ' ' else head cleanedProgram

-- Lex a label
lexLabel :: [Char] -> (Token, [Char])


    

--Take next full string
takeFullString :: [Char] -> ([Char], [Char])
takeFullString [] = ([], [])
takeFullString (' ' : xs) = ([ ], xs)
takeFullString restProgram =
    let remainder = takeFullString (tail restProgram)
    in
        Data.Bifunctor.first (head restProgram :) remainder
-- Skip the white spaces
skipWhiteSpaces :: [Char] -> [Char]

skipWhiteSpaces [] = []
skipWhiteSpaces [x] = [x | x == ' ']
skipWhiteSpaces (x : xs) = if x == ' ' then skipWhiteSpaces xs else x : xs
