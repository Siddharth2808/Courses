--Assignment 4
--Siddharth Charan
--190101085
--As, file is already very large, explanation and other part of questions except code, for each exercise is given in separate file.
--You can see screenshots also, in other file, for each exercise execution
--To run: ghci 190101085.hs

import Data.Char
-- Exercise 6.1
fac 0 = 1
fac n
  | n > 0 = n * fac (n - 1)

-- Exercise 6.2
sumdown 0 = 0
sumdown n
  | n >= 0 = n + sumdown (n - 1)

--Exercise 6.3
(^) _ 0 = 1
(^) a b
  | b > 0 = a * (a Main.^ (b - 1))

--Exercise 6.4
euclid m n
     | m==n = n
     | n < m = euclid (m-n) n
     | m < n = euclid m (n-m)

--Exercise 6.5
--Given in other file

--Exercise 6.6
and' :: [Bool] -> Bool
and' [] = True
and' (x:xs) = x && (and' xs)

concat' :: [[a]] -> [a]
concat' [] = []
concat' [x] = x
concat' (x:xs) = x ++ concat' xs

replicate' :: Int -> a -> [a]
replicate' 0 _ = []
replicate' m x = x : replicate' (m - 1) x
   
(!!) :: [a] -> Int -> a
(!!) (x:_) 0 = x
(!!) (_:xs) n = (Main.!!) xs (n - 1)

elem' :: Eq a => a -> [a] -> Bool
elem' _ [] = False
elem' e (x:xs) = e == x || elem' e xs

--Exercise 6.7
merge [] a= a
merge b []= b
merge (a:as) (b:bs)
  | a < b = a : merge as (b:bs)
  | otherwise = b : merge (a:as) bs

--Exercise 6.8
halve :: [a] -> ([a], [a])
halve xs = splitAt ((length xs) `div` 2) xs

msort :: Ord a => [a] -> [a]
msort [] = []
msort [x] = [x]
msort xs = merge (msort left) (msort right)
  where
    (left, right) = halve xs
--Exercise 6.9
sum' :: Num p => [p] -> p
sum' [] = 0
sum' (x:xs) = x + sum' xs

take' :: Int -> [a] -> [a]
take' 0 _ = []
take' n (x:xs) = x : take' (n - 1) xs

last' :: [a] -> a
last' [x] = x
last' (x:xs) = last' xs

--Exercise 7.1
-- Solved in other file

--Exercise 7.2
all p = and . map p

any p = or . map p

takeWhile' p =
  foldr
    (\x xs ->
       if p x
         then x : xs
         else [])
    []

dropWhile' p =
  foldl
    (\xs x ->
      if (p x) && (length xs == 0)
         then []
         else xs ++ [x])
    []

--Exercise 7.3
map' f = foldr (\x xs -> f x : xs) []
filter' p = foldr (\x xs -> if p x then x:xs else xs) []

--Exercise 7.4
dec2int :: [Int] -> Int
dec2int = foldl (\n d -> 10 * n + d) 0

--Exercise 7.5
curry' :: ((a, b) -> c) -> a -> b -> c
curry' f = \a b -> f (a, b)

uncurry' :: (a -> b -> c) -> (a, b) -> c
uncurry' f = \(a, b) -> f a b


--Exercise 7.6
type Bit = Int

unfold :: (t -> Bool) -> (t -> a) -> (t -> t) -> t -> [a]
unfold p h t x
  | p x = []
  | otherwise = h x : unfold p h t (t x)

int2bin :: Int -> [Bit]
int2bin = unfold (== 0) (`mod` 2) (`div` 2)

chop8 :: [Bit] -> [[Bit]]
chop8 = unfold null (take 8) (drop 8)

map'' :: (a -> b) -> [a] -> [b]
map'' f = unfold null (f . head) tail

iterate' :: (a -> a) -> a -> [a]
iterate' = unfold (const False) id


--Exercise 7.9
altMap :: (a -> b) -> (a -> b) -> [a] -> [b]
altMap _ _ [] = []
altMap f0 f1 (x:xs) = f0 x : altMap f1 f0 xs

--Exercise 7.10
luhnDouble x =
  if x * 2 > 9
    then x * 2 - 9
    else x * 2

luhn xs = sum (altMap luhnDouble id xs) `mod` 10 == 0

--Exercise 8.1
data Nat
  = Zero
  | Succ Nat
  deriving Show

int2nat :: Int -> Nat
int2nat 0 = Zero
int2nat n = Succ (int2nat (n - 1))

nat2int :: Nat -> Int
nat2int Zero = 0
nat2int (Succ n) = 1 + nat2int n

add :: Nat -> Nat -> Nat
add Zero n = n
add (Succ m) n = Succ (add m n)

mult' m Zero = Zero
mult' m (Succ n) = add m (mult' m n)

--Exercise 8.2
data Tree a
  = Leaf a
  | Node (Tree a) a (Tree a)

occurs :: Ord a => a -> Tree a -> Bool
occurs x (Leaf y) = x == y
occurs x (Node l y r) =
  case compare x y of
    LT -> occurs x l
    EQ -> True
    GT -> occurs x r

--Exercise 8.3
data Tree' a
  = Leaf' a
  | Node' (Tree' a) (Tree' a)

balanced :: Tree' a -> Bool
balanced (Leaf' _) = True
balanced (Node' l r) = abs (size l - size r) <= 1 && balanced l && balanced r

size :: Tree' a -> Int
size (Leaf' _) = 1
size (Node' l r) = size l + size r

--Exrecise 8.4
data Tree'' a
  = Leaf'' a
  | Node'' (Tree'' a) (Tree'' a)
  deriving (Show)

balance :: [a] -> Tree'' a
balance [] = error "Empty list"
balance [x] = Leaf'' x
balance xs = Node'' (balance l) (balance r)
  where
    (l, r) = halve xs

--Exercise 8.5
data Expr
  = Val Int
  | Add Expr Expr

folde :: (Int -> a) -> (a -> a -> a) -> Expr -> a
folde f _ (Val a) = f a
folde f g (Add a b) = g (folde f g a) (folde f g b)

--Exercise 8.6

eval :: Expr -> Int
eval = folde id (+)

size' :: Expr -> Int
size' = folde (const 1) (+)

--Exercise 8.7
--Solved in other file

--Exercise 8.8

int2bin'' :: Int -> [Bit]
int2bin'' 0 = []
int2bin'' n = n `mod` 2 : int2bin'' (n `div` 2)

rmdups :: Eq a => [a] -> [a]
rmdups [] = []
rmdups (x:xs) = x : rmdups (filter (/= x) xs)

data Prop
  = Const Bool
  | Var Char
  | Not Prop
  | And Prop Prop
  | Or Prop Prop
  | Imply Prop Prop
  | Equiv Prop Prop

type Assoc k v = [(k, v)]

find :: Eq k => k -> Assoc k v -> v
find k t = head [v | (k', v) <- t, k == k']

type Subst = Assoc Char Bool

eval' :: Subst -> Prop -> Bool
eval' _ (Const b) = b
eval' s (Var x) = find x s
eval' s (Not p) = not (eval' s p)
eval' s (And p q) = eval' s p && eval' s q
eval' s (Or p q) = eval' s p || eval' s q
eval' s (Imply p q) = eval' s p <= eval' s q
eval' s (Equiv p q) = eval' s p == eval' s q

vars :: Prop -> [Char]
vars (Const _) = []
vars (Var x) = [x]
vars (Not p) = vars p
vars (And p q) = vars p ++ vars q
vars (Or p q) = vars p ++ vars q
vars (Imply p q) = vars p ++ vars q
vars (Equiv p q) = vars p ++ vars q

bools :: Int -> [[Bool]]
bools 0 = [[]]
bools n = map (False :) bss ++ map (True :) bss
  where
    bss = bools (n - 1)

substs :: Prop -> [Subst]
substs p = map (zip vs) (bools (length vs))
  where
    vs = rmdups (vars p)

isTaut :: Prop -> Bool
isTaut p = and [eval' s p | s <- substs p]

p1 :: Prop
p1 = And (Var 'A') (Not (Var 'A'))

p2 :: Prop
p2 = Imply (And (Var 'A') (Var 'B')) (Var 'A')

p3 :: Prop
p3 = Imply (Var 'A') (And (Var 'A') (Var 'B'))

p4 :: Prop
p4 = Imply (And (Var 'A') (Imply (Var 'A') (Var 'B'))) (Var 'B')

p5 :: Prop
p5 = Imply (And (Or (Var 'A') (Var 'B')) (Or (Var 'C') (Var 'D'))) (Var 'E')

p6 :: Prop
p6 = Equiv (Or (Var 'A') (Var 'B')) (Or (Var 'C') (Var 'D'))