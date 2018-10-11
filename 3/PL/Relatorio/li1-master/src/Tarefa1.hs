{-| 
Module : Tarefa1
Description : Módulo Haskell contendo a Tarefa 1.
Copyright : Eduardo Rocha <a77048@alunos.uminho.pt>;
            André Filipe Ferreira de Mira Vieira <a78322@alunos.uminho.pt>;
Um módulo contendo definições Haskell para a geração de um mapa de Bomberman.
-}

module Main where 

import System.Environment
import System.Random
import Text.Read
import Data.Maybe
import Data.Char

{-| A função mapa, após verificar se os dados fornecidos são validos, chama as funções addTijolos, addBombas
e addFlames para criar o mapa.  
-}

mapa :: Int -> Int -> [String]
mapa l s | (mod l 2 /= 0) && (l > 5) = mapaAux l (addTijolos (mapaVazio l l) (powerUps l s) l 1) (powerUps l s)
         | otherwise = []
         
{-| A função mapaAux é chamada pela função mapa, e é utilizada para simplificar o trabalho feito pela 
mapa. Guarda os valores de addTijolos, addBombas e addFlames em variáveis para reduzir o espaço ocupado 
pelo código. Esta função gera a versão final do mapa, que será dado como output.
-}

mapaAux :: Int -> [String] -> [Int] -> [String] 
mapaAux l m p = m ++ addBombas m p 0 l ++ addFlames m p 0 l

{-| Função main fornecida no enunciado, que chamará a função mapa para poder produzir o mapa de Bomberman.
-}

main :: IO ()
main = do a <- getArgs
          let s = readMaybe (a !! 0)
          let l = readMaybe (a !! 1)
          if length a == 2 && isJust s && isJust l && fromJust s >= 5 && odd (fromJust s)
             then putStr $ unlines $ mapa (fromJust s) (fromJust l)
             else putStrLn "Parâmetros inválidos"

{-| A addTijolos é chamada pela mapa e, com o mapa gerado pela função mapaVazio (função que gera uma versão
do mapa contendo apenas pedras e espaços) e com a lista de números gerados pela powerUps (função que gera
a lista de números que serão distribuídos pelo mapa como tijolos/power ups) irá substituir os espaços no
mapa por tijolos, onde adequado.
-}

addTijolos :: [String] -> [Int] -> Int -> Int -> [String] 
addTijolos [] _ _ _ = [] 
addTijolos (a:b) [] _ _ = (a:b)
addTijolos (a:b) (h:t) l i | i == 1 || i == l = a : addTijolos b (h:t) l (i+1) 
                           | i == 2 || i == (l-1) = (auxT1 a (h:t) 1 l) : addTijolos b (snd(splitAt(l-6) (h:t))) l (i+1) 
                           | i == 3 || i == (l-2) = (auxT1 a (h:t) 1 l) : addTijolos b (snd(splitAt((numEsp a 0)-2) (h:t))) l (i+1)
                           | i > 3 && i < (l-2) = (auxT2 a (h:t)) : addTijolos b (snd(splitAt (numEsp a 0) (h:t))) l (i+1)
                           | otherwise = (a:b)

{-| A auxT1 é chamada pela addTijolos e serve para substituir os espaços por tijolos nas linhas do mapa 
onde se tem que preservar os cantos, ou seja, a primeira, segunda, penúltima e última linhas do mapa
(não contando as paredes horizontais).
-}

auxT1 :: String -> [Int] -> Int -> Int -> String 
auxT1 [] _ _ _ = []
auxT1 (a:b) [] _ _ = (a:b)
auxT1 (a:b) (h:t) x l | x <= 3 ||x >= (l-2) || a == '#' = a : auxT1 b (h:t) (x+1) l
                      | (x > 3 && x < (l-2)) && a == ' ' = if (h >= 0 && h < 40) then '?' : auxT1 b t (x+1) l 
                                                                                 else a : auxT1 b t (x+1) l

{-| A auxT2, tal como a auxT1, é chamada pela addTijolos para substituir espaços, excepto que a auxT2 
é encarregada de substituir espaços em linhas onde não hajam cantos para preservar.
-}

auxT2 :: String -> [Int] -> String 
auxT2 [] _ = []
auxT2 (a:b) [] = (a:b)
auxT2 (a:b) (h:t) | a == '#' = a : auxT2 b (h:t) 
                  | a == ' ' && (h >= 0 && h < 40) = '?' : auxT2 b t 
                  | a == ' ' && h >= 40 = a : auxT2 b t 

{-| A numEsp é chamada pela addTijolos, addBombas e addFlames, e conta o número de espaços ou tijolos 
contidos numa linha do mapa que não contenha cantos.
3
-}

numEsp :: String -> Int -> Int 
numEsp [] i = i
numEsp (h:t) i | h == '#' = numEsp t i  
               | h == ' ' || h == '?' = numEsp t (i+1)
               | otherwise = numEsp t i

{-| A addBombas é chamada na mapaAux e é usada para criar uma lista de strings das posições de power ups 
bombas no mapa modificado gerado pela função addTijolos.
-}

addBombas :: [String] -> [Int] -> Int -> Int -> [String]
addBombas [] _ _ _ = []
addBombas _ [] _ _ = []
addBombas (a:b) (h:t) i l | i == 0 || i == (l-1) = addBombas b (h:t) (i+1) l
                          | i == 1 || i == (l-2) = auxB1 a (h:t) 0 i l ++ (addBombas b (snd(splitAt (l-6) (h:t))) (i+1) l)
                          | i == 2 || i == (l-3) = auxB1 a (h:t) 0 i l ++ (addBombas b (snd(splitAt((numEsp a 0)-2) (h:t))) (i+1) l)
                          | otherwise = auxB2 a (h:t) 0 i l ++ (addBombas b (snd(splitAt (numEsp a 0) (h:t))) (i+1) l) 

{-| A auxB1 é uma função auxiliar utilizada na addBombas para criar linhas com a descrição da existência
de bombas na primeira, segunda, penúltima e última linhas do mapa (não contanto com as paredes horizontais),
tendo então em consideração os cantos do mapa, em que não poderão haver power ups.
-}

auxB1 :: String -> [Int] -> Int -> Int -> Int -> [String] 
auxB1 [] _ _ _ _ = []
auxB1 _ [] _ _ _ = []
auxB1 (a:b) (h:t) x y l | x<=2 || x>=(l-2) || a=='#' = auxB1 b (h:t) (x+1) y l
                        | a == '?' && (h == 0 || h == 1) = ("+ " ++ show x ++ " " ++ show y) : auxB1 b t (x+1) y l 
                        | otherwise =  auxB1 b t (x+1) y l 
 
{-| A auxB2 é identica à função auxB1, sendo também chamada pela addBombas, com a excepção que não considera
os contas que é necessário preservar no mapa, ou seja, é utilizada para descrever bombas presentes no
mapa entre a terceira e antepenúltimas linhas do mapa (não contando com as paredes horizontais), inclusive.
-}

auxB2 :: String -> [Int] -> Int -> Int -> Int -> [String] 
auxB2 [] _ _ _ _ = []
auxB2 _ [] _ _ _ = []
auxB2 (a:b) (h:t) x y l | a == '#' = auxB2 b (h:t) (x+1) y l
                        | a == ' ' = auxB2 b t (x+1) y l
                        | a == '?' && (h == 0 || h == 1) = ("+ " ++ show x ++ " " ++ show y) : auxB2 b t (x+1) y l
                        | a == '?' && (h /= 0 || h /= 1) = auxB2 b t (x+1) y l

{-| A função addFlames é chamada pela addTijolos, e tal como a addBombas, é utilizada para adicionar
linhas ao final do mapa, nas quais são descritas as posições de todos os power ups da categoria Flames.
Para tal, utiliza as mesmas técnicas que a função addBombas, incluindo a utilizão de duas funções 
auxiliares.
-}

addFlames :: [String] -> [Int] -> Int -> Int -> [String]
addFlames [] _ _ _ = []
addFlames _ [] _ _ = []
addFlames (a:b) (h:t) i l | i == 0 || i == (l-1) = addFlames b (h:t) (i+1) l
                          | i == 1 || i == (l-2) = auxF1 a (h:t) 0 i l ++ (addFlames b (snd(splitAt (l-6) (h:t))) (i+1) l)
                          | i == 2 || i == (l-3) = auxF1 a (h:t) 0 i l ++ (addFlames b (snd(splitAt((numEsp a 0)-2) (h:t))) (i+1) l)
                          | otherwise = auxF2 a (h:t) 0 i l ++ (addFlames b (snd(splitAt (numEsp a 0) (h:t))) (i+1) l) 
  
{-| A auxF1 é a primeira auxiliar chamada pela addFlames, na qual são criadas as descrições de localizações
de power ups da categoria Flames na primeira, segunda, penúltima e última linhas do mapa (não contando
com as paredes horizontais).
-}

auxF1 :: String -> [Int] -> Int -> Int -> Int -> [String] 
auxF1 [] _ _ _ _ = []
auxF1 _ [] _ _ _ = []
auxF1 (a:b) (h:t) x y l | x<=2 || x>=(l-2) || a=='#' = auxF1 b (h:t) (x+1) y l
                        | a == '?' && (h == 2 || h == 3) = ("! " ++ show x ++ " " ++ show y) : auxF1 b t (x+1) y l 
                        | otherwise =  auxF1 b t (x+1) y l 

{-| A auxF2 é a segunda auxiliar utilizada na addFlames, na qual são geradas as posições dos power ups 
Flames nas linhas do mapa entre a terceira e antepenúltima linhas do mapa (não contando com as paredes
horizontais), inclusive.
-}
 
auxF2 :: String -> [Int] -> Int -> Int -> Int -> [String] 
auxF2 [] _ _ _ _ = []
auxF2 _ [] _ _ _ = []
auxF2 (a:b) (h:t) x y l | a == '#' = auxF2 b (h:t) (x+1) y l
                        | a == '?' && (h == 2 || h == 3) = ("! " ++ show x ++ " " ++ show y) : auxF2 b t (x+1) y l
                        | otherwise = auxF2 b t (x+1) y l

{-| A mapaVazio é uma função chamada pela addTijolos, na qual é gerado um mapa de Bomberman vazio, ou seja,
contem exclusivamente espaços e pedras, não contendo então power ups e/ou tijolos.
A mapaVazio utiliza três funções auxiliares para gerar os três tipos de linhas presentes no mapa.
-}

mapaVazio :: Int -> Int -> [String]
mapaVazio 0 _ = []
mapaVazio i l | i == 1 || i == l = linhaPU l : (mapaVazio (i-1) l) 
              | mod i 2 == 0 || i == (l-1) = linhaMP l l : (mapaVazio (i-1) l) 
              | mod i 2 /= 0 || i == (l-2) = linhaMI l l : (mapaVazio (i-1) l) 

{-| A função linhaPU é utilizada na mapaVazio para gerar a primeira e última linha do mapa.   
-}

linhaPU :: Int -> String
linhaPU 0 = []
linhaPU l | l > 0 = '#' : (linhaPU (l-1))

{-| A linhaMP é chamada pela mapaVazio para gerar as linhas do mapa em que não existem pedras a meio.
-}

linhaMP :: Int -> Int -> String 
linhaMP 0 _ = [] 
linhaMP i l | i == 1 || i == l = '#' : (linhaMP (i-1) l)
            | otherwise = ' ' : (linhaMP (i-1) l)

{-| A linhaMI é chamada pela mapaVazio para gerar as linhas do mapa em que existem pedras a meio.
-}

linhaMI :: Int -> Int -> String 
linhaMI 0 _ = []
linhaMI i l | i == 1 || i == l || mod i 2 /= 0 = '#' : (linhaMI (i-1) l)
		      	| otherwise = ' ' : (linhaMI (i-1) l)

{-| A função powerUps é chamada pela mapa e pela addTijolos para gerar a lista de números que, quando
comparados com o mapa criado pela addTijolos, irão decidir onde estarão os tijolos, e em quais desses 
tijolos estarão escondidos power ups.
-}

powerUps :: Int -> Int -> [Int]
powerUps l s = take (numPowerUps l) $ randomRs (0,99) (mkStdGen s)

{-| A numPowerUps é utilizada pela powerUps para decidir quantos números a função powerUps precisará
de gerar.
-}

numPowerUps :: Int -> Int 
numPowerUps x = x^2-4*x-8-(div (x-2) 2)^2