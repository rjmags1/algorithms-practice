# 125. Valid Palindrome - Easy

A phrase is a palindrome if, after converting all uppercase letters into lowercase letters and removing all non-alphanumeric characters, it reads the same forward and backward. Alphanumeric characters include letters and numbers.

Given a string `s`, return `true` if it is a palindrome, or `false` otherwise.

##### Example 1:

```
Input: s = "A man, a plan, a canal: Panama"
Output: true
Explanation: "amanaplanacanalpanama" is a palindrome.
```

##### Example 2:

```
Input: s = "race a car"
Output: false
Explanation: "raceacar" is not a palindrome.
```

##### Example 3:

```
Input: s = " "
Output: true
Explanation: s is an empty string "" after removing non-alphanumeric characters.
Since an empty string reads the same forward and backward, it is a palindrome.
```

##### Constraints:

- <code>1 <= s.length <= 2 * 10<sup>5</sup></code>
- `s` consists only of printable ASCII characters.

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def isPalindrome(self, s: str) -> bool:
        i, j = 0, len(s) - 1
        while i < j:
            c1, c2 = s[i], s[j]
            skip1 = not (c1.isdigit() or c1.isalpha())
            skip2 = not (c2.isdigit() or c2.isalpha())
            if skip1 or skip2:
                if skip1: 
                    i += 1
                if skip2:
                    j -= 1
                continue
            
            if c1.lower() != c2.lower():
                return False
            i += 1
            j -= 1
            
        return True
```

## Notes
- This is a trivial problem, as long as you are not careful about reading the prompt and skipping the correct characters (anything that is not a digit or letter).