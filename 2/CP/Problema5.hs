module Problema5 where 

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

type Equipa = String

equipas :: [Equipa]
equipas = ["Arouca","Belenenses","Benfica","Braga","Chaves","Feirense","Guimaraes","Maritimo","Moreirense","Nacional","P.Ferreira","Porto","Rio Ave","Setubal","Sporting","Estoril"]

pap :: Eq a => [(a, t)] -> a -> t
pap m k = unJust (lookup k m) where unJust (Just a) = a

jogo :: (Equipa, Equipa) -> Dist Equipa
jogo (e1 , e2) = D [(e1 , 1 - r1 / (r1 + r2 )), (e2 , 1 - r2 / (r1 + r2 ))] where
    r1 = rank e1
    r2 = rank e2
    rank = pap ranks
    ranks = [
        ("Arouca", 5),
        ("Belenenses", 3),
        ("Benfica", 1),
        ("Braga", 2),
        ("Chaves", 5),
        ("Feirense", 5),
        ("Guimaraes", 2),
        ("Maritimo", 3),
        ("Moreirense", 4),
        ("Nacional", 3),
        ("P.Ferreira", 3),
        ("Porto", 1),
        ("Rio Ave", 4),
        ("Setubal", 4),
        ("Sporting", 1),
        ("Estoril", 5)]

{-
permuta :: [a] -> [a]
permuta [] = []
permuta x = a : (permuta b)
    where
        (a,b) = envia (getR x)
-}

permutaAux :: [a] -> IO [a]
permutaAux [] = return []
permutaAux x = do {(a,b) <- getR x; x <- permutaAux b; return(a:x)}

envia = unsafePerformIO

getR :: [a] -> IO (a,[a])
getR x = do { 
  i <- getStdRandom (randomR (0,length x-1));
  return (x!!i, retira i x)
  } where retira i x = (take i x) ++ (drop (i+1) x)

flatten :: LTree Equipa -> [Equipa]
flatten (Leaf a) = [a]
flatten (Fork (x,y)) = (flatten x) ++ (flatten y)

sorteio :: [Equipa] -> LTree Equipa
sorteio = anaLTree lsplit . envia . permutaAux


eliminatoria :: LTree Equipa -> Dist Equipa
eliminatoria tree = do{ 
x <- D [
(e1, ((probEquipa1(jogo(e1,e2))) * ((probEquipa1(jogo(e1,e3))) + (probEquipa1(jogo(e1,e4)))) * ((probEquipa1(jogo(e1,e5))) + (probEquipa1(jogo(e1,e6))) + (probEquipa1(jogo(e1,e7))) + (probEquipa1(jogo(e1,e8)))) * ((probEquipa1(jogo(e1,e9))) + (probEquipa1(jogo(e1,e10))) + (probEquipa1(jogo(e1,e11))) + (probEquipa1(jogo(e1,e12)))) * ((probEquipa1(jogo(e1,e13))) + (probEquipa1(jogo(e1,e14))) + (probEquipa1(jogo(e1,e15))) + (probEquipa1(jogo(e1,e16)))))/ 100),
(e2, ((probEquipa1(jogo(e2,e1))) * ((probEquipa1(jogo(e2,e3))) + (probEquipa1(jogo(e2,e4)))) * ((probEquipa1(jogo(e2,e5))) + (probEquipa1(jogo(e2,e6))) + (probEquipa1(jogo(e2,e7))) + (probEquipa1(jogo(e2,e8)))) * ((probEquipa1(jogo(e2,e9))) + (probEquipa1(jogo(e2,e10))) + (probEquipa1(jogo(e2,e11))) + (probEquipa1(jogo(e2,e12)))) * ((probEquipa1(jogo(e2,e13))) + (probEquipa1(jogo(e2,e14))) + (probEquipa1(jogo(e2,e15))) + (probEquipa1(jogo(e2,e16)))))/ 100),
(e3, ((probEquipa1(jogo(e3,e4))) * ((probEquipa1(jogo(e3,e1))) + (probEquipa1(jogo(e3,e2)))) * ((probEquipa1(jogo(e3,e5))) + (probEquipa1(jogo(e3,e6))) + (probEquipa1(jogo(e3,e7))) + (probEquipa1(jogo(e3,e8)))) * ((probEquipa1(jogo(e3,e9))) + (probEquipa1(jogo(e3,e10))) + (probEquipa1(jogo(e3,e11))) + (probEquipa1(jogo(e3,e12)))) * ((probEquipa1(jogo(e3,e13))) + (probEquipa1(jogo(e3,e14))) + (probEquipa1(jogo(e3,e15))) + (probEquipa1(jogo(e3,e16)))))/ 100),
(e4, ((probEquipa1(jogo(e4,e3))) * ((probEquipa1(jogo(e4,e1))) + (probEquipa1(jogo(e4,e2)))) * ((probEquipa1(jogo(e4,e5))) + (probEquipa1(jogo(e4,e6))) + (probEquipa1(jogo(e4,e7))) + (probEquipa1(jogo(e4,e8)))) * ((probEquipa1(jogo(e4,e9))) + (probEquipa1(jogo(e4,e10))) + (probEquipa1(jogo(e4,e11))) + (probEquipa1(jogo(e4,e12)))) * ((probEquipa1(jogo(e4,e13))) + (probEquipa1(jogo(e4,e14))) + (probEquipa1(jogo(e4,e15))) + (probEquipa1(jogo(e4,e16)))))/ 100),
(e5, ((probEquipa1(jogo(e5,e6))) * ((probEquipa1(jogo(e5,e7))) + (probEquipa1(jogo(e5,e8)))) * ((probEquipa1(jogo(e5,e1))) + (probEquipa1(jogo(e5,e2))) + (probEquipa1(jogo(e5,e3))) + (probEquipa1(jogo(e5,e4)))) * ((probEquipa1(jogo(e5,e9))) + (probEquipa1(jogo(e5,e10))) + (probEquipa1(jogo(e5,e11))) + (probEquipa1(jogo(e5,e12)))) * ((probEquipa1(jogo(e5,e13))) + (probEquipa1(jogo(e5,e14))) + (probEquipa1(jogo(e5,e15))) + (probEquipa1(jogo(e5,e16)))))/ 100),
(e6, ((probEquipa1(jogo(e6,e5))) * ((probEquipa1(jogo(e6,e7))) + (probEquipa1(jogo(e6,e8)))) * ((probEquipa1(jogo(e6,e1))) + (probEquipa1(jogo(e6,e2))) + (probEquipa1(jogo(e6,e3))) + (probEquipa1(jogo(e6,e4)))) * ((probEquipa1(jogo(e6,e9))) + (probEquipa1(jogo(e6,e10))) + (probEquipa1(jogo(e6,e11))) + (probEquipa1(jogo(e6,e12)))) * ((probEquipa1(jogo(e6,e13))) + (probEquipa1(jogo(e6,e14))) + (probEquipa1(jogo(e6,e15))) + (probEquipa1(jogo(e6,e16)))))/ 100),
(e7, ((probEquipa1(jogo(e7,e8))) * ((probEquipa1(jogo(e7,e5))) + (probEquipa1(jogo(e7,e6)))) * ((probEquipa1(jogo(e7,e1))) + (probEquipa1(jogo(e7,e2))) + (probEquipa1(jogo(e7,e3))) + (probEquipa1(jogo(e7,e4)))) * ((probEquipa1(jogo(e7,e9))) + (probEquipa1(jogo(e7,e10))) + (probEquipa1(jogo(e7,e11))) + (probEquipa1(jogo(e7,e12)))) * ((probEquipa1(jogo(e7,e13))) + (probEquipa1(jogo(e7,e14))) + (probEquipa1(jogo(e7,e15))) + (probEquipa1(jogo(e7,e16)))))/ 100),
(e8, ((probEquipa1(jogo(e8,e7))) * ((probEquipa1(jogo(e8,e5))) + (probEquipa1(jogo(e8,e6)))) * ((probEquipa1(jogo(e8,e1))) + (probEquipa1(jogo(e8,e2))) + (probEquipa1(jogo(e8,e3))) + (probEquipa1(jogo(e8,e4)))) * ((probEquipa1(jogo(e8,e9))) + (probEquipa1(jogo(e8,e10))) + (probEquipa1(jogo(e8,e11))) + (probEquipa1(jogo(e8,e12)))) * ((probEquipa1(jogo(e8,e13))) + (probEquipa1(jogo(e8,e14))) + (probEquipa1(jogo(e8,e15))) + (probEquipa1(jogo(e8,e16)))))/ 100),
(e9, ((probEquipa1(jogo(e9,e10))) * ((probEquipa1(jogo(e9,e11))) + (probEquipa1(jogo(e9,e12)))) * ((probEquipa1(jogo(e9,e13))) + (probEquipa1(jogo(e9,e14))) + (probEquipa1(jogo(e9,e15))) + (probEquipa1(jogo(e9,e16)))) * ((probEquipa1(jogo(e9,e1))) + (probEquipa1(jogo(e9,e2))) + (probEquipa1(jogo(e9,e3))) + (probEquipa1(jogo(e9,e4)))) * ((probEquipa1(jogo(e9,e5))) + (probEquipa1(jogo(e9,e6))) + (probEquipa1(jogo(e9,e7))) + (probEquipa1(jogo(e9,e8)))))/ 100),
(e10, ((probEquipa1(jogo(e10,e9))) * ((probEquipa1(jogo(e10,e11))) + (probEquipa1(jogo(e10,e12)))) * ((probEquipa1(jogo(e10,e13))) + (probEquipa1(jogo(e10,e14))) + (probEquipa1(jogo(e10,e15))) + (probEquipa1(jogo(e10,e16)))) * ((probEquipa1(jogo(e10,e1))) + (probEquipa1(jogo(e10,e2))) + (probEquipa1(jogo(e10,e3))) + (probEquipa1(jogo(e10,e4)))) * ((probEquipa1(jogo(e10,e5))) + (probEquipa1(jogo(e10,e6))) + (probEquipa1(jogo(e10,e7))) + (probEquipa1(jogo(e10,e8)))))/ 100),
(e11, ((probEquipa1(jogo(e11,e12))) * ((probEquipa1(jogo(e11,e9))) + (probEquipa1(jogo(e11,e10)))) * ((probEquipa1(jogo(e11,e13))) + (probEquipa1(jogo(e11,e14))) + (probEquipa1(jogo(e11,e15))) + (probEquipa1(jogo(e11,e16)))) * ((probEquipa1(jogo(e11,e1))) + (probEquipa1(jogo(e11,e2))) + (probEquipa1(jogo(e11,e3))) + (probEquipa1(jogo(e11,e4)))) * ((probEquipa1(jogo(e11,e5))) + (probEquipa1(jogo(e11,e6))) + (probEquipa1(jogo(e11,e7))) + (probEquipa1(jogo(e11,e8)))))/ 100),
(e12, ((probEquipa1(jogo(e12,e11))) * ((probEquipa1(jogo(e12,e9))) + (probEquipa1(jogo(e12,e10)))) * ((probEquipa1(jogo(e12,e13))) + (probEquipa1(jogo(e12,e14))) + (probEquipa1(jogo(e12,e15))) + (probEquipa1(jogo(e12,e16)))) * ((probEquipa1(jogo(e12,e1))) + (probEquipa1(jogo(e12,e2))) + (probEquipa1(jogo(e12,e3))) + (probEquipa1(jogo(e12,e4)))) * ((probEquipa1(jogo(e12,e5))) + (probEquipa1(jogo(e12,e6))) + (probEquipa1(jogo(e12,e7))) + (probEquipa1(jogo(e12,e8)))))/ 100),
(e13, ((probEquipa1(jogo(e13,e14))) * ((probEquipa1(jogo(e13,e15))) + (probEquipa1(jogo(e13,e16)))) * ((probEquipa1(jogo(e13,e9))) + (probEquipa1(jogo(e13,e10))) + (probEquipa1(jogo(e13,e11))) + (probEquipa1(jogo(e13,e12)))) * ((probEquipa1(jogo(e13,e1))) + (probEquipa1(jogo(e13,e2))) + (probEquipa1(jogo(e13,e3))) + (probEquipa1(jogo(e13,e4)))) * ((probEquipa1(jogo(e13,e5))) + (probEquipa1(jogo(e13,e6))) + (probEquipa1(jogo(e13,e7))) + (probEquipa1(jogo(e13,e8)))))/ 100),
(e14, ((probEquipa1(jogo(e14,e13))) * ((probEquipa1(jogo(e14,e15))) + (probEquipa1(jogo(e14,e16)))) * ((probEquipa1(jogo(e14,e9))) + (probEquipa1(jogo(e14,e10))) + (probEquipa1(jogo(e14,e11))) + (probEquipa1(jogo(e14,e12)))) * ((probEquipa1(jogo(e14,e1))) + (probEquipa1(jogo(e14,e2))) + (probEquipa1(jogo(e14,e3))) + (probEquipa1(jogo(e14,e4)))) * ((probEquipa1(jogo(e14,e5))) + (probEquipa1(jogo(e14,e6))) + (probEquipa1(jogo(e14,e7))) + (probEquipa1(jogo(e14,e8)))))/ 100),
(e15, ((probEquipa1(jogo(e15,e16))) * ((probEquipa1(jogo(e15,e13))) + (probEquipa1(jogo(e15,e14)))) * ((probEquipa1(jogo(e15,e9))) + (probEquipa1(jogo(e15,e10))) + (probEquipa1(jogo(e15,e11))) + (probEquipa1(jogo(e15,e12)))) * ((probEquipa1(jogo(e15,e1))) + (probEquipa1(jogo(e15,e2))) + (probEquipa1(jogo(e15,e3))) + (probEquipa1(jogo(e15,e4)))) * ((probEquipa1(jogo(e15,e5))) + (probEquipa1(jogo(e15,e6))) + (probEquipa1(jogo(e15,e7))) + (probEquipa1(jogo(e15,e8)))))/ 100),
(e16, ((probEquipa1(jogo(e16,e15))) * ((probEquipa1(jogo(e16,e13))) + (probEquipa1(jogo(e16,e14)))) * ((probEquipa1(jogo(e16,e9))) + (probEquipa1(jogo(e16,e10))) + (probEquipa1(jogo(e16,e11))) + (probEquipa1(jogo(e16,e12)))) * ((probEquipa1(jogo(e16,e1))) + (probEquipa1(jogo(e16,e2))) + (probEquipa1(jogo(e16,e3))) + (probEquipa1(jogo(e16,e4)))) * ((probEquipa1(jogo(e16,e5))) + (probEquipa1(jogo(e16,e6))) + (probEquipa1(jogo(e16,e7))) + (probEquipa1(jogo(e16,e8)))))/ 100)];
return x}
    where
        (e1:e2:e3:e4:e5:e6:e7:e8:e9:e10:e11:e12:e13:e14:e15:e16:ys) = flatten tree


probEquipa1 :: Dist Equipa -> Float
probEquipa1 (D ((x,y):ys)) = y 

--probEquipa2 :: Dist Equipa -> Float
--probEquipa2 (D ((x,y):ys)) = probEquipa1 (D ys)

quemVence :: [Equipa] -> Dist Equipa
quemVence = eliminatoria . sorteio