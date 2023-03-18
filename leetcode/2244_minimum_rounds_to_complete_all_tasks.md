# 2244. Minimum Rounds to Complete All Tasks - Medium

You are given a 0-indexed integer array `tasks`, where `tasks[i]` represents the difficulty level of a task. In each round, you can complete either 2 or 3 tasks of the same difficulty level.

Return the minimum rounds required to complete all the tasks, or `-1` if it is not possible to complete all the tasks.

##### Example 1:

```
Input: tasks = [2,2,3,3,2,4,4,4,4,4]
Output: 4
Explanation: To complete all the tasks, a possible plan is:
- In the first round, you complete 3 tasks of difficulty level 2. 
- In the second round, you complete 2 tasks of difficulty level 3. 
- In the third round, you complete 3 tasks of difficulty level 4. 
- In the fourth round, you complete 2 tasks of difficulty level 4.  
It can be shown that all the tasks cannot be completed in fewer than 4 rounds, so the answer is 4.
```

##### Example 2:

```
Input: tasks = [2,3,3]
Output: -1
Explanation: There is only 1 task of difficulty level 2, but in each round, you can only complete either 2 or 3 tasks of the same difficulty level. Hence, you cannot complete all the tasks, and the answer is -1.
```

##### Constraints:

- <code>1 <= tasks.length <= 10<sup>5</sup></code>
- <code>1 <= tasks[i] <= 10<sup>9</sup></code>

## Solution

```
from collections import Counter

# Time: O(n)
# Space: O(n)
class Solution:
    def minimumRounds(self, tasks: List[int]) -> int:
        freqs = Counter(tasks)
        result = 0
        for f in freqs.values():
            if f == 1:
                return -1
            if f < 4:
                result += 1
            elif f % 3 == 1:
                result += 2 + (f - 4) // 3
            elif f % 3 == 2:
                result += 1 + (f - 2) // 3
            else:
                result += f // 3
        return result
```

## Notes
- Any task for which there is no other of the same difficulty level makes it uncompleteable, so we return `-1` for such cases. For all other inputs, the minimum rounds to complete each difficulty level depends on the remainder when dividing by three (unless there are exactly 2 or 3 tasks of a particular difficulty level).