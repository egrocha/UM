module Problema3 where

import Cp 
import List 
import Nat  
import Exp 
import BTree  
import LTree  
import St 
import Probability hiding (cond) 
import Data.List
import Test.QuickCheck hiding ((><))
import System.Random  hiding (split)
import GHC.IO.Exception
import System.IO.Unsafe

data B_tree a = Nil | Block {leftmost :: B_tree a, block :: [(a, B_tree a)]}  deriving (Show, Eq)

t1 = Block{
    leftmost = Block{
        leftmost = Nil,
        block = [(1, Nil), (2, Nil), (5, Nil), (6, Nil)]},
    block = [
        (7, Block{
            leftmost = Nil,
            block = [(9, Nil), (12, Nil)]}),
        (16, Block{
            leftmost = Nil,
            block = [(18, Nil), (21, Nil)]})
    ]}

-- 1.

inB_tree = either (const Nil) (uncurry Block)

outB_tree Nil = i1 ()
outB_tree (Block x y) = i2 (x,y)

baseB_tree x y = id -|- (x >< map (y >< x))

recB_tree x = baseB_tree x id

cataB_tree x = x . (recB_tree (cataB_tree x)) . outB_tree

anaB_tree x = inB_tree . (recB_tree (anaB_tree x) ) . x

hyloB_tree x y = cataB_tree x . anaB_tree y 

instance Functor B_tree
         where fmap f = cataB_tree ( inB_tree . baseB_tree id f )

-- 2.
inordB_tree :: B_tree t -> [t]
inordB_tree Nil = []
inordB_tree (Block x y) = cataB_tree inordB_tree

-- 3.

--largestBlock :: B_tree a -> Int

-- 4.

--mirrorB_tree :: B_tree a -> B_tree a

-- 5.

lsplitB tree []= i1 ()
lsplitB tree [7] = i2 ([], [(7, [])])
lsplitB tree [5, 7, 1, 9] = i2 ([1], [(5, []), (7, [9])])
lsplitB tree [7, 5, 1, 9] = i2 ([1], [(5, []), (7, [9])])

-- 6.

dotBTree :: Show a => BTree a -> IO ExitCode
dotBTree = dotpict . bmap nothing (Just . show) . cBTree2Exp

t2 = Node (6,(Node (3,(Node (2,(Empty,Empty)),Empty)), Node (7,(Empty, Node (9,(Empty,Empty))))))