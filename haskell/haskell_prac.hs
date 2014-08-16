import Data.Char

-- Chapter 1
-- naive implementation of quicksort
quicksort :: Ord a => [a] -> [a]
quicksort [] = []
quicksort (x:xs) = quicksort smaller ++ [x] ++ quicksort larger
	where
		smaller = [a | a <- xs, a < x]
		larger = [b | b <- xs, b > x]

-- Chapter 2
-- implementation of product
p :: Num a => [a] -> a
p [] = 1
p (x:xs) = x * p xs

n :: Int
n = a `div` (length xs)
	where
		a = 10
		xs = [1,2,3,4,5]

last' :: [a] -> a
last' xs = head (reverse xs)

init' :: [a] -> [a]
init' xs = reverse (tail (reverse xs))

init'' :: [a] -> [a]
init'' xs = take size xs
	where
		size = length xs -1

-- Chapter 4
halve :: [a] -> ([a], [a])
halve xs = (take n xs, drop n xs)
	where
		n = (length xs) `div` 2

--pattern matching
safetail :: [a] -> [a]
safetail [] = []
safetail (x:[]) = []
safetail (x:xs) = xs

--conditional expressions
safetail' :: [a] -> [a]
safetail' xs = if null xs then [] else tail xs

--guarded equations
safetail'' :: [a] -> [a]
safetail'' xs | null xs = []
			  | otherwise = tail xs

(||) :: Bool -> Bool -> Bool
False || False = False
_ || _ = False

-- Chapter 5
--list comprehensions
squares :: Int -> Int
squares n = sum [x^2 | x <- [1..n]]

replicate' :: Int -> b -> [b]
replicate' n x = [x | _ <- [1..n]]

pyths :: Int -> [(Int, Int, Int)]
pyths n = [(x,y,z) | x <- [1..n], y <-[1..n], z <- [1..n], x^2 + y^2 == z^2]

factors :: Int -> [Int]
factors n = [x | x <- [1..n], n `mod` x == 0]

perfects :: Int -> [Int]
perfects n = [x | x <- [1..n], sum([y | y <- (factors x), y < x]) == x]

comp' = [ (x,y) | x <- [1,2,3], y <- [4,5,6]]
comp = concat [[(x,y) | y <- [4,5,6]]| x <- [1,2,3]]

find :: Eq a => a -> [(a,b)] -> [b]
find k t = [v | (k', v) <- t, k == k']

positions :: Eq a => a -> [a] -> [Int]
positions x xs = find x (zip xs [0..n])
	where
		n = length xs -1

scalarproduct :: [Int] -> [Int] -> Int
scalarproduct xs ys = sum [ x*y |(x,y) <- zip xs ys]