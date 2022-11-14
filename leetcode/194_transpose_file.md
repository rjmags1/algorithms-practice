# 194. Transpose File - Medium

Given a text file `file.txt`, transpose its content.

You may assume that each row has the same number of columns, and each field is separated by the `' '` character.

##### Example 1:

```
If file.txt has the following content:

name age
alice 21
ryan 30

Output the following:

name alice ryan
age 21 30
```

## Solution

```
awk '
{
    for (i = 1; i <= NF; i++) {
        if (NR == 1) {
            arr[i] = $i;
        }
        else {
            arr[i] = arr[i] " " $i;
        }
    }
}
END {
    for (i = 1; arr[i] != ""; i++) {
        print arr[i];
    }
}
' file.txt
```

## Notes
- `awk` has its own language suited for input text transformation that is more complex and requires programming features such as loops, arrays, and more. It is similar to C in its syntax.
- The code before `END` is executed on each line of the input. The code after `END` is executed after the other code has been applied to all input lines.
- There is no need to explicitly allocate arrays in `awk` language, just refer to their indices directly. An index for which nothing has been allocated returns `""` by default. Refer to an element at an index with `$index_variable`.
- `NF` and `NR` refer to the number of 'fields' AKA words in a line, and the number of 'records' AKA lines in the input file.
- Also note the string concatenation. Instead of '+' we just use whitespace as the string concatenation operator.
- The code is adding each word in a line to a substring in `arr` of words for which the field number of the words in the substring is the same, which is how we transpose a matrix and a more general way of describing what the prompt wants us to do. Once we have fully constructed `arr` we `print` each of its elements.