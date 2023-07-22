--190101085
--Siddharth Charan
--In this file direct code implementation is given. Logic behind codes is given in separarte file
import Data.Char
--Exercise 4.1
halve xs = splitAt ((length xs) `div` 2) xs

--Exercise 4.2
third xs = head (tail (tail (xs)))

third' xs = xs !! 2

third'' :: [a] -> a
third'' (_:_:x:xs) = x

--Exercise 4.3
safetail xs =
  if null xs
    then []
    else tail xs

safetail' xs
  | null xs = []
  | otherwise = tail xs

safetail'' [] = []
safetail'' (_:xs) = xs

--Exercise 4.4
-- Given in separate file
--Exercise 4.5
a && b =
  if a == True
    then if b == True
           then True
           else False
    else False

--Exercise 4.6
--As, && is already used, we can't redefine it. So, I have used &&& instead
a &&& b =
  if a == True
    then b
    else False

--Exercise 4.7
mult = \x -> (\y -> (\z -> x * y * z))

--Exercise 4.8
luhnDouble x =
  if x * 2 > 9
    then x * 2 - 9
    else x * 2

luhn a b c d = (luhnDouble a + b + luhnDouble c + d) `mod` 10 == 0

--Exercise 5.1
result = sum [x^2 | x <- [1..100]]

--Exercise 5.2
grid m n = [(x, y) | x <- [0 .. m], y <- [0 .. n]]

--Exercise 5.3
square n = [(x, y) | x <- [0 .. n], y <- [0 .. n], x /= y]

--Exercise 5.4
replicate n x = [x | _ <- [1..n]]

--Exercise 5.5
pyths n =
  [ (x, y, z)
  | x <- [1 .. n]
  , y <- [1 .. n]
  , z <- [1 .. n]
  , x ^ 2 + y ^ 2 == z ^ 2
  ]

--Exercise 5.6
factors_except_itself n = [x | x <- [1 .. n-1], n `mod` x == 0]

perfects n = [x | x <- [1 .. n], x == sum (factors_except_itself x)]

--Exercise 5.7

result' = concat [[(x, y) | y <- [3, 4]] | x <- [1, 2]]

--Exercise 5.8
find k t = [v | (k', v) <- t, k == k']

positions' x xs = find x (zip xs [0 ..])

--Exercise 5.9
scalarproduct xs ys = sum [x * y | (x, y) <- zip xs ys]

--Exercise 5.10
let2int :: Char -> Int 
let2int c 
  | isLower c = ord c - ord 'a'
  | isUpper c = ord c - ord 'A'

int2let :: Int -> Bool -> Char 
int2let n lowerLetter
  | lowerLetter = chr (ord 'a' + n)
  | otherwise = chr (ord 'A' + n)

shift :: Int -> Char -> Char
shift n c 
  | isLower c = int2let ((let2int c + n) `mod` 26) True
  | isUpper c = int2let ((let2int c + n) `mod` 26) False
  |otherwise = c


encode :: Int -> String -> String
encode n xs = [shift n x | x <- xs]

table :: [Float]
table = [8.1, 1.5, 2.8, 4.2, 12.7, 2.2, 2.0, 6.1, 7.0, 0.2, 0.8, 4.0, 2.4, 6.7, 7.5, 1.9, 0.1, 6.0, 6.3, 9.0, 2.8, 1.0, 2.4, 0.2, 2.0, 0.1]

percent :: Int -> Int -> Float
percent n m = (fromIntegral n / fromIntegral m) * 100

lowers :: String -> Int
lowers xs = length [x | x <- xs, x >= 'a' Prelude.&& x <= 'z']

uppers :: String -> Int
uppers xs = length [x | x <- xs, x >= 'A' Prelude.&& x <= 'Z']

count :: Char -> String -> Int
count x xs = length [x' | x' <- xs, x == x']

freqs :: String -> [Float]
freqs xs = [percent ( count x xs + count y xs ) n | (x,y) <- zip ['a'..'z'] ['A'..'Z'] ]
             where n = lowers xs + uppers xs

chisqr :: [Float] -> [Float] -> Float
chisqr os es = sum [((o-e)^2)/e | (o,e) <- zip os es]


rotate :: Int -> [a] -> [a]
rotate n xs = drop n xs ++ take n xs


crack :: String -> String 
crack xs = encode (-factor) xs
   where
      factor = head (positions' (minimum chitab) chitab)
      chitab = [chisqr (rotate n table') table | n <- [0..25]]
      table' = freqs xs