# 319. Bulb Switcher - Medium

There are `n` bulbs that are initially off. You first turn on all the bulbs, then you turn off every second bulb.

On the third round, you toggle every third bulb (turning on if it's off or turning off if it's on). For the `ith` round, you toggle every `i` bulb. For the `nth` round, you only toggle the last bulb.

Return the number of bulbs that are on after `n` rounds.

##### Example 1:

```
Input: n = 3
Output: 1
Explanation: At first, the three bulbs are [off, off, off].
After the first round, the three bulbs are [on, on, on].
After the second round, the three bulbs are [on, off, on].
After the third round, the three bulbs are [on, off, off]. 
So you should return 1 because there is only one bulb is on.
```

##### Example 2:

```
Input: n = 0
Output: 0
```

##### Example 3:

```
Input: n = 1
Output: 1
```

##### Constraints:

- <code>0 <= n <= 10<sup>9</sup></code>

## Solution

```
# Time: O(1)
# Space: O(1)
class Solution:
    def bulbSwitch(self, n: int) -> int:
        return int(n ** 0.5)
```

## Notes
- A big time sink for stubborn people who haven't done a lot of number theory/math questions. Based on the large range of possible `n` values, it is clear this must be done in better than linear time. We can't even consider each round, let alone the status of each bulb in each round. So there must be some kind of trick, and there is.
- With some thought or after having drawn out an example such as `n = 16`, it becomes clear that bulbs that get touched an __even__ number of times end up in the _OFF_ state after `n` rounds, and bulbs that get touched an __odd__ number of times end up in the _ON_ state. How can we determine the parity of touches for a given bulb? Well, the parity of touches for a given bulb is dependent on the number of factors the 1-index of that bulb has. I.e., _for the first bulb with index `1`, there is only `1` factor, so the first bulb will be on after `n` rounds_. For the second bulb with index `2`, there are `2` factors, `1` and `2`. For the third bulb with index `3`, there are `2` factors, `1` and `3`. The second and third bulbs have even numbers of factors, and are off after `n` rounds. _For the fourth bulb with index `4`, there are `3` factors, `1`, `2`, and `4`, so the fourth bulb will be on after `n` rounds._ __The number of factors of bulb 1-index represents the number of times a bulb will get touched__, i.e. the fourth bulb will get touched in the first, second, and fourth rounds because it is a multiple of `1`, `2`, and `4`.
- The only numbers that have an odd number of factors are perfect squares, i.e., `1, 4, 9, 16, 25, ...`. The number of perfect squares in the range `[1, n]` is equivalent to floored `sqrt(n)`.