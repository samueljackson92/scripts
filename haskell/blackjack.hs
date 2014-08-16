--blackjack
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

blackJack :: Hand -> Int
blackJack ls = sum (map cardVal ls)
	where 
		cardVal (Card val _) = val
