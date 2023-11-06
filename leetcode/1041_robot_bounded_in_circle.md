# 1041. Robot Bounded in Circle - Medium

On an infinite plane, a robot initially stands at `(0, 0)` and faces north. Note that:

- The north direction is the positive direction of the y-axis.
- The south direction is the negative direction of the y-axis.
- The east direction is the positive direction of the x-axis.
- The west direction is the negative direction of the x-axis.

The robot can receive one of three instructions:

- `"G"`: go straight `1` unit.
- `"L"`: turn `90` degrees to the left (i.e., anti-clockwise direction).
- `"R"`: turn `90` degrees to the right (i.e., clockwise direction).

The robot performs the `instructions` given in order, and repeats them forever.

Return `true` if and only if there exists a circle in the plane such that the robot never leaves the circle.

##### Example 1:

```
Input: instructions = "GGLLGG"
Output: true
Explanation: The robot is initially at (0, 0) facing the north direction.
"G": move one step. Position: (0, 1). Direction: North.
"G": move one step. Position: (0, 2). Direction: North.
"L": turn 90 degrees anti-clockwise. Position: (0, 2). Direction: West.
"L": turn 90 degrees anti-clockwise. Position: (0, 2). Direction: South.
"G": move one step. Position: (0, 1). Direction: South.
"G": move one step. Position: (0, 0). Direction: South.
Repeating the instructions, the robot goes into the cycle: (0, 0) --> (0, 1) --> (0, 2) --> (0, 1) --> (0, 0).
Based on that, we return true.
```

##### Example 2:

```
Input: instructions = "GG"
Output: false
Explanation: The robot is initially at (0, 0) facing the north direction.
"G": move one step. Position: (0, 1). Direction: North.
"G": move one step. Position: (0, 2). Direction: North.
Repeating the instructions, keeps advancing in the north direction and does not go into cycles.
Based on that, we return false.
```

##### Example 3:

```
Input: instructions = "GL"
Output: true
Explanation: The robot is initially at (0, 0) facing the north direction.
"G": move one step. Position: (0, 1). Direction: North.
"L": turn 90 degrees anti-clockwise. Position: (0, 1). Direction: West.
"G": move one step. Position: (-1, 1). Direction: West.
"L": turn 90 degrees anti-clockwise. Position: (-1, 1). Direction: South.
"G": move one step. Position: (-1, 0). Direction: South.
"L": turn 90 degrees anti-clockwise. Position: (-1, 0). Direction: East.
"G": move one step. Position: (0, 0). Direction: East.
"L": turn 90 degrees anti-clockwise. Position: (0, 0). Direction: North.
Repeating the instructions, the robot goes into the cycle: (0, 0) --> (0, 1) --> (-1, 1) --> (-1, 0) --> (0, 0).
Based on that, we return true.
```

##### Constraints:

- `1 <= instructions.length <= 100`
- `instructions[i]` is `'G'`, `'L'` or, `'R'`.

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def isRobotBounded(self, instructions: str) -> bool:
        N, E, S, W = 0, 1, 2, 3
        rotate_left = lambda d: (d - 1 + 4) % 4
        rotate_right = lambda d: (d + 1) % 4
        direction, x, y = N, 0, 0
        def traverse():
            nonlocal x, y
            if direction == N:
                y += 1
            elif direction == S:
                y -= 1
            elif direction == E:
                x += 1
            else:
                x -= 1

        for i in instructions:
            if i == 'G':
                traverse()
            elif i == 'L':
                direction = rotate_left(direction)
            else:
                direction = rotate_right(direction)
        
        return direction != N or x == y == 0
```

## Notes
- Definitely a problem where coming up with the conceptual strategy is harder than the implementation. The idea behind the solution is that regardless of how the robot moves around in a single sequence of `instructions`, all we care about is the overall change in `x` and `y` positions and the final direction. If the robot ends up facing north after the first sequence and we are not back at `x == y == 0`, then the robot will not be confined to a particular region within the plane as `instructions` are repeatedly executed. Otherwise, the robot will continuously move within the same region of the plane as the change in `x` and `y` after a single sequence offset each other in repeats of `2` or `4` (i.e., if the robot faces south after the first sequence of `instructions` (`2`) or if the robot faces east or west after the first sequence (`4`)).