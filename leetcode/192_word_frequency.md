# 192. Word Frequency - Medium

Write a bash script to calculate the frequency of each word in a text file `words.txt`.

For simplicity sake, you may assume:

- `words.txt` contains only lowercase characters and space `' '` characters.
- Each word must consist of lowercase characters only.
- Words are separated by one or more whitespace characters.

##### Example 1:

```
Assume that words.txt has the following content:

the day is sunny the the
the sunny is is

Your script should output the following, sorted by descending frequency:

the 4
is 3
sunny 2
day 1
```

##### Note:

- Don't worry about handling ties, it is guaranteed that each word's frequency count is unique.
- Could you write it in one-line using Unix pipes?

## Solution

```
cat words.txt | tr -s ' ' '\n' | sort | uniq -c | sort -r | awk '{ print $2, $1 }'
```

## Notes
- Unix pipes (`|`) 'pipe' the output of one command into another. So from subcommand to subcommand this is what the solution is doing:
    - `cat` spits the contents of `words.txt` to `stdout`, aka the 'file' that commands spit their output to by default. Since is it piped to the next command `tr ...`, the next subcommand will receive the contents of `words.txt` as its input.
    - `tr` 'translates' its input into its output by replacing or deleting specified character sequences. The `-s` option 'squeezes' consecutive occurrences of space characters into a single newline to handle the case where there are multiple whitespaces between words. The final result of this subcommand is all words in `words.txt` are on their own lines.
    - `sort` sorts the lines of its input by default, lexicographically.
    - `uniq` takes the lexicographically sorted lines of `words.txt`, which are all on their own line at this point thanks to `tr`, and removes any duplicate lines/words __by comparing adjacent lines__, hence why the previous sort was necessary. The `-c` option makes `uniq` count the number of occurrences of each distinct line, preceding each unique line in the final output with the count and a single whitespace character delimiter.
    - `sort -r` sorts the lines in '**r**everse' order, and since each line AKA word is now prefixed with the number of occurrences it originally had in `words.txt`, this will sort the lines/words in descending order according to their frequency in the input file and spit out to `stdout`, which gets piped to the final subcommand `awk`.
    - There is a lot to know about `awk` but here it is printing each line of the input from `sort -r` to `stdout`, swapping the ordering of the count and word in each line before printing. The `$1` and `$2` in shell syntax typically refers to the first, second, etc. words in a line.