# 489. Robot Room Cleaner - Hard

You are controlling a robot that is located somewhere in a room. The room is modeled as an `m x n` binary grid where `0` represents a wall and `1` represents an empty slot.

The robot starts at an unknown location in the room that is guaranteed to be empty, and you do not have access to the grid, but you can move the robot using the given API `Robot`.

You are tasked to use the robot to clean the entire room (i.e., clean every empty cell in the room). The robot with the four given APIs can move forward, turn left, or turn right. Each turn is `90` degrees.

When the robot tries to move into a wall cell, its bumper sensor detects the obstacle, and it stays on the current cell.

Design an algorithm to clean the entire room using the following APIs:

```
interface Robot {
  // returns true if next cell is open and robot moves into the cell.
  // returns false if next cell is obstacle and robot stays on the current cell.
  boolean move();

  // Robot will stay on the same cell after calling turnLeft/turnRight.
  // Each turn will be 90 degrees.
  void turnLeft();
  void turnRight();

  // Clean the current cell.
  void clean();
}
```

Note that the initial direction of the robot will be facing up. You can assume all four edges of the grid are all surrounded by a wall.

Custom testing:

The input is only given to initialize the room and the robot's position internally. You must solve this problem "blindfolded". In other words, you must control the robot using only the four mentioned APIs without knowing the room layout and the initial robot's position.

##### Example 1:

![](../assets/489_robot.jpg)

```
Input: room = [[1,1,1,1,1,0,1,1],[1,1,1,1,1,0,1,1],[1,0,1,1,1,1,1,1],[0,0,0,1,0,0,0,0],[1,1,1,1,1,1,1,1]], row = 1, col = 3
Output: Robot cleaned all rooms.
Explanation: All grids in the room are marked by either 0 or 1.
0 means the cell is blocked, while 1 means the cell is accessible.
The robot initially starts at the position of row=1, col=3.
From the top left corner, its position is one row below and three columns right.
```

##### Example 2:

```
Input: room = [[1]], row = 0, col = 0
Output: Robot cleaned all rooms.
```

##### Constraints:

- `m == room.length`
- `n == room[i].length`
- `1 <= m <= 100`
- `1 <= n <= 200`
- `0 <= row < m`
- `0 <= col < n`
- `room[row][col] == 1`
- `room[i][j]` is either `0` or `1`.
- All the empty cells can be visited from the starting position.

## Solution

```
# Time: O(mn)
# Space: O(mn)
class Solution:
    def cleanRoom(self, robot):
        """
        :type robot: Robot
        :rtype: None
        """
        N, E, S, W = 0, 1, 2, 3
        dirs = (N, E, S, W)
        didj = ((-1, 0), (0, 1), (1, 0), (0, -1))
        seen = set()
        def rec(i, j, dir):
            robot.clean()
            seen.add((i, j))
            for rotations in range(4):
                newdir = (dir + rotations) % 4
                di, dj = didj[newdir]
                for rotation in range(rotations):
                    robot.turnRight()
                y, x = i + di, j + dj
                if (y, x) not in seen and robot.move():
                    rec(y, x, newdir)
                    robot.turnLeft()
                    robot.turnLeft()
                for _ in range(rotations):
                    robot.turnLeft()
            robot.turnLeft()
            robot.turnLeft()
            robot.move()

        rec(0, 0, N)
```

## Notes
- Well, the robot cannot be multiple positions at once (BFS won't work), so to visit all empty cells and clean them we need a dfs approach. This question is basic dfs implementation that requires us to handle also the actual movement of the robot with the API. Regardless of which direction the robot is facing at the start of a recursive call, we can dfs in each direction by performing the correct number of calls to one of the turn methods of the `Robot` API, attempting to move, recursing if the move was successful, and then turning the robot back around once we get back from the recursive call. When we return from a recursive call, we need to turn the robot in the opposite direction of its initial orientation and then move it back to wherever it came from previously.
- Note the solution assumes the robot is initially facing north, which is valid because all we really care about for this problem is cardinal directions relative to the initial orientation of the robot.