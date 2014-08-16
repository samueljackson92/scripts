removeNonUppercase :: [Char] -> [Char]
removeNonUppercase st = [c | c <- st, c `elem` ['A' .. 'Z']]

hello 1 = "hi"
hello 2 = "hello"
hello x = "Error"

locations :: Char -> String ->[Int]
locations x ys = 
	map fst (filter (isChar) (zip [0..] ys))
	where
		isChar (_,q) = x == q
