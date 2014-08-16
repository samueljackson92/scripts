--Haskell Assessment 1
import Data.Char
type Title = String -- for example "Great Expectations"
type Author = String -- for example "Charles Dickens"
type ISBN = String -- for example "123456789X"

type Book = (Title, Author, ISBN)
type Books = [Book]

isShakespeare :: Book -> Bool
isShakespeare (_, author, _) = author == "William Shakespeare" 

booksByAuthor :: Author -> Books -> Books
booksByAuthor a b = filter (byAuthor a) b
	where
		byAuthor a (_, author, _) = a == author
		
avalible ::Title -> Books -> Bool
avalible title [] = False
avalible title (x:xs) = 
	if trippleFst x == title
	then True
	else avalible title xs
	where
		trippleFst (x,_,_) = x
		
sumISBN :: ISBN -> Int
sumISBN isbn = sum (zipWith(*) [2..10] (map digitToInt (tail (reverse isbn))))
	where 
		charToInt :: Char -> Int
		charToInt x = digitToInt x
		
data StockItem = StockItem Book Supplier Price
type Price = Double
type Supplier = String

priceThreeBooks :: StockItem -> StockItem -> StockItem -> Price
priceThreeBooks (StockItem _ _ a) (StockItem _ _ b) (StockItem _ _ c) = 
	sum [a,b,c] - (findMin a b c)
	where
		findMin a b c = min c (min a b)


