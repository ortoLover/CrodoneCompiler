module Alpine.Parser.Tokens(
    Token(..)
) where
data Token =
    -- Keywords
    If |
    Else |
    Int |
    Float |
    Bool |
    

    -- Operators
    Plus |
    Sub |
    Mult |
    Div |

    -- Punctuation
    Comma |
    Dot |
    LParen |
    RParen |
    LBrace |
    RBrace |


    --

    -- Other
    Undefined
    



