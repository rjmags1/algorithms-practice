# 535. Encode and Decode TinyURL - Medium

TinyURL is a URL shortening service where you enter a URL such as `https://leetcode.com/problems/design-tinyurl` and it returns a short URL such as `http://tinyurl.com/4e9iAk`. Design a class to encode a URL and decode a tiny URL.

There is no restriction on how your encode/decode algorithm should work. You just need to ensure that a URL can be encoded to a tiny URL and the tiny URL can be decoded to the original URL.

Implement the `Solution` class:

- `Solution()` Initializes the object of the system.
- `String encode(String longUrl)` Returns a tiny URL for the given `longUrl`.
- `String decode(String shortUrl)` Returns the original long URL for the given `shortUrl`. It is guaranteed that the given `shortUrl` was encoded by the same object.


##### Example 1:

```
Input: url = "https://leetcode.com/problems/design-tinyurl"
Output: "https://leetcode.com/problems/design-tinyurl"

Explanation:
Solution obj = new Solution();
string tiny = obj.encode(url); // returns the encoded tiny url.
string ans = obj.decode(tiny); // returns the original url after deconding it.
```

##### Constraints:

- <code>1 <= url.length <= 10<sup>4</sup></code>
- `url` is guranteed to be a valid URL.

## Solution

```
import string
from random import randrange

# Overall Space: O(n)
class Codec:
    chars = string.ascii_letters + string.digits
    symbols = len(chars)
    domain = "http://tinyurl.com/"
    def __init__(self):
        self.keys = {}

    # Time: O(inf)
    def encode(self, longUrl: str) -> str:
        """Encodes a URL to a shortened URL.
        """
        while 1:
            code = "".join(self.chars[randrange(self.symbols)] for _ in range(8))
            if code not in self.keys:
                self.keys[code] = longUrl
                return self.domain + code

    # Time: O(1)
    def decode(self, shortUrl: str) -> str:
        """Decodes a shortened URL to its original URL.
        """
        return self.keys[shortUrl[-8:]]
```

## Notes
- This form of encoding is known as 'random fixed length' encoding, and does a good job of satisfying the constraints we care about when designing TinyURL: the generated urls are smaller than the original, are unpredictable, and minimization of `code` collisions (ie generating a `code` that already exists in `self.keys`) during calls to `encode`. With this strategy there are `62 ** 8` possible encodings, hence the reduced likelihood of `code` collisions, and we use random number generators to generate `code`, which makes it hard to predict future encodings based on previous ones. Compared to implementations I have seen of other strategies (hashing, variable length encoding, plain old counter) this strategy provides arguably the best length + collision probability profile.
- The issue with variable length encoding is for some input urls the tinyurl may end up being longer than the input; additionally, depending on the implementation variable length encoding behavior may also be predictable. With hashing, the number of possible encodings is dependent on the size of the hash integers generated by the hash function, which may be 32 bits depending on programming language/platform; i.e., `2 ** 32` encodings are possible with 32-bit integers, which is less than `62 ** 8`.