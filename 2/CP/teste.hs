module Problema1 where

import Cp
import Nat

soma :: (Num a) => (a, a) -> a
soma (x,y) = x + y

multiplica :: (Num a) => (a, a) -> a
multiplica (x,y) = x * y 


inv x = for (split (multiplica . (id >< const(1 - x))) soma) (1-x,1)