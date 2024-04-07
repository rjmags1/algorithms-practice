# 30. Substring with Concatenation of All Words - Hard

You are given a string `s` and an array of strings `words`. All the strings of `words` are of the same length.

A concatenated substring in `s` is a substring that contains all the strings of any permutation of `words` concatenated.

- For example, if `words = ["ab","cd","ef"]`, then `"abcdef"`, `"abefcd"`, `"cdabef"`, `"cdefab"`, `"efabcd"`, and `"efcdab"` are all concatenated strings. `"acdbef"` is not a concatenated substring because it is not the concatenation of any permutation of words.

Return the starting indices of all the concatenated substrings in `s`. You can return the answer in any order.

##### Example 1:

```
Input: s = "barfoothefoobarman", words = ["foo","bar"]
Output: [0,9]
Explanation: Since words.length == 2 and words[i].length == 3, the concatenated substring has to be of length 6.
The substring starting at 0 is "barfoo". It is the concatenation of ["bar","foo"] which is a permutation of words.
The substring starting at 9 is "foobar". It is the concatenation of ["foo","bar"] which is a permutation of words.
The output order does not matter. Returning [9,0] is fine too.
```

##### Example 2:

```
Input: s = "wordgoodgoodgoodbestword", words = ["word","good","best","word"]
Output: []
Explanation: Since words.length == 4 and words[i].length == 4, the concatenated substring has to be of length 16.
There is no substring of length 16 is s that is equal to the concatenation of any permutation of words.
We return an empty array.
```

##### Example 3:

```
Input: s = "barfoofoobarthefoobarman", words = ["bar","foo","the"]
Output: [6,9,12]
Explanation: Since words.length == 3 and words[i].length == 3, the concatenated substring has to be of length 9.
The substring starting at 6 is "foobarthe". It is the concatenation of ["foo","bar","the"] which is a permutation of words.
The substring starting at 9 is "barthefoo". It is the concatenation of ["bar","the","foo"] which is a permutation of words.
The substring starting at 12 is "thefoobar". It is the concatenation of ["the","foo","bar"] which is a permutation of words.
```

##### Constraints:

- <code>1 <= s.length <= 10<sup>4</sup></code>
- `1 <= words.length <= 5000`
- `1 <= words[i].length <= 30`
- `s` and `words[i]` consist of lowercase English letters.

## Solution

```
# Time: O(n + m * k) where m = len(s), n = len(words), and k = wordLength
# Space: O(n + k)
class Solution:
    def findSubstring(self, s: str, words: List[str]) -> List[int]:
        m, n = len(s), len(words)
        wordLength = len(words[0])
        freqs = Counter(words)
        needCorrectFreqs = len(freqs)
        result = []
        def scan(start):
            correctFreqs = 0
            have = defaultdict(int)
            for stop in range(start + wordLength, m + 1, wordLength):
                currStart = stop - wordLength
                curr = s[currStart:stop]
                if curr not in freqs:
                    for i in range(start, currStart, wordLength):
                        removed = s[i:i + wordLength]
                        have[removed] -= 1
                        if have[removed] == freqs[removed]:
                            correctFreqs += 1
                        elif have[removed] == freqs[removed] - 1:
                            correctFreqs -= 1
                    start = stop
                    continue
                
                have[curr] += 1
                if have[curr] == freqs[curr] + 1:
                    correctFreqs -= 1
                    while have[curr] == freqs[curr] + 1:
                        removed = s[start:start + wordLength]
                        have[removed] -= 1
                        if have[removed] == freqs[removed]:
                            correctFreqs += 1
                        elif have[removed] == freqs[removed] - 1:
                            correctFreqs -= 1
                        start += wordLength
                    continue
                        
                if have[curr] == freqs[curr]:
                    correctFreqs += 1
                
                if correctFreqs == needCorrectFreqs:
                    result.append(start)
                    removed = s[start:start + wordLength]
                    have[removed] -= 1
                    correctFreqs -= 1
                    start += wordLength
            
        for start in range(wordLength):
            scan(start)
        return result
```

## Notes
- This problem is hard if you haven't done many sliding window problems before. Coming up with the `scan` function alone is tricky, because it is important to correctly track the change in `correctFreqs` whenever a new word from `words` is added or removed from `have`. It is also tricky to figure out how the window should expand and shrink depending on if `curr` is not a word in `words`, if `curr` is in `words` but is excessively present in the current window, as well as when `correctFreqs == needCorrectFreqs`.
- Coming up with the `scan` function is the hardest part of this problem, but it is frustrating if you get to that point (like I did), and then realize that you haven't handled cases where our input `s` has words in `words` at indices in `s` indivisible by `wordLength`. To efficiently consider all possible windows containing the desired permutations of `words`, all we need to do is start our call to `scan` at each index offset that could generate a unique window during `scan`ning. We don't want to end up considering the same windows twice in successive calls to `scan`.

## Solution - C++

```
#include <unordered_map>
#include <vector>
#include <string>
#include <string_view>

class Solution {
public:
    vector<int> findSubstring(string s, vector<string>& words) {
        m = s.size();
        n = words.size();
        wlen = words[0].size();
        sslen = wlen * n;
        freqs.clear();
        for (auto& w : words) {
            freqs[w]++;
        }

        vector<int> result;
        for (int start = 0; start < wlen; start++) {
            scan(start, result, s);
        }

        return result;
    }

private:
    int m, n, wlen, sslen;
    unordered_map<string_view, int> freqs;

    void scan(int start, vector<int>& result, string& s) {
        int incorrectFreqs = freqs.size();
        unordered_map<string_view, int> need = freqs;
        int prevStart = start;
        for (int stop = start + wlen; stop < m + 1; stop += wlen) {
            int currStart = stop - wlen;
            string_view curr(s.data() + currStart, stop - currStart);
            if (!need.contains(curr)) {
                for (int i = prevStart; i < currStart; i += wlen) {
                    string_view removed(s.data() + i, wlen);
                    need[removed]++;
                    if (need[removed] == 0) {
                        incorrectFreqs--;
                    }
                    else if (need[removed] == 1) {
                        incorrectFreqs++;
                    }
                }
                prevStart = stop;
                continue;
            }

            need[curr]--;
            if (need[curr] == -1) {
                incorrectFreqs++;
                while (need[curr] == -1) {
                    string_view removed(s.data() + prevStart, wlen);
                    need[removed]++;
                    if (need[removed] == 0) {
                        incorrectFreqs--;
                    }
                    else if (need[removed] == 1) {
                        incorrectFreqs++;
                    }
                    prevStart += wlen;
                }
                continue;
            }

            if (need[curr] == 0) {
                incorrectFreqs--;
            }
            if (incorrectFreqs == 0) {
                result.push_back(prevStart);
                string_view removed(s.data() + prevStart, wlen);
                need[removed]++;
                incorrectFreqs++;
                prevStart += wlen;
            }
        }
    }
};
```

## Notes
- 12ms first sub, beats 99%
- Many non-official solutions say they use correct sliding window technique, when in fact they do not.
