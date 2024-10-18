# 621. Task Scheduler - Medium

You are given an array of CPU `tasks`, each labeled with a letter from A to Z, and a number `n`. Each CPU interval can be idle or allow the completion of one task. Tasks can be completed in any order, but there's a constraint: there has to be a gap of at least `n` intervals between two tasks with the same label.

Return the minimum number of CPU intervals required to complete all tasks.

##### Example 1:

```
Input: tasks = ["A","A","A","B","B","B"], n = 2

Output: 8

Explanation: A possible sequence is: A -> B -> idle -> A -> B -> idle -> A -> B.

After completing task A, you must wait two intervals before doing A again. The same applies to task B. In the 3rd interval, neither A nor B can be done, so you idle. By the 4th interval, you can do A again as 2 intervals have passed.
```

##### Example 2:

```
Input: tasks = ["A","C","A","B","D","B"], n = 1

Output: 6

Explanation: A possible sequence is: A -> B -> C -> D -> A -> B.

With a cooling interval of 1, you can repeat a task after just one other task.
```

##### Example 3:

```
Input: tasks = ["A","A","A", "B","B","B"], n = 3

Output: 10

Explanation: A possible sequence is: A -> B -> idle -> idle -> A -> B -> idle -> idle -> A -> B.

There are only two types of tasks, A and B, which need to be separated by 3 intervals. This leads to idling twice between repetitions of these tasks.
```

##### Constraints:

- <code>1 <= tasks.length <= 10<sup>4</sup></code>
- `tasks[i]` is an uppercase English letter.
- `0 <= n <= 100`

## Solution

```
# Time: O(mn * log(k)) where m is len(tasks) and k is unique tasks
# Space: O(k)
class Solution:
    def leastInterval(self, tasks: List[str], n: int) -> int:
        if n == 0:
            return len(tasks)

        interval = 0
        freqs = Counter(tasks)
        execute_heap = [(-freqs[task], task) for task in freqs.keys()]
        heapq.heapify(execute_heap)
        wait_heap = []
        while len(execute_heap) > 0 or len(wait_heap) > 0:
            if len(execute_heap) > 0:
                _, task = heapq.heappop(execute_heap)
                freqs[task] -= 1
                if freqs[task] > 0:
                    heapq.heappush(wait_heap, (interval, task))

            while len(wait_heap) > 0 and interval - wait_heap[0][0] >= n:
                last_used, task = heapq.heappop(wait_heap)
                heapq.heappush(execute_heap, (-freqs[task], task))

            interval += 1
        
        return interval
```

## Notes
- One max heap, one min heap. The max heap executes tasks in it with the highest frequencies, the min heap holds tasks that were executed previously but are cannot be executed yet due to the `n` interval wait constraint. We always want to execute tasks with the most of that kind left due to the wait constraint.
