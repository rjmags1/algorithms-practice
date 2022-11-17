# 195. Tenth Line - Easy

Given a text file `file.txt`, print just the 10th line of the file.

##### Example 1:

```
Assume that file.txt has the following content:

Line 1
Line 2
Line 3
Line 4
Line 5
Line 6
Line 7
Line 8
Line 9
Line 10

Your script should output the tenth line, which is:

Line 10

```

## Note:
1. If the file contains less than 10 lines, what should you output?
2. There's at least three different solutions. Try to explore all possibilities.

## Solution

```
awk '
{
    if (NR == 10) {
        for (j = 1; j <= NF; j++) {
            if (j == 1) {
                arr[1] = $j;
            }
            else {
                arr[1] = arr[1] " " $j;
            }
        }
        print arr[1];
    }
}
' file.txt
```

## Notes
- Just get and print the tenth line with `awk`. Probably more efficient ways to do this with `head` or `tail` but I am a novice at bash.