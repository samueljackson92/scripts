-------------------------------------------------------------------------------
-- Project Euler
-- Author: Samuel Jackson
-- Date: 25/09/13
-- Description: Solutions to problems listed on the project euler website.
-------------------------------------------------------------------------------

-- Problem 1
-- Find the sum of all the multiples of a list of terms between 1 and n
sumMulti :: Int -> Int	
sumMulti n = foldl (+) 0 (multiples n)
	where
		multiples n = filter (isMultiple) [1..n-1]
		isMultiple x | x `mod` 3 == 0 = True
					 | x `mod` 5 == 0 = True
					 | otherwise = False

-- More effcient solution
sumMulti' :: Int -> Int
sumMulti' n = (sumDivBy 3 n) + (sumDivBy 5 n) - (sumDivBy 15 n)
	where
		sumDivBy x n = x * ((n `div` x) * ((n `div` x) +1)) `div` 2 

-- Problem 2
-- Summation of the even valued terms of the fibonacci sequence
--sumEvenFib :: Int -> Int
sumEvenFib n = sum (filter (isEven) (takeWhile (<n) fibs))
	where
		isEven x = x `mod` 2 == 0
		fibs = 0 : 1 : zipWith (+) fibs (tail fibs)