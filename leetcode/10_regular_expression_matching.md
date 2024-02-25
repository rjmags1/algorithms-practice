# 10. Regular Expression Matching - Hard

Given an input string `s` and a pattern `p`, implement regular expression matching with support for `'.'` and `'*'` where:

- `'.'` Matches any single character.​​​​
- `'*'` Matches zero or more of the preceding element.

The matching should cover the entire input string (not partial).

##### Example 1:

```
Input: s = "aa", p = "a"
Output: false
Explanation: "a" does not match the entire string "aa".
```

##### Example 2:

```
Input: s = "aa", p = "a*"
Output: true
Explanation: '*' means zero or more of the preceding element, 'a'. Therefore, by repeating 'a' once, it becomes "aa".
```

##### Example 3:

```
Input: s = "ab", p = ".*"
Output: true
Explanation: ".*" means "zero or more (*) of any character (.)".
```


##### Constraints:

- `1 <= s.length <= 20`
- `1 <= p.length <= 30`
- `s` contains only lowercase English letters.
- `p` contains only lowercase English letters, `'.'`, and `'*'`.
- It is guaranteed for each appearance of the character `'*'`, there will be a previous valid character to match.


## Solution - Python
```
# Time: O(m * n)
# Space: O(m * n)
class Solution:
    def isMatch(self, s: str, p: str) -> bool:
        m, n = len(s), len(p)

        @cache
        def dp(i, j):
            if j == n:
                return i == m
            
            match = i < m and (p[j] == s[i] or p[j] == '.')
            if j + 1 < n and p[j + 1] == '*':
                return dp(i, j + 2) or (match and dp(i + 1, j))
            return match and dp(i + 1, j + 1)
        
        return dp(0, 0)
```

## Notes
- Good example of top-down recursive solution that can be optimized with caching. We check each possible pair of text and pattern indices once with appropriate caching. At each representative subpattern and substring we can make a determination about if the current subpattern matches the current substring based on `i`, `j`, and the results of forward calls down the recursive call tree. 
- Again, note how the match status of a particular substring and subpattern depends on if there are relevant matches within the rest of the substring and subpattern (forward recursive calls). We must know about the match status of smaller substrings and subpatterns that end at the end of the input string and pattern in order to determine the match status of larger substrings and subpatterns that end at the end of the input string and pattern.

## Solution - C++

```
#include <unordered_map>
#include <string>

using namespace std;

class Solution {
private:
    unordered_map<string, bool> memo;
    int m;
    int n;
    
public:
    // Time: O(n * m)
    // Space: O(n * m)
    bool isMatch(string s, string p) {
        /*
        base cases:
            - si == m, pi < n -> rest of p is *
            - si == m, pi == n -> true
            - si < m, pi == n -> 
                if rest of string is p[pi - 2] and p[pi - 1] == '*'
        */
        m = s.length();
        n = p.length();
        return rec(0, 0, s, p);
    }

    bool rec(int si, int pi, string& s, string& p) {
        string key = to_string(si) + "," + to_string(pi);
        if (memo.contains(key)) {
            return memo[key];
        }

        if (pi == n) {
            if (si == m) {
                memo[key] = true;
            }
            else {
                memo[key] = n > 1 && p[pi - 1] == '*' && p[pi - 2] == s[si] && rec(si + 1, pi, s, p);
            }
        }
        else if (si == m) {
            memo[key] = pi < n - 1 && p[pi + 1] == '*' && rec(si, pi + 2, s, p);
        }
        else {
            bool match = p[pi] == '.' || s[si] == p[pi];
            if (pi < n - 1 && p[pi + 1] == '*') {
                memo[key] = rec(si, pi + 2, s, p) || (match && rec(si + 1, pi, s, p));
            }
            else {
                memo[key] = match && rec(si + 1, pi + 1, s, p);
            }
        }

        return memo[key];
    }
}
```