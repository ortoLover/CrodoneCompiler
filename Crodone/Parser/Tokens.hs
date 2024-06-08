module Alpine.Parser.Tokens(
    Token(..)
) where
data Token =
    -- Keywords
    If |
    Else |

    -- Punctuation
    Comma |
    Dot |
    LParen |
    RParen |
    LBrace |
    RBrace |

    -- Operators
    Plus |
    Sub |
    Mult |
    Div |

    -- Identifiers
    Identifier |

    -- Literals
    StringLiteral String |
    IntLiteral Int |
    FloatLiteral Float |
    -- Other
    Undefined
    



