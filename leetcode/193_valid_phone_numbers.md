# 193. Valid Phone Numbers - Easy

Given a text file `file.txt` that contains a list of phone numbers (one per line), write a one-liner bash script to print all valid phone numbers.

You may assume that a valid phone number must appear in one of the following two formats: (xxx) xxx-xxxx or xxx-xxx-xxxx. (x means a digit)

You may also assume each line in the text file must not contain leading or trailing white spaces.

##### Example 1:

```
Assume that file.txt has the following content:

987-123-4567
123 456 7890
(123) 456-7890

Your script should output the following valid phone numbers:

987-123-4567
(123) 456-7890
```

## Solution 1

```
grep -E "^([0-9]{3}-[0-9]{3}-[0-9]{4})$|^(\([0-9]{3}\) [0-9]{3}-[0-9]{4})$" file.txt
```

## Notes
- Need to use `-E` for extended regex for `[rangestart-rangeend]` to work because LC `grep` version is outdated. Note how parentheses need to be escaped and how brackets can be used to specify a certain number of a particular character or subpattern. `^` and `$` anchor pattern to start and end of line respectively. `|` specifies we have a match if either of the surrounding subpatterns match. Could shorten such that we only `|` the area code prefix but this works just fine.

## Solution 2

```
grep -P "(^\d{3}-\d{3}-\d{4}$)|(^\(\d{3}\) \d{3}-\d{4}$)" file.txt
```

## Notes
- Need to use `-P` for Perl-compatible regex for `\d` to work.