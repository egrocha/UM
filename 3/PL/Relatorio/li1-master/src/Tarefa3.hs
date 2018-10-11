{-| 
Module : Tarefa3
Description : Módulo Haskell contendo a Tarefa 3.
Copyright : Eduardo Rocha <a77048@alunos.uminho.pt>;
            André Filipe Ferreira de Mira Vieira <a78322@alunos.uminho.pt>;
Um módulo contendo definições Haskell para a compressão e descompressão de um tabuleiro de jogo de Bomberman.
-}

module Main where

import System.Environment

{-| Função main fornecida no enunciado, que irá comprimir ou descomprimir a uma lista de strings ou uma
string, respetivamente, de acordo com os inputs fornecidos.
-}

main :: IO ()
main = do a <- getArgs
          let p = a !! 0
          w <- getContents
          if length a == 1 && length p == 2 && (p=="-e" || p=="-d")
             then if p=="-e" then putStr $ encode $ lines w
                             else putStr $ unlines $ decode w
             else putStrLn "Parâmetros inválidos"

{-| A função encode irá pegar numa lista de strings que corresponde ao tabuleiro de jogo e executará a 
função compress, para reduzir a lista para o menor número de caracters possíveis.
-}

encode :: [String] -> String
encode l = unlines (compress l)

{-| A função compress é utilizada pela função encode para executar os processos de alteração ao tabuleiro
necessários antes de se executar o unlines dele.
-}

compress :: [String] -> [String]
compress (h:t) = retiraP t

{-| A função retiraP é chamada na compress para retirar as paredes laterais do tabuleiro. Para tal, utiliza
as funções retiraV e retiraH. Strings que descrevam as locações de power ups, jogadores ou bombas
permanecerão inalteradas.
-}

retiraP :: [String] -> [String]
retiraP (h:t) = retiraV(retiraH (h:t))

{-| A função retiraV é utilizada na retiraP e o seu objetivo é retirar os primeiros e últimos elementos
de todas as strings das listas que descrevam o centro do tabuleiro.
-}

retiraV :: [String] -> [String]
retiraV [] = []
retiraV (h:t) | head h == '#' = (init(tail h)) : retiraV t   
              | otherwise = (h:t)

{-| A função retiraH é utilizada na retiraP e o seu objetivo é retirar a primeira e última linha do 
tabuleiro.
-}

retiraH :: [String] -> [String] 
retiraH [] = [] 
retiraH (a:b:c) | length (a:b:c) == 3 && head b == '#' && head(head c) == '#' = a:[b]
                | head a == '#' && head b == '#' = a : retiraH (b:c)
                | head a == '#' && head b /= '#' = b:c  
                | otherwise = []

{-| A função decode fará o processo contrário ao da função encode, ou seja, pega numa string comprimida 
pela encode e reverte o processo de compresso, restaurando o tabuleiro de jogo ao seu estado inicial.
-}

decode :: String -> [String]
decode l = decompress (lines l)

{-| A função decompress é chamada na função decode e serve para adicionar as paredes laterais
anteriormente retiradas pela retiraP. 
-}

decompress :: [String] -> [String]
decompress l = linhaPU ((length h)+2) : adicionaH (adicionaV (h:t)) ((length h)+2) 
 
{-| A adicionaV é invocada pela adicionaP para restaurar as paredes verticais ao centro do tabuleiro.
-}

adicionaV :: [String] -> [String] 
adicionaV [] = []
adicionaV (a:b) | head a == ' ' || head a == '?' = ('#' : a ++ "#") : adicionaV b 
                | otherwise = a : adicionaV b

{-| A adicionaH é invocada pela adicionaP para restaurar a primeira e última linha ao tabuleiro.
-}

adicionaH :: [String] -> Int -> [String] 
adicionaH [] _ = []
adicionaH (h:t) x | length (h:t) == 1 && head(head (h:t)) == '#' = linhaPU x : adicionaH t x 
                  | head(head t) == '#' = h : adicionaH t x
                  | head h == '#' && head(head t) /= '#' = h : (linhaPU x : t)  

{-| A função linhaPU, tal como na Tarefa 1, é utilizada para produzir uma linha preenchida unicamente
por pedras, que será igual à primeira e última linha do tabuleiro original.
-}

linhaPU :: Int -> String
linhaPU 0 = []
linhaPU l | l > 0 = '#' : (linhaPU (l-1))