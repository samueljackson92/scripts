--sieve


sieve (n:ns) = n : sieve (filter (notDivBy n) ns)
	where
		notDivBy d num = (num `mod` d) /= 0
		
primes = sieve [2..]