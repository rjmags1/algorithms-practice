# 187. Repeated DNA Sequences - Medium

The DNA sequence is composed of a series of nucleotides abbreviated as `'A'`, `'C'`, `'G'`, and `'T'`.

- For example, `"ACGAATTCCG"` is a DNA sequence.

When studying DNA, it is useful to identify repeated sequences within the DNA.

Given a string `s` that represents a DNA sequence, return all the `10`-letter-long sequences (substrings) that occur more than once in a DNA molecule. You may return the answer in any order.

##### Example 1:

```
Input: s = "AAAAACCCCCAAAAACCCCCCAAAAAGGGTTT"
Output: ["AAAAACCCCC","CCCCCAAAAA"]
```

##### Example 2:

```
Input: s = "AAAAAAAAAAAAA"
Output: ["AAAAAAAAAA"]
```

##### Constraints:

- <code>1 <= s.length <= 10<sup>5</sup></code>
- `s[i]` is either `'A'`, `'C'`, `'G'`, or `'T'`.

## Solution 1

```
# Time: O(n)
# Space: O(n)
class Solution:
    def findRepeatedDnaSequences(self, s: str) -> List[str]:
        l, n = 0, len(s)
        seen, result = defaultdict(int), []
        for r in range(9, n):
            curr = s[l:r + 1]
            if seen[curr] == 1:
                result.append(curr)
            seen[curr] += 1
            l += 1
            
        return result
```

## Notes
- This hash keys to determine if we have seen a particular 10-char substring is computed in constant time since we care about 10-char substrings, however we can get rid of the extra time associated with slicing 10-char substrings `O(n)` times.

## Solution 2

```
# Time: O(n)
# Space: O(n)
A, C, G, T = "A", "C", "G", "T"
class Solution:
    def findRepeatedDnaSequences(self, s: str) -> List[str]:
        l, n = 0, len(s)
        seen, result = defaultdict(int), []
        scores = {A:0, C:1, G:2, T:3}
        top, curr = 4 ** 10, 0
        for i, c in enumerate(s):
            if i <= 9:
                curr = 4 * curr + scores[c]
                if i == 9:
                    seen[curr] += 1
                continue
            
            curr = (4 * curr - scores[s[i - 10]] * top) + scores[c]
            seen[curr] += 1
            if seen[curr] == 2:
                result.append(s[i - 9:i + 1])
            
        return result
```

## Notes
- Since we know there are going to be at most 4 characters in a DNA sequence, we can use base 4 numbering system to compute hash keys in truly constant time. Could use mod to get rid of 11th base-4 digit from left but this will considerably slow runtime because mod not directly supported by hardware.

## Solution 3

```
# Time: O(n)
# Space: O(n)
A, C, G, T = "A", "C", "G", "T"
class Solution:
    def findRepeatedDnaSequences(self, s: str) -> List[str]:
        l, n = 0, len(s)
        seen, result = defaultdict(int), []
        mask = 0
        cleartop = 2 ** 20 - 1
        scores = {A:0, C:1, G:2, T:3}
        for i, c in enumerate(s):
            mask <<= 2
            mask |= scores[c]
            mask &= cleartop
            if i < 9:
                continue
            seen[mask] += 1
            if seen[mask] == 2:
                result.append(s[i - 9:i + 1])
        return result
```

## Notes:
- Can also just use a bitmask instead of bothering with non base-10 numbering systems. Just because we have more than `2` possibilities for each character doesn't mean we can't use a bitmask! We can just use as many bits as we need to represent each character, in this case `2` bits per character will do the trick, ie, `00` for `A`, `01` for `C`, `10` for `G`, `11` for `T`.