module Problema1 where

import Cp 
import Nat  
import Numeric
import Test.QuickCheck hiding ((><))


soma :: (Num a) => (a, a) -> a
soma (x,y) = x + y

multiplica :: (Num a) => (a, a) -> a
multiplica (x,y) = x * y 

inv x = for(split (multiplica . (id >< const(1 - x))) soma) (1-x,1)
retorna x = p2.(inv x)

tiraNumero :: Gen Float
tiraNumero = choose(1,2)

arrDec :: Float -> Int -> Float
arrDec x n = (fromIntegral (floor (x * (10^n)))) / (10^n)

verifica = do{
	x <- tiraNumero;
	return (arrDec (1/x) 2 == arrDec (retorna x 10000) 2)
}
