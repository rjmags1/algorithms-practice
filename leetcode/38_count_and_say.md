# 38. Count and Say - Medium

The count-and-say sequence is a sequence of digit strings defined by the recursive formula:

- `countAndSay(1) = "1"`
- `countAndSay(n)` is the way you would "say" the digit string from `countAndSay(n-1)`, which is then converted into a different digit string.

To determine how you "say" a digit string, split it into the minimal number of substrings such that each substring contains exactly one unique digit. Then for each substring, say the number of digits, then say the digit. Finally, concatenate every said digit.

Given a positive integer `n`, return the `nth` term of the count-and-say sequence.

##### Example 1:

```
Input: n = 1
Output: "1"
Explanation: This is the base case.
```

##### Example 2:

```
Input: n = 4
Output: "1211"
Explanation:
countAndSay(1) = "1"
countAndSay(2) = say "1" = one 1 = "11"
countAndSay(3) = say "11" = two 1's = "21"
countAndSay(4) = say "21" = one 2 + one 1 = "12" + "11" = "1211"
```

##### Constraints:

- `1 <= n <= 30`

## Solution

```
# Time: O(4^(n/3))
# Space: O(4^(n/3))
class Solution:
    def countAndSay(self, n: int) -> str:
        curr = [1]
        for i in range(1, n):
            nxt = []
            j, n = 0, len(curr)
            while j < n:
                count = 0
                k = j
                while k < n and curr[k] == curr[j]:
                    count += 1
                    k += 1
                nxt.append(count)
                nxt.append(curr[j])
                j = k
            curr = nxt
        
        return "".join([str(num) for num in curr])
```

## Notes
- The space and time complexities come from a non-trivial proof that is beyond the scope of an interview.


## Solution - C++
```
// Time: O(4^(n / 3))
// Space: O(4^(n / 3))
class Solution {
public:
    string countAndSay(int n) {
        string seq = "1";
        string next;
        for (int i = 2; i <= n; i++) {
            next = "";
            int m = seq.size();
            int j = 0;
            while (j < m) {
                int k;
                for (k = j + 1; k < m; k++) {
                    if (seq[k] != seq[j]) {
                        break;
                    }
                }
                next.append(to_string(k - j));
                next.push_back(seq[j]);
                j = k;
            }

            seq = next;
        }

        return seq;
    }
};
```
