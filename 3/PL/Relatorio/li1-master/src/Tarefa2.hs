{-| 
Module : Tarefa2
Description : Módulo Haskell contendo a Tarefa 2.
Copyright : Eduardo Rocha <a77048@alunos.uminho.pt>;
            André Filipe Ferreira de Mira Vieira <a78322@alunos.uminho.pt>;
Um módulo contendo definições Haskell para a execução de um comando num jogo de Bomberman.
-}

module Main where

import Data.Char (isDigit)
import System.Environment
    
{-| A função move, após verificar que os comandos fornecidos são válidos, executa a função fazJogada, que
irá fazer as modificações necessários ao tabuleiro de jogo.
-}

move :: [String] -> Int -> Char -> [String]
move t a c | a>=0 && a<=3 && (c == 'U' || c == 'D' || c == 'L' || c == 'R' || c == 'B') = fazJogada t a c
			     | otherwise = t

{-| Função main fornecida no enunciado, que chamará a função move para realizar uma acção num jogo
de Bomberman.
-}

main :: IO ()
main = do a <- getArgs
          let p = a !! 0
          let c = a !! 1
          w <- getContents
          if length a == 2 && length p == 1 && isDigit (head p) && length c == 1 && head c `elem` "UDLRB"
             then putStr $ unlines $ move (lines w) (read p) (head c)
             else putStrLn "Parâmetros inválidos"

{-| A função fazJogada é chamada pela move, com o tabuleiro de jogo, o número do jogador a realizar uma 
acção e o tipo de acção que o jogador pretende realizar.
A função utiliza o verificaJogador para determinar se a jogada se pode realizar, após a qual irá usar
a checkRep e a insereJogada para produzir o output necessário.
-}

fazJogada :: [String] -> Int -> Char -> [String] 
fazJogada t a c | (verificaJogador t a) = checkRep(insereJogada t a (gereJogada t a c (obtemVals (reverse t) a 0 0 "")))
                | otherwise = t

{-| A verificaJogador é usada para verificar se o jogador indicado na chamada da função main/move existe
no tabuleiro jogo. Nesse caso, devolverá True; se o jogador não estiver presente devolverá False.
-}

verificaJogador :: [String] -> Int -> Bool 
verificaJogador ((x:y):t) a | [x] == show a = True 
                            | [x] /= show a = verificaJogador t a
                            | otherwise = False

{-| A função checkRep é chamada pela fazJogada para verificar o mapa gerado pelo insereJogada para verificar
se numa coordenada existem várias coisas que não podem coexistir. Por exemplo, se um jogador se encontrar
nas coordenadas (3,3) e um power up Bombas também existir nessas coordenadas, a checkRep removeria a linha 
"+ 3 3", que é correspondente ao power up.
-}

checkRep :: [String] -> [String] 
checkRep [] = []
checkRep (h:t) | head h /= '+' && head h /= '!' && head h /= '*' = h : checkRep t
               | head h == '+' && (repPU (h!!2,h!!4) t) = checkRep t 
               | head h == '!' && (repPU (h!!2,h!!4) t) = checkRep t 
               | head h == '*' && (repB (h!!2,h!!4) t) = checkRep t  
               | otherwise = h : checkRep t

{-| A repPU é chamada como auxiliar na checkRep para remover power ups presentes nas mesmas coordenadas 
que jogadores.
-}

repPU :: (Char,Char) -> [String] -> Bool
repPU _ [] = False
repPU (x,y) (h:t) | x == h !! 2 && y == h !! 4 = True 
                  | otherwise = repPU (x,y) t  

{-| A repB é usada como auxiliar na checkRep para remover bombas presentes nas mesmas coordenadas.
-}

repB :: (Char,Char) -> [String] -> Bool
repB _ [] = False
repB (x,y) (h:t) | x == h !! 2 && y == h !! 4 && head h == '*' = True 
                 | otherwise = repB (x,y) t  

{-| A função insereJogada recebe a jogada produzida pela função gereJogada e decide onde será inserida
a jogado dependendo do tipo de jogada que é.
-}

insereJogada :: [String] -> Int -> String -> [String] 
insereJogada t a j | head j == '*' = insereBomba t j  
                   | otherwise = insereUDLR t a j

{-| A insereBomba é chamada pela insereJogada caso a jogada recebida começe com '*' (logo, seja uma bomba)
e decide em que posição do tabuleiro será posta a jogada (depois do mapa, depois dos power ups, mas antes
dos jogadores) decidindo também em que posição será posta comparativamente com as outras bombas.
-}

insereBomba :: [String] -> String -> [String]
insereBomba (n:m:t) j | head m == '#' || head m == '!' || head m == '+' = n : insereBomba (m:t) j 
                      | head m /= '*' && head m /= '!' && head m /= '+' = n : [j] ++ (m:t)  
                      | head m == '*'  && (compBomba (j!!2,j!!4) (m!!2,m!!4)) = n : [j] ++ (m:t) 
                      | head m == '*' && (not(compBomba(j!!2,j!!4) (m!!2,m!!4))) = n : insereBomba (m:t) j 
                      | otherwise = (n:m:t)

{-| A compBomba é chamada pela insereBomba para comparar duas descrições do tipo de bomba: uma que será
inserida no tabuleiro e outra já la presente, devolvendo True caso a que se pretende inserir estiver numa
posição anterior à já posta e False caso contrário.
-}

compBomba :: (Char,Char) -> (Char,Char) -> Bool
compBomba (x1,y1) (x2,y2) | y1 < y2 = True 
                          | y1 > y2 = False
                          | y1 == y2 && x1 < x2 = True
                          | y1 == y2 && x1 > x2 = False 
                          | otherwise = False 

{-| A insereUDLR é a alternativa à insereBomba, ou seja é realizada caso a jogada realizada não seja a
colocação de uma bomba. Esta função coloca a linha da jogada no sítio do mapa onde esteve a ultima jogada
desse mesmo jogador.
-}

insereUDLR :: [String] -> Int -> String -> [String]
insereUDLR [] _ _ = []
insereUDLR ((n:m):t) a j | [n] == show a = j : t 
                         | otherwise = (n:m) : insereUDLR t a j  

{-| A gereJogada é invocada pela função fazJogada para produzir a jogada. Para tal utiliza cinco funções 
para os diferentes tipos de jogadas. moveUp para 'U', moveDown para 'D', moveLeft para 'L', moveRight 
para 'R' e moveBomba para 'B'.
-}

gereJogada :: [String] -> Int -> Char -> (Int,Int,String) -> String
gereJogada t a c (x,y,s) | c == 'U' = moveUp t a (x,y,s) 0 0
                         | c == 'D' = moveDown t a (x,y,s) 0 0
                         | c == 'L' = moveLeft t a (x,y,s) 0 0
                         | c == 'R' = moveRight t a (x,y,s) 0 0
                         | c == 'B' = moveBomba t a (x,y)
                         | otherwise = [] 

{-| A moveUp é invocada pela gereJogada caso o tipo de jogada fornecida seja 'U'. Irá mudar as coordenadas
do jogador, caso possível, para que se encontre na linha em cima.
-}

moveUp :: [String] -> Int -> (Int,Int,String) -> Int -> Int -> String 
moveUp [] _ _ _ _ = [] 
moveUp ((n:m):t) a (x,y,s) x2 y2 | y2 < (y-1) = moveUp t a (x,y,s) x2 (y2+1) 
                                 | x2 < x = moveUp (m:t) a (x,y,s) (x2+1) y2
                                 | x2 == x && y2 == (y-1) = if n == ' ' then atualiza a (x2,y2,s) (checkPU t (x2,y2))
                                                                        else atualiza a (x,y,s) (checkPU t (x2,y2))

{-| A moveDown é invocada pela gereJogada caso o tipo de jogada fornecida seja 'D'. Irá mudar as coordenadas
do jogador, caso possível, para que se encontre na linha em baixo. 
-}

moveDown :: [String] -> Int -> (Int,Int,String) -> Int -> Int -> String 
moveDown [] _ _ _ _ = [] 
moveDown ((n:m):t) a (x,y,s) x2 y2 | y2 < (y+1) = moveDown t a (x,y,s) x2 (y2+1) 
                                   | x2 < x = moveDown (m:t) a (x,y,s) (x2+1) y2
                                   | x2 == x && y2 == (y+1) = if n == ' ' then atualiza a (x2,y2,s) (checkPU t (x2,y2))
                                                                          else atualiza a (x,y,s) (checkPU t (x2,y2))

{-| A moveLeft é invocada pela gereJogada caso o tipo de jogada fornecida seja 'L'. Irá mudar as coordenadas
do jogador, caso possível, para que se encontre na mesma linha, na posição anterior.
-}

moveLeft :: [String] -> Int -> (Int,Int,String) -> Int -> Int -> String 
moveLeft [] _ _ _ _ = [] 
moveLeft ((n:m):t) a (x,y,s) x2 y2 | y2 < y = moveLeft t a (x,y,s) x2 (y2+1) 
                                   | x2 < (x-1) = moveLeft (m:t) a (x,y,s) (x2+1) y2
                                   | x2 == (x-1) && y2 == y = if n == ' ' then atualiza a (x2,y2,s) (checkPU t (x2,y2))
                                                                          else atualiza a (x,y,s) (checkPU t (x2,y2))

{-|A moveRight é invocada pela gereJogada caso o tipo de jogada fornecida seja 'R'. Irá mudar as coordenadas
do jogador, caso possível, para que se encontre na linha em cima, na posição seguinte
-}

moveRight :: [String] -> Int -> (Int,Int,String) -> Int -> Int -> String 
moveRight [] _ _ _ _ = [] 
moveRight ((n:m):t) a (x,y,s) x2 y2 | y2 < y = moveRight t a (x,y,s) x2 (y2+1) 
                                    | x2 < (x+1) = moveRight (m:t) a (x,y,s) (x2+1) y2
                                    | x2 == (x+1) && y2 == y = if n == ' ' then atualiza a (x2,y2,s) (checkPU t (x2,y2))
                                                                           else atualiza a (x,y,s) (checkPU t (x2,y2))

{-| A função atualiza é invocada pelas funções move direcionais e utiliza os dados gerados por essas 
funções para criar a linha que será adicionada ao mapa.
-}

atualiza :: Int -> (Int,Int,String) -> Char -> String
atualiza a (x,y,s) c | c == '+' || c == '!' =  show a ++ [' '] ++ show x ++ [' '] ++ show y ++ [' '] ++ s ++ [c]  
                     | otherwise = show a ++ [' '] ++ show x ++ [' '] ++ show y ++ " " ++ s

{-| A função moveBomba é chamada pela gereJogada para gerar uma linha de jogo que contenhana a descrição
de uma bomba. Para verificar se a jogada é válida recorre à checkBomba.
-}

moveBomba :: [String] -> Int -> (Int,Int) -> String 
moveBomba t a (x,y) | (checkBomba t a) = []
                    | otherwise = addLB (x,y) a 1 10 

{-| A checkBomba é utilizada na moveBomba e serve para verificar se o jogador que pretende colocar a bomba
já colocou outra bomba no mapa. Caso tenha, devolverá True.
-}

checkBomba :: [String] -> Int -> Bool
checkBomba [] _ = False
checkBomba ((n:m):t) a | n /= '*' = checkBomba t a
                       | n == '*' && [(n:m) !! 6] == show a = True 
                       | otherwise = False

{-| A função addLB é chamada pela moveBomba caso não exista já uma bomba colocada no mapa pelo mesmo jogador
e criará a descrição da bomba que se pretende juntar ao mapa. Junta as coordenadas, o número do jogador,
o raio e o tempo numa string.
-}

addLB :: (Int,Int) -> Int -> Int -> Int -> String  
addLB (x,y) a r t = "* " ++ show x ++ " " ++ show y ++ " " ++ show a ++ " " ++ show r ++ " "  ++ show t

{-| A checkPU é utilizada pelas funções move direcionais para verificar qual power up é que o jogador
está a apanhar.
-}

checkPU :: [String] -> (Int,Int) -> Char 
checkPU [] _ = ' '
checkPU ((a:b):t) (x,y) | a == '#' = checkPU t (x,y) 
                        | a /= '#' && a /= '!' && a /= '+' = ' ' 
                        | a == '!' || a == '+' = if (rDados a b (x,y) 1 == '!') || (rDados a b (x,y) 1 == '+') then rDados a b (x,y) 1 
                                                 else checkPU t (x,y)  

{-| A rDados é utilizada pela checkPU para retirar o power up que existe nas coordenadas onde o jogador se
encontra. 
-}

rDados :: Char -> String -> (Int,Int) -> Int -> Char
rDados _ [] _ _ = ' '
rDados c (a:b) (x,y) l | a == ' ' = rDados c b (x,y) (l+1) 
                       | a /= ' ' && l == 2 && [a] == show x = rDados c b (x,y) (l+1) 
                       | a /= ' ' && l == 2 && [a] /= show x = ' '
                       | a /= ' ' && l == 4 && [a] == show y = c
                       | a /= ' ' && l == 4 && [a] /= show y = ' '
                       | otherwise = ' '

{-| A obtemVals é utilizada pela fazJogada para retirar as coordenadas necessárias da descrição do jogador
que se encontra a jogar, assim como a lista de power ups que esse jogador já apanhou em fases anteriores 
do jogo.
-}

obtemVals :: [String] -> Int -> Int -> Int -> String -> (Int,Int,String) 
obtemVals (h:t) a x y s | show a == [head(h)] = (obtemDX h x,obtemDY h y,obtemDS h s 1)  --obtemDados h a (x,y,s) (length h) 
                        | show a /= [head(h)] = obtemVals t a x y s  
                        | (h:t) == [] = (x,y,s)

{-| A função obtemDX é chamada na obtemVals para retirar a coordenada correspondente à posição horizontal 
do jogador que se encontra a jogar.
-}

obtemDX :: String -> Int -> Int
obtemDX t x | show x < [t !! 2]  = obtemDX t (x+1) 
            | show x == [t !! 2] = x 
            | otherwise = x 

{-| A função obtemDY é chamada na obtemVals para retirar a coordenada correspondente à posição vertical
do jogador que se encontra a jogar.
-}

obtemDY :: String -> Int -> Int 
obtemDY t y | show y < [t !! 4]  = obtemDY t (y+1) 
            | show y == [t !! 4] = y 
            | otherwise = y

{-| A função obtemDS é chamada na obtemVals para retirar os power ups que o jogador que se encontra a
jogar já apanhou em rondas anteriores.
-}

obtemDS :: String -> String -> Int -> String 
obtemDS [] _ _ = []
obtemDS (h:t) s l | l < 7 = obtemDS t s (l+1)
                  | l > 6 = h : obtemDS t s (l+1) 