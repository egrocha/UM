module Testar where

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

envia = unsafePerformIO

getR :: [a] -> IO (a,[a])
getR x = do { 
  i <- getStdRandom (randomR (0, length x-1));
  return (x !! i, retira i x )
  } where retira i x = take i x ++ drop (i + 1) x

permuta :: [a] -> [a]
permuta x = fst (envia (getR x)) : (permuta (snd (envia (getR x)))) 