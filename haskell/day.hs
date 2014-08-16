data Day = Mon | Tues | Weds | Thurs | Fri | Sat | Sun deriving (Eq, Ord, Show)

intToDay :: Int -> Maybe Day
intToDay x =
	if x > 7 || x < 1 
		then Nothing
		else getDay x
	where
		getDay x = lookup x getDays
		getDays = zip [1..7] [Mon, Tues, Weds, Thurs, Fri, Sat, Sun]

