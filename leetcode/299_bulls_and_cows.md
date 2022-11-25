# 299. Bulls and Cows - Medium

You are playing the Bulls and Cows game with your friend.

You write down a secret number and ask your friend to guess what the number is. When your friend makes a guess, you provide a hint with the following info:

- The number of "bulls", which are digits in the guess that are in the correct position.
- The number of "cows", which are digits in the guess that are in your secret number but are located in the wrong position. Specifically, the non-bull digits in the guess that could be rearranged such that they become bulls.

Given the secret number `secret` and your friend's guess `guess`, return the hint for your friend's guess.

The hint should be formatted as `"xAyB"`, where `x` is the number of bulls and `y` is the number of cows. Note that both `secret` and `guess` may contain duplicate digits.

##### Example 1:

```
Input: secret = "1807", guess = "7810"
Output: "1A3B"
Explanation: Bulls are connected with a '|' and cows are underlined:
"1807"
  |
"7810"
```

##### Example 2:

```
Input: secret = "1123", guess = "0111"
Output: "1A1B"
Explanation: Bulls are connected with a '|' and cows are underlined:
"1123"        "1123"
  |      or     |
"0111"        "0111"
Note that only one of the two unmatched 1s is counted as a cow since the non-bull digits can only be rearranged to allow one 1 to be a bull.
```

##### Constraints:

- `1 <= secret.length, guess.length <= 1000`
- `secret.length == guess.length`
- `secret` and `guess` consist of digits only.

## Solution 1

```
# Time: O(n) (3-pass)
# Space: O(c) where c is size of charset
class Solution:
    def getHint(self, secret: str, guess: str) -> str:
        maybecows = Counter(secret)
        bulls = 0
        for i, c in enumerate(secret):
            if guess[i] == c:
                bulls += 1
                maybecows[c] -= 1
                
        cows = 0
        for i, c in enumerate(guess):
            if c in maybecows and maybecows[c] > 0 and c != secret[i]:
                cows += 1
                maybecows[c] -= 1
                
        return f"{bulls}A{cows}B"
```

## Notes
- Naive approach where we get the frequency of characters in `secret`, then count the number of bulls in a second pass. During this second pass we also decrement the frequency of any bulls because these frequencies will represent the number of non-bulls in `secret` that could potentially be cows. Finally in a third pass, we iterate over `guess` and see if any non-bull characters in `guess` can be used to form a cow. We need to be careful to not overassign extra characters in `guess` as cows when there are more potential cows in `guess` than the number of non-bulls of a character in `secret`.

## Solution 2

```
# Time: O(n) (2-pass)
# Space: O(c)
class Solution:
    def getHint(self, secret: str, guess: str) -> str:
        needmatch = Counter(secret)
        bulls = cows = 0
        for i, c in enumerate(guess):
            if c not in needmatch:
                continue
                
            if c == secret[i]:
                bulls += 1
                if needmatch[c] <= 0:
                    cows -= 1
            else:
                if needmatch[c] > 0:
                    cows += 1
            needmatch[c] -= 1
                
        return f"{bulls}A{cows}B"
```

## Notes
- We can use the idea of characters in `secret` needing a match. Anytime we encounter a character in `guess` that is also in `secret`, it can be used to match an occurrence of that character in `secret` that has not been matched yet, AKA we use the character as a cow. We need to watch out for the case where we have a bull, because if there are more of the bull character in `guess` than there is in `secret` it is possible we prematurely match all of the `secret` characters before we encounter bulls.