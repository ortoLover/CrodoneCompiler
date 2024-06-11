module Alpine.Parser.Lexer
(
    lexProgram
) where
import Crodone.Parser.Tokens as Tokens

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
  | firstChar == '\"' = lexStringLiteral (tail program)
  | isNumber firstChar = lexIntOrFloatLiteral program
  | isAlphaNum firstChar = lexIdOrKeyword program
  | isPunctuation firstChar = lexPunctuation program
  where firstChar = if null program then ' ' else head program
        secondChar = if null program || null (program tail) then ' ' else head head program
         
-- Skip a comment
skipComment :: [Char] -> [Char]
skipComment [] = []
skipComment ('\n': program) = program
skipComment program = skipComment (tail program)
