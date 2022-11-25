# 249. Group Shifted Strings - Medium

We can shift a string by shifting each of its letters to its successive letter.

- For example, `"abc"` can be shifted to be `"bcd"`.

We can keep shifting the string to form a sequence.

- For example, we can keep shifting `"abc"` to form the sequence: `"abc" -> "bcd" -> ... -> "xyz"`.

Given an array of strings `strings`, group all `strings[i]` that belong to the same shifting sequence. You may return the answer in any order.

##### Example 1:

```
Input: strings = ["abc","bcd","acef","xyz","az","ba","a","z"]
Output: [["acef"],["a","z"],["abc","bcd","xyz"],["az","ba"]]
```

##### Example 2:

```
Input: strings = ["a"]
Output: [["a"]]
```

##### Constraints:

- `1 <= strings.length <= 200`
- `1 <= strings[i].length <= 50`
- `strings[i]` consists of lowercase English letters.

## Solution

```
# Time: O(nm)
# Space: O(nm)
class Solution:
    def groupStrings(self, strings: List[str]) -> List[List[str]]:
        offset = ord('a')
        def dist(c1, c2):
            score1 = ord(c1) - offset + 1
            score2 = ord(c2) - offset + 1
            if score2 >= score1:
                return score2 - score1
            return 26 - (score1 - score2)
        
        def distances(s):
            distances = []
            for i in range(len(s) - 1):
                distances.append(dist(s[i], s[i + 1]))
            return tuple(distances)
        
        groups = defaultdict(list)
        for s in strings:
            groups[distances(s)].append(s)
        return groups.values()
```

## Notes
- Trickier than it seems, but words in the same groups have the same distances between adjacent characters. We need to be careful about how we calculate distances, as our letter sequence is circular for this problem.