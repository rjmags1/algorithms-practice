# 306. Additive Number - Medium

An additive number is a string whose digits can form an additive sequence.

A valid additive sequence should contain at least three numbers. Except for the first two numbers, each subsequent number in the sequence must be the sum of the preceding two.

Given a string containing only digits, return `true` if it is an additive number or `false` otherwise.

Note: Numbers in the additive sequence cannot have leading zeros, so sequence `1, 2, 03` or `1, 02, 3` is invalid.

##### Example 1:

```
Input: "112358"
Output: true
Explanation: 
The digits can form an additive sequence: 1, 1, 2, 3, 5, 8. 
1 + 1 = 2, 1 + 2 = 3, 2 + 3 = 5, 3 + 5 = 8
```

##### Example 2:

```
Input: "199100199"
Output: true
Explanation: 
The additive sequence is: 1, 99, 100, 199. 
1 + 99 = 100, 99 + 100 = 199
```

##### Constraints:

- `1 <= num.length <= 35`
- `num` consists only of digits.

Follow-up: How would you handle overflow for very large input integers?

## Solution

```
# Time: O(n^4)
# Space: O(n)
class Solution:
    def isAdditiveNumber(self, num: str) -> bool:
        n = len(num)
        def rec(k):
            for i in range(k + 2, n):
                if i != n - 1 and num[i] == "0":
                    continue
                for j in range(k + 1, i):
                    op1, op2 = num[k:j], num[j:i]
                    if len(op1) > 1 and op1[0] == "0":
                        continue
                    if len(op2) > 1 and op2[0] == "0":
                        continue
                    mol = max(len(op1), len(op2))
                    nocarry = int(num[i:i + mol])
                    carry = int(num[i:i + mol + 1])
                    curr = int(op1) + int(op2)
                    if curr == nocarry:
                        if n == i + mol or rec(j):
                            return True
                    if curr == carry:
                        if n == i + mol + 1 or rec(j):
                            return True
                        
            return False
        
        return rec(0)
```

## Notes
- This problem is trickier than it seems, we need to check all partitions of the small prefixes of the current substring for valid operands that sum to part of the corresponding suffix. We also need to recurse forward correctly, in a sliding window fashion, which is a little funky. The way we check for valid partitions (if `carry` or `nocarry` are a suffix and match the sum of the current operands) is easy to miss or implement wrong.
- For the followup, with python integers can be arbitrarily long. If I was using a different language I would say something along the lines of performing string addition, i.e., add digit wise without converting to int, which is doable. There is an official leetcode question that addresses this exact problem, 415. Add Strings. 