type Affect a = (a -> a)

data Attributes = Health Int | Armor Int
data Thing = Thing { affects :: [Affect Thing], xLoc :: Int, yLoc :: Int, attribs :: [Attributes] }
data World = World [Thing]