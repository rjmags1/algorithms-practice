# 401. Binary Watch - Easy

A binary watch has 4 LEDs on the top to represent the hours (0-11), and 6 LEDs on the bottom to represent the minutes (0-59). Each LED represents a zero or one, with the least significant bit on the right.

![](../assets/401-binarywatch.jpg)

Given an integer `turnedOn` which represents the number of LEDs that are currently on (ignoring the PM), return all possible times the watch could represent. You may return the answer in any order.

The hour must not contain a leading zero.

- For example, `"01:00"` is not valid. It should be `"1:00"`.

The minute must be consist of two digits and may contain a leading zero.

- For example, `"10:2"` is not valid. It should be `"10:02"`.


##### Example 1:

```
Input: turnedOn = 1
Output: ["0:01","0:02","0:04","0:08","0:16","0:32","1:00","2:00","4:00","8:00"]
```

##### Example 2:

```
Input: turnedOn = 9
Output: []
```

##### Constraints:

- `0 <= turnedOn <= 10`

## Solution

```
from collections import defaultdict

# Time: O(1)
# Space: O(1)
class Solution:
    def readBinaryWatch(self, turnedOn: int) -> List[str]:
        hbits, mbits = defaultdict(list), defaultdict(list)
        def genmasks(mask, bits, shiftsleft, shift, maxval):
            if shiftsleft == 0:
                if maxval == 59:
                    mbits[bits].append(str(mask) if mask >= 10 else f"0{mask}")
                else:
                    hbits[bits].append(str(mask))
                return
            
            if mask | shift <= maxval:
                genmasks(mask | shift, bits + 1, shiftsleft - 1, shift << 1, maxval)
            genmasks(mask, bits, shiftsleft - 1, shift << 1, maxval)
        
        genmasks(0, 0, 4, 1, 11)
        genmasks(0, 0, 6, 1, 59)
        result = []
        for hourbitson in range(0, 4):
            hours = hbits[hourbitson]
            mins = mbits[turnedOn - hourbitson]
            for h in hours:
                for m in mins:
                    result.append(f"{h}:{m}")
        return sorted(result)
```

## Notes
- We want to consider all valid hours, and then consider all minutes that when paired with valid hours represent valid times. This is straightforward to handle with the idea of bitshifting! The only edge case to be careful of is correctly formatting single digit minutes. The time and space is constant because there are <code>2<sup>4</sup></code> possible hours and <code>2<sup>6</sup></code> possible minutes on a binary watch (and only a subset of each of hours and minutes is valid, ie, hours of `13`, (`8`, `4`, `1` lights on) is invalid).