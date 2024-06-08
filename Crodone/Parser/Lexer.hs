module Alpine.Parser.Lexer
(
    lexProgram
) where
import Alpine.Parser.Tokens as Tokens

-- Lex the entire program
lexProgram :: [Char] -> [Token]
lexProgram [] = []
lexProgram program =
    let singleLexed = lexSingle program
    in
        fst singleLexed : lexProgram (snd singleLexed)

-- Lex a single value 
lexSingle :: [Char] -> (Token, [Char])
lexSingle program
  | null program = (Undefined, [])
  | firstChar == '-' && secondChar == '-' = lexSingle (skipComment program) 
  | firstChar == ' ' = lexSingle (tail program)
  | firstChar == '\"' = lexString (tail program)
  | isNumber firstChar = lexIntOrFloatLiteral
  where firstChar = if null program then ' ' else head program
        secondChar = if null program || null (program tail) then ' ' else head head program
         
-- Skip a comment
skipComment :: [Char] -> [Char]
skipComment [] = []
skipComment ("\n": program) = program
skipComment program = skipComment (tail program)

-- Lex a string
lexString :: [Char] -> [Token, [Char]]
lexString program =
  let result = lexStringRec program
  in 
    (StringLiteral (fst result), snd result)

lexStringRec :: [Char] -> ([Char], [Char])
lexStringRec [] = [] 
lexStringRec ('\"' : xs) = 
  ([], xs)
lexStringRec (x : xs) =
  let result = lexStringRec xs
  in
    (x :  fst result, snd result)

-- Lex an Int or a Float
lexIntOrFloatLiteral

