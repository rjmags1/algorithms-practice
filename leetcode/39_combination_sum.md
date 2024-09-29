# 39. Combination Sum - Medium

Given an array of distinct integers `candidates` and a target integer `target`, return a list of all unique combinations of `candidates` where the chosen numbers sum to `target`. You may return the combinations in any order.

The same number may be chosen from `candidates` an unlimited number of times. Two combinations are unique if the frequency of at least one of the chosen numbers is different.

The test cases are generated such that the number of unique combinations that sum up to `target` is less than `150` combinations for the given input.

##### Example 1:

```
Input: candidates = [2,3,6,7], target = 7
Output: [[2,2,3],[7]]
Explanation:
2 and 3 are candidates, and 2 + 2 + 3 = 7. Note that 2 can be used multiple times.
7 is a candidate, and 7 = 7.
These are the only two combinations.
```

##### Example 2:

```
Input: candidates = [2,3,5], target = 8
Output: [[2,2,2,2],[2,3,3],[3,5]]
```

##### Example 3:

```
Input: candidates = [2], target = 1
Output: []
```

##### Constraints:

- `1 <= candidates.length <= 30`
- `2 <= candidates[i] <= 40`
- All elements of candidates are distinct.
- `1 <= target <= 40`

## Solution

```
# Time: O(n^(t/m)) where n == len(candidates), t == target, m == min(candidates)
# Space: O(t/m)
class Solution:
    def combinationSum(self, candidates: List[int], target: int) -> List[List[int]]:
        result, builder = [], []
        n = len(candidates)
        def rec(i, curr):
            if curr == target:
                result.append(builder[:])
                return
            
            for j in range(i, n):
                num = candidates[j]
                newSum = num + curr
                if newSum <= target:
                    builder.append(num)
                    rec(j, newSum)
                    builder.pop()
            
        rec(0, 0)
        return result
```

## Notes
- For each candidate, there will never be more than `t/m` recursive calls as we build a combination sum using that number. The exponent in problems involving n-ary recursive call trees is always the max recursive call depth.
- We could improve the runtime of this solution by adding recursive call tree pruning by postfix sums to `target - curr`.

## Solution 

```
class Solution {
public:
    vector<vector<int>> combinationSum(vector<int>& candidates, int target) {
        vector<vector<int>> result { };
        vector<int> combo { };
        rec(0, candidates, combo, result, target);
        return result;
    }

private:
    void rec(int i, vector<int>& nums, vector<int>& combo, vector<vector<int>>& result, int target) {
        if (target == 0) {
            vector<int> validCombo(combo);
            result.push_back(validCombo);
            return;
        }

        for (int j = i; j < nums.size(); j++) {
            if (nums[j] <= target) {
                combo.push_back(nums[j]);
                rec(j, nums, combo, result, target - nums[j]);
                combo.pop_back();
            }
        }
    }
};
```
