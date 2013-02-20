{-# LANGUAGE TypeSynonymInstances, FlexibleInstances #-}

import Control.Concurrent.STM
import qualified Data.Map as M(Map, lookup, insertWith, insert, adjust, delete)

type Affect a = (a -> a)

instance Show (Affect Thing) where
  show _ = "affect"



data Attributes =
  Health Int |
  Armor Int |
  Level Int |
  Experience Int |
  Strength Int |
  Balance Int |
  Dexterity Int |
  Endurance Int |
  Constitution Int |
  Gymnasticism Int deriving Show
    
data Thing = Thing {
  idOfThing :: Int,
  name :: String,
  affects :: [Affect Thing],
  attribs :: [Attributes],
  xLoc :: Int,
  yLoc :: Int,
  thingsInside :: [Thing] }
  | Wall deriving Show

data World = World {
  places :: M.Map Int (M.Map Int (TVar [Int])),
  stuff :: M.Map Int (TVar Thing) }

whereIs world id = thingy $ M.lookup id world
  where
    thingy t = t >>= return.readTVar >>= return . \x -> x >>= \t' -> return (xLoc t', yLoc t')
