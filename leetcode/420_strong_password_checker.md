# 420. Strong Password Checker - Hard

A password is considered strong if the below conditions are all met:

- It has at least `6` characters and at most `20` characters.
- It contains at least one lowercase letter, at least one uppercase letter, and at least one digit.
- It does not contain three repeating characters in a row (i.e., `"Baaabb0"` is weak, but `"Baaba0"` is strong).

Given a string `password`, return the minimum number of steps required to make `password` strong. If `password` is already strong, return `0`.

In one step, you can:

- Insert one character to `password`,
- Delete one character from `password`, or
- Replace one character of `password` with another character.


##### Example 1:

```
Input: password = "a"
Output: 5
```

##### Example 2:

```
Input: password = "aA1"
Output: 3
```

##### Example 3:

```
Input: password = "1337C0d3"
Output: 0
```

##### Constraints:

- `1 <= password.length <= 50`
- `password` consists of letters, digits, dot `'.'` or exclamation mark `'!'`.

## Solution

```
import itertools
from collections import Counter

# Time: O(n^2)
# Space: O(n)
class Solution:
    def strongPasswordChecker(self, password: str) -> int:
        n, missing = len(password), 0
        if not any(c.isupper() for c in password):
            missing += 1
        if not any(c.islower() for c in password):
            missing += 1
        if not any(c.isdigit() for c in password):
            missing += 1
        if n < 6:
            return max(6 - n, missing)
        
        def minreps(p):
            nonlocal missing
            groups = [len(list(g)) for k, g in itertools.groupby(p)]
            result = 0
            for i, g in enumerate(groups):
                if g > 2:
                    # eliminate triplets optimally by replacing every third
                    replacements = g // 3 
                    result += replacements
                    if missing > 0:
                        # replace optimally to handle missing chars at same time
                        missing = max(0, missing - replacements) 
            return result + missing
        
        def delmaxkey(x, caps, lower, digits):
            freq, letter = x
            if freq > 2:
                # prefer to delete from triplets such that we minimize replacements
                return -(x[0] % 3) 
            if freq == 2:
                # if no triplets to delete from, delete such that we avoid potentially
                # creating triplets by maintaining single letters as 'separators'
                return -98
            if freq == 1:
                # if not doublets or triplets, delete such that we don't remove the only
                # instance of a required character type
                if letter.isupper():
                    return -100 if len(caps) > 1 or caps[letter] > 1 else -101
                if letter.islower():
                    return -100 if len(lower) > 1 or lower[letter] > 1 else -101
                if letter.isdigit():
                    return -100 if len(digits) > 1 or digits[letter] > 1 else -101
                return -99

            return -102 # returned for groups that have already been completely removed

        def optimaldels(p):
            nonlocal missing
            caps = Counter(l for l in p if l.isupper())
            lower = Counter(l for l in p if l.islower())
            digits = Counter(l for l in p if l.isdigit())
            groups = [[len(list(g)), k] for k, g in itertools.groupby(password)]
            # groups for aaabbbcc will be [[3, a], [3, b], [2, c]]
            dels = n - 20
            while dels:
                delgroup = max(groups, key= lambda x: delmaxkey(x, caps, lower, digits))
                delgroup[0] -= 1
                freq, letter = delgroup
                if letter.isupper():
                    caps[letter] -= 1
                    if caps[letter] == 0:
                        caps.pop(letter)
                        missing += int(len(caps) == 0)
                elif letter.islower():
                    lower[letter] -= 1
                    if lower[letter] == 0:
                        lower.pop(letter)
                        missing += int(len(lower) == 0)
                elif letter.isdigit():
                    digits[letter] -= 1
                    if digits[letter] == 0:
                        digits.pop(letter)
                        missing += int(len(digits) == 0)
                dels -= 1

            return "".join(letter * q for q, letter in groups)

        return minreps(password) if n <= 20 else n - 20 + minreps(optimaldels(password))
```

## Notes
- This is a very difficult greedy problem, took me a couple hours to understand how all of the different greedy heuristics work together. There are much more succinct solutions that are also better in terms of complexity but this solution is more idiomatic in my opinion.
- For `n < 6`, we can always insert (and maybe replace) any missing characters in the optimal position such that handling this case is trivial. For `6 <= n <= 20` we always replace in the optimal position for each replacement such that we minimize the number of replacements. This entails replacing every third character of repeat sequences, initially with any missing character types, because this minimizes the number of replacements to get rid of all triplets while also simultaneously handling missing character types if there are any. For `n > 20`, we want to delete optimally such that we minimize the number of replacements, and then apply the same replacement strategy as for `6 <= n <= 20` once we get the password length down to 20. The deletion heuristic takes into account deleting such that we minimize eventual replacements (whenever grouplen % 3 == 0 we can reduce eventual replacements by one by deleting from this group), avoiding accidentally creating previously nonexistent repeats, and avoiding deleting all of a required character type.