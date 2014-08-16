--playing cards

data Suit = Clubs | Diamonds | Hearts | Spades deriving (Eq, Ord, Show)
data Value = Number Int | Jack | Queen | King deriving (Eq, Ord)
data PlayingCard = Card Value Suit

type Pack = [PlayingCard]
type Hand = [PlayingCard]


instance Show Value where
	show (Number 1) = "Ace"
	show (Number n) = show n
	show Jack	 = "Jack"
	show Queen	 = "Queen"
	show King	 = "King"

instance Show PlayingCard where
	show (Card value suit) = 
		show value ++ " of " ++ show suit

makeCardValues :: [Value]
makeCardValues = [Number n | n <- [1..10]] ++ [Jack, Queen, King]

makePack :: [PlayingCard]
makePack = [Card val suit 
	| val <- makeCardValues, 
	suit <-[Clubs, Diamonds, Hearts, Spades]]

snap :: PlayingCard -> PlayingCard -> Bool
snap (Card val1 _) (Card val2 _) = val1 == val2

foobarPack :: Pack
foobarPack = filter greaterThanSix makePack
	where
		greaterThanSix (Card val _) = val > Number 6

snapGame :: Pack -> Pack -> Bool
snapGame p1 p2 = any cardsEqual (zip p1 p2)
	where 
		cardsEqual ((Card val _), (Card val2 _)) = val == val2 

haveAny :: Value -> Hand -> Bool
haveAny x ls = any (x==) (map cardVals ls)
	where
		cardVals (Card val _)= val 

