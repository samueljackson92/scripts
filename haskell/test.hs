--haskell test script

exp' :: Int -> Int -> Int
exp' x 0 = 1
exp' x y = x * exp' x (y-1)

safediv :: Int -> Int -> Maybe Int
safediv _ 0 = Nothing
safediv x y = Just (x `div` y)