# 336. Palindrome Pairs - Hard

You are given a 0-indexed array of unique strings `words`.

A palindrome pair is a pair of integers `(i, j)` such that:

- `0 <= i, j < word.length`,
- `i != j`, and
- `words[i] + words[j]` (the concatenation of the two strings) is a palindrome.

Return an array of all the palindrome pairs of `words`.

##### Example 1:

```
Input: words = ["abcd","dcba","lls","s","sssll"]
Output: [[0,1],[1,0],[3,2],[2,4]]
Explanation: The palindromes are ["abcddcba","dcbaabcd","slls","llssssll"]
```

##### Example 2:

```
Input: words = ["bat","tab","cat"]
Output: [[0,1],[1,0]]
Explanation: The palindromes are ["battab","tabbat"]
```

##### Example 3:

```
Input: words = ["a",""]
Output: [[0,1],[1,0]]
Explanation: The palindromes are ["a","a"]
```

##### Constraints:

- `1 <= words.length <= 5000`
- `0 <= words[i].length <= 300`
- `words[i]` consists of lowercase English letters.

## Solution 1

```
# Time: O(nm^2)
# Space: O(nm)
class Solution:
    def palrange(self, word, i, j):
        while i < j:
            if word[i] != word[j]:
                return False
            i += 1
            j -= 1
        return True
    
    def palindromePairs(self, words: List[str]) -> List[List[int]]:
        h = {word:i for i, word in enumerate(words)}
        result = set()
        for i, word in enumerate(words):
            rev, n = word[::-1], len(word)
            if rev in h and i != h[rev]:
                result.add((i, h[rev]))
            for j in range(n):
                if self.palrange(word, 0, j):
                    revsuff = word[j + 1:][::-1]
                    if revsuff in h:
                        result.add((h[revsuff], i))
            for j in range(n):
                if self.palrange(word, j, n - 1):
                    revpre = word[:j][::-1]
                    if revpre in h: 
                        result.add((i, h[revpre]))
            
        return [list(t) for t in result]
```

## Notes
- This naive approach involves checking every possible concatenation, which would be <code>O(n<sup>2</sup>m)</code> time and definitely cause a TLE. We need a way to obtain <code>O(m<sup>2</sup>n)</code> time or better. One alternative approach that comes to mind is to check all possible prefixes or matching reversed suffixes for concatenated prefixes and suffixes match each other. This would TLE because we would have to iterate over <code>O(nm<sup>2</sup>)</code> prefixes, lookup rev suffixes in a hash table, and then make sure the resulting concatenation has a palindromic center (this `O(m)` time center check is what will cause TLE). 
- Along the same lines, if we only considered relevant palindromic centers (palindromic prefixes and suffixes) for all words and then perform hash table lookup on the reversals of resulting suffixes/prefixes, we would be able to achieve<code>O(nm<sup>2</sup>)</code>. This is the approach shown above. 
- Note that this solution will actually TLE because of strict runtime restrictions on leetcode, leetcode runtime inconsistency, and python slowness; the exact same solution (see below) that uses slices to check for palindromic prefixes and suffixes will pass at widely varying runtime percentile. As far as I can tell this phenomenon is due to the `palrange` function above getting interpreted everytime its called, i.e., each of its lines gets parsed and passed through various other interpretation related code before being executed, whereas with slices there is less to interpret, and I am sure there are python-internal runtime optimizations around slices that make it much faster.

## Solution 2

```
# Time: O(nm^2)
# Space: O(nm)
class Solution:
    def palindromePairs(self, words: List[str]) -> List[List[int]]:
        h = {word:i for i, word in enumerate(words)}
        
        result = set()
        for i, word in enumerate(words):
            rev, n = word[::-1], len(word)
            if rev in h and i != h[rev]:
                result.add((i, h[rev]))
            for j in range(n):
                if word[:j + 1] == word[:j + 1][::-1]:
                    revsuff = word[j + 1:][::-1]
                    if revsuff in h:
                        result.add((h[revsuff], i))
            for j in range(n):
                if word[j:] == word[j:][::-1]:
                    revpre = word[:j][::-1]
                    if revpre in h: 
                        result.add((i, h[revpre]))
            
        return [list(t) for t in result]
```

## Notes
- The slices vs. `palrange` function is the only difference between this solution and the above, but it is the difference between TLE everytime and passing everytime, often in `60+` percentile. Just goes to show how much of a difference runtime optimizations for interpreted languages can make, as well as the runtime overhead associated with interpretation.
- Note one could also use a trie to store words for lookup instead of `h` hash table. This would cut down on space and make the algorithm more extensible to a situation where words are continuously added to `words` over time and we call `palindromePairs` intermittently.