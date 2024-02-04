# 5. Longest Palindromic Substring - Medium

Given a string `s`, return the longest palindromic substring in `s`.

A string is called a palindrome string if the reverse of that string is the same as the original string.

##### Example 1:

```
Input: s = "babad"
Output: "bab"
Explanation: "aba" is also a valid answer.
```

##### Example 2:

```
Input: s = "cbbd"
Output: "bb"
```


##### Constraints:

- `1 <= s.length <= 1000`
- `s` consist of only digits and English letters.


## Solution 1 - Python
```
# Time: O(n^2)
# Space: O(1)
class Solution:
    def palBounds(self, s, i, j):
        n = len(s)
        while i >= 0 and j < n and s[i] == s[j]:
            i -= 1
            j += 1
        return (i + 1, j - 1)
    
    def longestPalindrome(self, s: str) -> str:
        start, stop = 0, 0
        for i in range(len(s) - 1):
            oddStart, oddStop = self.palBounds(s, i, i)
            if oddStop - oddStart > stop - start:
                start, stop = oddStart, oddStop
            evenStart, evenStop = self.palBounds(s, i, i + 1)
            if evenStop - evenStart > stop - start:
                start, stop = evenStart, evenStop
        return s[start:stop + 1]
```

#### Notes
- Notice the low string length constraint... implies a quadratic solution should be acceptable.
- Fairly straightforward, just don't forget to consider odd and even length palidromes.

## Solution 2 - Python
```
# Time: O(n)
# Space: O(n)
class Solution:
    def longestPalindrome(self, s: str) -> str:
        t = []
        for c in s:
            t.append('#')
            t.append(c)
        t.append('#')

        n = len(t)
        lps = [0] * n
        lps[0] = 1

        # C -> center, R -> radius
        C, longest = 0, 1
        for i in range(1, n):
            length = 1
            if C + longest > i:
                R = C - (i - C)
                length = min(lps[R], C + longest - i)

            while i + length < n and i - length >= 0:
                if t[i + length] != t[i - length]:
                    break
                length += 1

            if length > longest:
                longest = length
                C = i

            lps[i] = length

        # remove the extra #
        longest = longest - 1
        start = (C - 1) // 2 - (longest - 1) // 2
        return s[start:start + longest]
```

#### Notes
- This is Manacher's algorithm, and is the polar opposite of trivial to come up with from scratch in an interview setting. If interviewers want to see a linear solution to the longest palindromic substring problem, you need to have this code memorized, or have a very strong conceptual understanding of how it works to come up with the code.
- Manacher's cuts down on the time complexity by exploiting palindromes that contain other palindromes. Its wikipedia article explains it well: https://en.wikipedia.org/wiki/Longest_palindromic_substring#Manacher's_algorithm.

## Solution - C++

```
#include <string>

using namespace std;

// Time: O(n^2)
// Space: O(1)
class Solution {
public:
    string longestPalindrome(string s) {
        int l = 0, r = 0;
        const int n = s.size();
        int subPalBounds[2];
        for (int center = 0; center < n - 1; center++) {
            longestPalAtCenter(s, center, n, subPalBounds);
            if (subPalBounds[1] - subPalBounds[0] > r - l) {
                l = subPalBounds[0], r = subPalBounds[1];
            }
            cout << subPalBounds[0] << " " << subPalBounds[1] << endl;
            cout << l << " " << r << endl;
        }
        return s.substr(l, r - l + 1);
    }

private:
    void longestPalAtCenter(const string& s, int i, int n, int result[2]) {
        int l1 = i, r1 = i, l2 = i, r2 = i + 1;
        bool done1 = false, done2 = false;
        int left1 = i, right1 = i, left2 = i, right2 = i;
        while (!done1 || !done2) {
            if (l1 < 0 || r1 == n || s[l1] != s[r1]) {
                done1 = true;
            }
            else {
                left1 = l1--, right1 = r1++;
            }
            if (l2 < 0 || r2 == n || s[l2] != s[r2]) {
                done2 = true;
            }
            else {
                left2 = l2--, right2 = r2++;
            }
        }

        if (right1 - left1 > right2 - left2) {
            result[0] = left1;
            result[1] = right1;
        }
        else {
            result[0] = left2;
            result[1] = right2;
        }
    }
};
```