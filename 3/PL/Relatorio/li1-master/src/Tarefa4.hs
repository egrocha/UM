{-| 
Module : Tarefa4
Description : Módulo Haskell contendo a Tarefa 4.
Copyright : Eduardo Rocha <a77048@alunos.uminho.pt>;
            André Filipe Ferreira de Mira Vieira <a78322@alunos.uminho.pt>;
Um módulo contendo definições Haskell para a passagem de tempo num tabuleiro de jogo de Bomberman.
-}

module Main where

import Data.Char (isDigit)
import System.Environment
import Text.Read
import Data.Maybe

{-| Função main fornecida no enunciado, que recebe como inputs uma descrição de um mapa e o número de 
instantes de tempo restantes e usará esses dados para avançar o tempo do jogo e fechar o mapa, caso 
necessário. 
-}

main :: IO ()
main = do
    a <- getArgs
    let ticks = readMaybe (a !! 0) 
    w <- getContents
    if isJust ticks
        then putStr $ unlines $ avanca (lines w) (fromJust ticks)
        else putStrLn "Parâmetros inválidos"

{-| A função avanca recebe a informação do mapa de jogo e o tempo restante para o jogo acabar, chamando 
depois várias funções que irão avancar o tempo do jogo, e dependendo do tempo restante, fechar o mapa.
-}

avanca :: [String] -> Int -> [String]
avanca (h:t) c | c <= ((length h - 2)^2) = preSpiral (removeB (aTempo (passaTempo (h:t)) (passaTempo (h:t)))) (length h) c
               | otherwise = removeB (aTempo (passaTempo (h:t)) (passaTempo (h:t))) 

{-| A função removeB recebe a descrição de um mapa e remove, nessa descrição, todas as bombas cujos timers
já tenham atingido 0. 
-}

removeB :: [String] -> [String] 
removeB [] = []
removeB (h:t) | head h /= '*' = h : removeB t 
              | head h == '*' && rTimer h "" 0 == 0 = removeB t 
              | otherwise = h : removeB t

{-| A aTempo é chamada pela avanca para reduzir o tempo de todas as bombas no mapa. Para tal, utiliza 
uma função auxiliar.
-}

aTempo :: [String] -> [String] -> [String] 
aTempo [] a = a 
aTempo (h:t) a | head h /= '*' = aTempo t a 
               | head h == '*' && rTimer h "" 0 == 0 = aTempo t (auxAT a (rCRaio h ("","","") 0) (length (head a)))
               | otherwise = aTempo t a 

{-| A função auxAT é a função auxiliar chamada pela aTempo e é a função que controla as explosões. Recebe 
o mapa e as coordenadas da bomba, assim como o raio da bomba e chama as funções subTij e subJog para 
mudarem a informação do mapa e dos jogadores/power ups/bombas, respetivamente, juntando depois o 
resultado das duas funções.
-}

auxAT :: [String] -> (Int,Int,Int) -> Int -> [String]
auxAT a (x,y,r) l = subTij a (x,y,r) l ++ subJog a (x,y,r) l

{-| A subJog é chamada pela auxAT para remover os tijolos que são atigidos quando ocorre uma explosão.
Para tal, utiliza uma função auxiliar - auxSJ.
-}

subJog :: [String] -> (Int,Int,Int) -> Int -> [String] 
subJog t (x,y,r) l = auxSJ (splitAt y (fst(splitAt l t))) (snd(splitAt l t)) (x,y,r) 

{-| A auxSJ é chamada pela subJog, recebendo a informação do jogo, dividida em duas partes:
a primeira parte corresponde ao próprio tabuleiro e a segunda parte à informação de jogadores, power ups 
e bombas. A auxSJ chama duas funções, a preJogH e a subJogV, para tratar da remoção dos jogadores, bombas
e power ups, horizontalmente e verticalmente.
-}

auxSJ :: ([String],[String]) -> [String] -> (Int,Int,Int) -> [String] 
auxSJ (up,h:down) j (x,y,r) = preJogH h (subJogV (reverse up) (subJogV down j x (y+1) r 0 1) x (y-1) r 0 0) x y r 0

{-| A preJogH é a função chamada pela auxSJ para preparar a informação que será fornecida à subJogH.
Para tal, divide a string que lhe é fornecida em duas partes e chama uma função auxiliar.
-}

preJogH :: String -> [String] -> Int -> Int -> Int -> Int -> [String] 
preJogH t j x y r c = auxPJogH (splitAt x t) j x y r c 

{-| A auxPJogH é a função auxiliar chamada pela preJogH, que recebendo as duas partes da string que 
será analisada, chama a subJogH para as duas metades assim como a locJog para o carácter do centro.
-}

auxPJogH :: (String,String) -> [String] -> Int -> Int -> Int -> Int -> [String]
auxPJogH (left,h:right) j x y r c = subJogH right (subJogH (reverse left) (locJog j (x,y,0)) (x-1) y r c 0) (x+1) y r c 1 

{-| A função subJogH é utilizada para percorrer uma lista de carácteres, verificando se existem power ups,
jogadores ou bombas no caminho da explosão, removendo-as caso existirem e parando a função caso encontre
uma pedra ou tijolo. 
-}

subJogH :: String -> [String] -> Int -> Int -> Int -> Int -> Int -> [String] 
subJogH [] j _ _ _ _ _ = j
subJogH (h:t) j x y r c i | c <= r && h == ' ' && i == 0 = subJogH t (locJog j (x,y,0)) (x-1) y r (c+1) i 
                          | c <= r && h == ' ' = subJogH t (locJog j (x,y,0)) (x+1) y r (c+1) i
                          | otherwise = j

{-| A subJogV tem a função de percorrer uma parte do tabuleiro de jogo, verificando se existem jogadores,
power ups ou bombas numa posição específica ao longo do tabuleiro.
-}

subJogV :: [String] -> [String] -> Int -> Int -> Int -> Int -> Int -> [String] 
subJogV [] j _ _ _ _ _ = j
subJogV (h:t) j x y r c i | c <= r && h!!x == ' ' && i == 0 = subJogV t (locJog j (x,y,0)) x (y-1) r (c+1) i
                          | c <= r && h!!x == ' ' = subJogV t (locJog j (x,y,0)) x (y+1) r (c+1) i
                          | otherwise = j 

{-| A função locJog é utilizada em várias funções para verificar se numa coordenada específica existem 
jogadores, bombas ou power ups. No caso dos jogadores e power ups, estes serão removidos da informação 
do mapa, mas no caso das bombas o seu temporizador será reduzido para 1 caso este seja maior que 1.
Caso a locJog seja chamada com c == 1, se a linha que estiver a ser analizada corresponda a uma bomba, 
esta será removida em vez de ter o seu temporizador reduzido como normalmente.
-}

locJog :: [String] -> (Int,Int,Int) -> [String]
locJog [] (x,y,c) = []
locJog (h:t) (x,y,c) | head h == '*' && rCoords h ("","") 0 == (x,y) && c == 1 = locJog t (x,y,c)
                     | head h == '0' && rCoords h ("","") 0 == (x,y) = locJog t (x,y,c) 
                     | head h == '1' && rCoords h ("","") 0 == (x,y) = locJog t (x,y,c)
                     | head h == '2' && rCoords h ("","") 0 == (x,y) = locJog t (x,y,c)
                     | head h == '3' && rCoords h ("","") 0 == (x,y) = locJog t (x,y,c)
                     | head h == '+' && rCoords h ("","") 0 == (x,y) = locJog t (x,y,c)
                     | head h == '!' && rCoords h ("","") 0 == (x,y) = locJog t (x,y,c)
                     | head h == '*' && rCoords h ("","") 0 == (x,y) && rTimer h "" 0 > 1 = reduzB1 h 0 : locJog t (x,y,c)
                     | otherwise = h : locJog t (x,y,c)

{-| A reduzB1 é chamada pela locJog para reduzir o timer de uma bomba para 1.
-}

reduzB1 :: String -> Int -> String 
reduzB1 (h:t) c | c < 5 && h /= ' ' = h : reduzB1 t c
                | h == ' ' = h : reduzB1 t (c+1)
                | c == 5 = show(1)  

{-| A subTij, semelhantemente à subJog é utilizada para atualizar a informação de jogo quando ocorre 
uma explosão, mas em vez de remover informação correspondente a jogadores, bombas ou power ups, tenta
apenas remover os primeiros tijolos atingidos pelas tais explosões. Para este efeito, utiliza a mesma
tática da subJog, de dividir o mapa e analizá-lo por partes.
-}

subTij :: [String] -> (Int,Int,Int) -> Int -> [String] 
subTij t (x,y,r) l = auxST (splitAt y (fst(splitAt l t))) x r

{-| A função auxST é chamada pela subTij, recebendo o mapa dividido em partes, e chamando as funções 
subTijV e subTijH com estas partes.
-}

auxST :: ([String],[String]) -> Int -> Int -> [String]
auxST (up,h:down) x r = reverse(subTijV (reverse up) x r 1) ++ [subTijH h x r] ++ subTijV down x r 1   

{-| A subTijV é utilizada para analizar o mapa verticalmente. Passa pelas strings que lhe são fornecidas
e vê se numa posição específica (a coordenada horizontal onde a bomba explodiu), se existe um tijolo. 
Caso exista, será removido.
-}

subTijV :: [String] -> Int -> Int -> Int -> [String] 
subTijV [] _ _ _ = []
subTijV (h:t) x r c | c <= r && h!!x == ' ' = h : subTijV t x r (c+1)
                    | c <= r && h!!x == '?' = auxSTV h x 0 : t 
                    | otherwise = (h:t) 

{-| A auxSTV é utilizada como auxiliar na subTijV para mudar as linhas onde se encontram tijolos. 
-}

auxSTV :: String -> Int -> Int -> String
auxSTV (h:t) x c | c < x = h : auxSTV t x (c+1)
                 | c == x && h == '?' = ' ' : t
                 | otherwise = (h:t)

{-| A subTijH é chamada pela auxST para analizar o mapa horizontalmente. Para tal, recebe uma linha do 
mapa (a linha onde a bomba explodiu) e analiza a linha, tentando encontrar nela tijolos.
-}

subTijH :: String -> Int -> Int -> String
subTijH [] _ _ = []
subTijH t x r = auxSTH (splitAt x t) x r

{-| A auxSTH é chamada pela subTijH, recebendo uma linha do tabuleiro dividida em duas partes, uma
correspondendo à parte à esquerda da explosão e outra parte incluíndo a direita da explosão e o 
centro. Com estas partes, chama a subTHLR, onde irão ser subsitituídos os tijolos, caso necessário.
-}

auxSTH :: (String,String) -> Int -> Int -> String 
auxSTH (left,h:right) x r = reverse(subTHLR (reverse left) r 1) ++ [h] ++ subTHLR right r 1

{-| A subTHLR é usada na auxSTH e é usada para percorrer as partes do mapa que lhe são atribuidas a ver 
se encontra tijolos, que serão substituídos por espaços.
-}

subTHLR :: String -> Int -> Int -> String
subTHLR (h:t) r c | c > r = (h:t)
                  | c <= r && h == ' ' = h : subTHLR t r (c+1) 
                  | c <= r && h == '?' = ' ' : t
                  | otherwise = (h:t)

{-| A função rCRaio é chamada pela função aTempo para retirar as coordenadas e raio de uma linha de
informação correspondente a uma bomba cujo timer seja 0.
-}

rCRaio :: String -> (String,String,String) -> Int -> (Int,Int,Int)
rCRaio [] (x,y,r) _ = (converte x 0,converte y 0,converte r 0)
rCRaio (h:t) (x,y,r) c | h == ' ' = rCRaio t (x,y,r) (c+1)
                       | c == 0 && h /= ' ' = rCRaio t (x,y,r) c
                       | c == 1 && h /= ' ' = rCRaio t (h:x,y,r) c
                       | c == 2 && h /= ' ' = rCRaio t (x,h:y,r) c 
                       | c == 3 && h /= ' ' = rCRaio t (x,y,r) c 
                       | c == 4 && h /= ' ' = rCRaio t (x,y,h:r) c
                       | c > 4 = rCRaio [] (x,y,r) c 

{-| A rCoords é usada pela locJog para retirar as coordenadas de uma linha que descreva uma bomba, 
posição de jogador ou power up.
-}

rCoords :: String -> (String,String) -> Int -> (Int,Int) 
rCoords [] (x,y) _ = (converte x 0,converte y 0)
rCoords (h:t) (x,y) c | h == ' ' = rCoords t (x,y) (c+1)
                      | c == 0 && h /= ' ' = rCoords t (x,y) c 
                      | c == 1 && h /= ' ' = rCoords t (h:x,y) c 
                      | c == 2 && h /= ' ' = rCoords t (x,h:y) c 
                      | c > 2 = rCoords [] (x,y) c 

{-| A função rTimer é usada para retirar o valor do timer de uma linha de descrição de bomba.
-}

rTimer :: String -> String -> Int -> Int 
rTimer [] t _ = converte t 0 
rTimer (h:ts) t c | h == ' ' = rTimer ts t (c+1)
                  | c < 5 && h /= ' ' = rTimer ts t c 
                  | c == 5 && h /= ' ' = rTimer [] ((h:ts)++t) c

{-| A função converte é chamada em funções que retiram dados de linhas de informação do mapa, e é
utilizada para converter os dados obtidos de Strings para Integers.
-}

converte :: String -> Int -> Int
converte [] i = i 
converte t i | show i /= t = converte t (i+1)
             | show i == t = i

{-| A passaTempo é a função que passa pelo mapa para verificar quais linhas têm bombas, aplicando a 
essas linhas a função reduzBomba antes de as devolver.
-}

passaTempo :: [String] -> [String]
passaTempo [] = []
passaTempo ((a:b):t) | a /= '*' = (a:b) : passaTempo t 
                     | a == '*' = reduzBomba (a:b) 0 : passaTempo t 

{-| A função reduzBombas é chamada pela passaTempo, recebendo as strings que a passaTempo encontra 
para que possa então reduzir o valor do timer dentro delas por um valor.
-}

reduzBomba :: String -> Int -> String 
reduzBomba (h:t) c | c < 5 && h /= ' ' = h : reduzBomba t c
                   | h == ' ' = h : reduzBomba t (c+1)
                   | c == 5 = show((converte (h:t) 0)-1)  

{-| A preSpiral é a função responsável por preparar os inputs necessários para iniciar o processo 
de fechar o mapa. Para tal, chama a função spiral (para colocar as pedras) e a montaS (para voltar a 
juntar os dados que a preSpiral separa, assim como para chamar a locJog).
-}

preSpiral :: [String] -> Int -> Int -> [String] 
preSpiral (h:t) l c = montaS(spiral (fst(splitAt l (h:t))) c l 0 0 0 1) (snd(splitAt l (h:t))) l

{-| A montaS recebe o tabuleiro de jogo alterado pela spiral assim como as coordenadas onde a última pedra
foi colocada. Chama a função recS para restaurar o tabuleiro alterado pela spiral e a locJog para 
retirar informações de jogadores, bombas ou power ups na posição onde foi colocada uma pedra e depois 
junta os outputs produzidos por essas duas funções.
-}

montaS :: ([String],(Int,Int)) -> [String] -> Int -> [String]
montaS (t,(x,y)) j l = recS t l ++ locJog j (x,y,1)

{-| A recS é usada para reconstruir um tabuleiro de jogo após a função spiral reduzir a sua dimensão,
adicionando linhas so com um carácter ao início e final até o comprimento ser igual ao pretendido. 
Após isso, irá chamar a função addRS para completar o trabalho.
-}

recS :: [String] -> Int -> [String]
recS [] _ = []
recS (h:t) l | length (h:t) < l = recS (["#"]++(h:t)++["#"]) l
             | otherwise = addRS (h:t) l 

{-| A addRS é chamada pela recS para encher as linhas adicionadas pela recS até que todas as linhas 
tenham o comprimento desejado. Para tal, utiliza uma função auxiliar.
-}

addRS :: [String] -> Int -> [String]
addRS [] _ = []
addRS (h:t) l | length h < l = auxRS h l : addRS t l 
              | otherwise = addRS t l

{-| A auxRS é usada como auxiliar na função addRS para adicionar os carácteres em falta às linhas
que será necessário alterar na função addRS.
-}

auxRS :: String -> Int -> String 
auxRS t l | length t < l = auxRS ('#' : t ++ "#") l
          | otherwise = t  

{-| A função spiral é a função responsável por colocar uma pedra numa coordenada do mapa enquanto este
fecha. Para tal, corre uma série de verificações para ver se as linhas ou colunas que está a analizar 
estão cheias - caso a parte exterior do mapa esteja toda preenchida por pedras, esta será removida e 
será analisado o interior do mapa, sendo a parte removida depois restaurada pela função recS. Caso 
a função spiral encontre uma linha ou coluna que não esteja preenchida, irá utilizar as funções 
spiralH ou spiralV para colocar uma pedra.
-}

spiral :: [String] -> Int -> Int -> Int -> Int -> Int -> Int -> ([String],(Int,Int))
spiral [] _ _ _ _ _ _ = ([],(0,0))
spiral (h:t) c l x y z i | i == 1 && not(checkLinhaH h) = (spiralH h c y : t,(z-1+(contaSH h 1),y)) 
                         | i == 1 && (checkLinhaH h) = spiral (h:t) c l l y z 2
                         | i == 2 && not(checkLinhaV (h:t) (l-1)) = (spiralV (h:t) (x-1) y c,(x,z-1+contaSV (h:t) (x-1) 1)) 
                         | i == 2 && (checkLinhaV (h:t) (l-1)) = spiral (h:t) c l x l z 3
                         | i == 3 && not(checkLinhaH (last (h:t))) = (init(h:t) ++ [reverse (spiralH (reverse(last (h:t))) c y)],(z-1+contaSH (reverse(last (h:t))) 1,y)) 
                         | i == 3 && (checkLinhaH (last (h:t))) = spiral (h:t) c l z y z 4  
                         | i == 4 && not(checkLinhaV (h:t) 0) = (spiralV (h:t) (x-1) y c,(x,z-1+(contaSV (reverse (h:t)) (x-1) 1))) 
                         | i == 4 && (checkLinhaV (h:t) 0) = spiral (retiraP (h:t)) c (l-2) (z+1) (z+1) (z+1) 1
                         | otherwise = ((h:t),(x,y)) 

{-| A spiralH recebe a linha que se pretende atualizar e adiciona uma pedra nas coordenadas pedidas,
excepto no caso onde nessa coordenada já existe uma pedra, onde não será realizada alteração.
-}

spiralH :: String -> Int -> Int -> String
spiralH " " _ _ = "#" 
spiralH "?" _ _ = "#"
spiralH "#" _ _ = "#"
spiralH (a:b:t) c y | a /= '#' = '#' : (b:t)
                    | a == '#' && b == '#' = a : spiralH (b:t) c y
                    | a == '#' && b /= '#' && mod y 2 == 0 && mod c 2 == 0 = a : "#" ++ t 
                    | a == '#' && b /= '#' && mod y 2 == 0 && mod c 2 /= 0 = (a:b:t)
                    | a == '#' && b /= '#' && mod y 2 /= 0 = a : "#" ++ t 

{-| A spiralV recebe o tabuleiro inteiro utilizado na spiral e tenta adicionar uma pedra numa coluna 
específica, caso não exista já nessas coordenadas uma pedra.
-}

spiralV :: [String] -> Int -> Int -> Int -> [String] 
spiralV (a:b:t) x y c | a!!x /= '#' = auxSV a x : (b:t)
                      | a!!x == '#' && b!!x == '#' = a : spiralV (b:t) x y c 
                      | a!!x == '#' && b!!x /= '#' && mod y 2 == 0 && mod c 2 == 0 = a : [auxSV b x] ++ t 
                      | a!!x == '#' && b!!x /= '#' && mod y 2 == 0 && mod c 2 /= 0 = (a:b:t)
                      | a!!x == '#' && b!!x /= '#' && mod y 2 /= 0 = a : [auxSV b x] ++ t 

{-| A contaSH é utilizada para contar o número de pedras numa linha do mapa.
-}

contaSH :: String -> Int -> Int 
contaSH [] i = i
contaSH (h:t) i | h == '#' = contaSH t (i+1) 
                | otherwise = i 

{-| A contaSV é utilizada para contar o número de pedras numa coluna do mapa.
-}

contaSV :: [String] -> Int -> Int -> Int
contaSV [] x i = i 
contaSV (h:t) x i | h!!x == '#' = contaSV t x (i+1)
                  | otherwise = i 

{-| A auxSV é uma função auxiliar da spiralV utilizada para colocar uma pedra no sítio indicado pelo
input.
-}

auxSV :: String -> Int -> String
auxSV [] _ = []
auxSV (h:t) i | i > 0 = h : auxSV t (i-1)
              | otherwise = '#' : t 

{-| A checkLinhaH é utilizada para verificar se uma linha do mapa é formada por pedras exclusivamente.
-}
 
checkLinhaH :: String -> Bool
checkLinhaH [] = True
checkLinhaH (h:t) | h == '#' = checkLinhaH t 
                  | otherwise = False

{-| A checkLinhaV é utilizada para verifcar se uma coluna do mapa é formada por pedras exclusivamente.
-}

checkLinhaV :: [String] -> Int -> Bool 
checkLinhaV [] _ = True
checkLinhaV (h:t) y | h!!y == '#' = checkLinhaV t y
                    | otherwise = False

{-| A função retiraP (retirada da Tarefa 3) é chamada na compress para retirar as paredes laterais do 
tabuleiro. Para tal, utiliza as funções retiraV e retiraH. Strings que descrevam as locações de power ups, 
jogadores ou bombas permanecerão inalteradas.
-}

retiraP :: [String] -> [String]
retiraP (h:t) = retiraV(retiraH (h:t))

{-| A função retiraV (Tarefa 3) é utilizada na retiraP e o seu objetivo é retirar os primeiros e últimos 
elementos de todas as strings das listas que descrevam o centro do tabuleiro.
-}

retiraV :: [String] -> [String]
retiraV [] = []
retiraV (h:t) | head h == '#' = (init(tail h)) : retiraV t   
              | otherwise = (h:t)

{-| A função retiraH (Tarefa 3) é utilizada na retiraP e o seu objetivo é retirar a primeira e última 
linha do tabuleiro.
-}

retiraH :: [String] -> [String] 
retiraH [] = [] 
retiraH t | (checkLinhaH (head t)) && (checkLinhaH (last t)) = (init(tail t))
          | otherwise = t 