module Problema4 where

import Cp 
import List 
import Nat  
import Test.QuickCheck hiding ((><))


type Algae = A
data A = NA | A A B deriving Show
data B = NB | B A deriving Show
type Null   = ()
type Prod a b = (a,b)


inA :: Either Null (Prod A B) -> A
inA = either (const NA)(uncurry A)

outA :: A -> Either Null (Prod A B)
outA NA = Left ()
outA (A a b) = Right (a,b)

inB :: Either Null A -> B
inB = either (const NB) B

outB :: B -> Either Null A
outB NB = Left ()
outB (B a) = Right a

anaA ga gb = inA . (id -|- (anaA ga gb >< anaB ga gb )) . ga

anaB ga gb  = inB . (id -|- anaA ga gb) . gb

cataA :: (Either Null (Prod c d) -> c) -> (Either Null c -> d) -> A -> c
cataA ga gb = ga . (id -|- cataA ga gb >< cataB ga gb) . outA

cataB :: (Either Null (Prod c d) -> c) -> (Either Null c -> d) -> B -> d
cataB ga gb = gb . (id -|- cataA ga gb) . outB

genA :: Int -> Either () (Int, Int)
genA 0 = Left ()
genA x = Right (x-1,x-1)  

genB :: Int -> Either () Int
genB 0 = Left ()
genB x = outNat x

generateAlgae :: Int -> Algae
generateAlgae =  anaA genA genB

showA :: Either () (String,String) -> String
showA (Left ()) = "A"
showA (Right (x,y)) = x ++ y

showB :: Either () (String) -> String
showB (Left ()) = "B"
showB (Right x) = x

showAlgae :: Algae -> String
showAlgae = cataA showA showB

newFib :: Int -> Int
newFib 0 = 1
newFib 1 = 1
newFib x = newFib (x-1) + newFib (x-2)

tiraNumero :: Gen Int
tiraNumero = choose(0,20) 

verifica :: Gen Bool
verifica = do {
    z <- tiraNumero;
    return((length (showAlgae (generateAlgae z))) == (newFib (succ z)))
}