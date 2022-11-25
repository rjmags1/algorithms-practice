# 282. Expression Add Operators - Hard

Given a string `num` that contains only digits and an integer `target`, return all possibilities to insert the binary operators `'+'`, `'-'`, and/or `'*'` between the digits of `num` so that the resultant expression evaluates to the `target` value.

Note that operands in the returned expressions should not contain leading zeros.

##### Example 1:

```
Input: num = "123", target = 6
Output: ["1*2*3","1+2+3"]
Explanation: Both "1*2*3" and "1+2+3" evaluate to 6.
```

##### Example 2:

```
Input: num = "232", target = 8
Output: ["2*3+2","2+3*2"]
Explanation: Both "2*3+2" and "2+3*2" evaluate to 8.
```

##### Example 3:

```
Input: num = "3456237490", target = 9191
Output: []
Explanation: There are no expressions that can be created from "3456237490" to evaluate to 9191.
```

##### Constraints:

- `1 <= num.length <= 10`
- `num` consists of only digits.
- <code>-2<sup>31</sup> <= target <= 2<sup>31</sup> - 1</code>

## Solution 1

```
Overall Time: O(n^4) * 3^n where n is len(num)
OVerall Space: O(n)
class Solution:
    @cache
    def allpartitions(self, s):
        partitions = []
        for i in range(1, len(s)):
            left = s[:i]
            right = s[i:]
            partitions.append([left, right])
            for subpart in self.allpartitions(right):
                partitions.append([left] + subpart)
                
        return partitions
    
    ops = ["*", "+", "-"]
    def evaluate(self, expr):
        stack = []
        for x in expr:
            if x in self.ops:
                if x != "+":
                    stack.append(x)
            else:
                if stack and stack[-1] == "-":
                    stack.pop()
                    stack.append(-int(x))
                elif stack and stack[-1] == "*":
                    stack.pop()
                    stack.append(stack.pop() * int(x))
                else:
                    stack.append(int(x))
                
        return sum(stack)
    
    def rec(self, nums, i, builder, target, result):
        if nums[i][0] == "0" and len(nums[i]) > 1:
            return
        if i == len(nums) - 1:
            builder.append(nums[-1])
            if self.evaluate(builder) == target:
                result.append("".join([str(x) for x in builder]))
            builder.pop()
            return
        
        builder.append(nums[i])
        for op in self.ops:
            builder.append(op)
            self.rec(nums, i + 1, builder, target, result)
            builder.pop()
        builder.pop()
    
    def addOperators(self, num: str, target: int) -> List[str]:
        if int(num) == target and target != 0:
            return [num]
        
        parts = self.allpartitions(num)
        builder, result = [], []
        for part in parts:
            self.rec(part, 0, builder, target, result)
        return result
```

## Notes
- This solution will TLE some of the time because it evaluates every single partition instead of calculating it on the fly.
- For the time complexity, note that there are <code>O(n<sup>4</sup>)</code> ways to partition a string if the only limit on the number of partitions is the length of the string itself.

## Solution 2

```
class Solution:
    @cache
    def allpartitions(self, s):
        partitions = []
        for i in range(1, len(s)):
            left = s[:i]
            right = s[i:]
            partitions.append([left, right])
            for subpart in self.allpartitions(right):
                partitions.append([left] + subpart)
                
        return partitions
    
    ops = ["*", "+", "-"]
    def rec(self, nums, i, chain, result, prevop):
        num = nums[i]
        if num[0] == "0" and len(num) > 1:
            return
        
        num = int(num)
        if i == len(nums) - 1:
            self.builder.append(num)
            if prevop == "+":
                result += chain + num
            elif prevop == "-":
                result += chain - num
            else:
                result += chain * num
            if result == self.target:
                self.combos.append("".join([str(x) for x in self.builder]))
            self.builder.pop()
            return
        
        if prevop == "+":
            result += chain
            chain = num
        elif prevop == "-":
            result += chain
            chain = -num
        else:
            chain *= num
        for op in self.ops:
            self.builder.append(num)
            self.builder.append(op)
            self.rec(nums, i + 1, chain, result, op)
            self.builder.pop()
            self.builder.pop()
    
    def addOperators(self, num: str, target: int) -> List[str]:
        if int(num) == target and target != 0:
            return [num]
        
        parts = self.allpartitions(num)
        self.builder, self.combos = [], []
        self.target = target
        for part in parts:
            self.rec(part, 0, 0, 0, "+")
            
        return self.combos
```

## Notes
- Here we calculate the result of evaluating a particular expression as we build it on the fly, which significantly improves runtime. We do this with the idea of chaining; consecutive multiplication operations represent a chain of operations that must be grouped together. Other operations can simply be treated as surrounding such chains, and when we see one we can deposit the previous chain into an accumulator, `result`, and start a new chain with the current number.