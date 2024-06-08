module Alpine.Parser.Tokens(
    Token(..)
) where
data Token =
    Int Int |
    Float Float |
    False |
    True |
    Identifier String |
    Let |
    Equal |
    Undefined


