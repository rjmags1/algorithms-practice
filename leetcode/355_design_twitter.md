# 355. Design Twitter - Medium

Design a simplified version of Twitter where users can post tweets, follow/unfollow another user, and is able to see the `10` most recent tweets in the user's news feed.

Implement the `Twitter` class:

- `Twitter()` Initializes your twitter object.
- `void postTweet(int userId, int tweetId)` Composes a new tweet with ID `tweetId` by the user `userId`. Each call to this function will be made with a unique `tweetId`.
- `List<Integer> getNewsFeed(int userId)` Retrieves the `10` most recent tweet IDs in the user's news feed. Each item in the news feed must be posted by users who the user followed or by the user themself. Tweets must be ordered from most recent to least recent.
- `void follow(int followerId, int followeeId)` The user with ID `followerId` started following the user with ID `followeeId`.
- `void unfollow(int followerId, int followeeId)` The user with ID `followerId` started unfollowing the user with ID `followeeId`.


##### Example 1:

```
Input
["Twitter", "postTweet", "getNewsFeed", "follow", "postTweet", "getNewsFeed", "unfollow", "getNewsFeed"]
[[], [1, 5], [1], [1, 2], [2, 6], [1], [1, 2], [1]]
Output
[null, null, [5], null, null, [6, 5], null, [5]]

Explanation
Twitter twitter = new Twitter();
twitter.postTweet(1, 5); // User 1 posts a new tweet (id = 5).
twitter.getNewsFeed(1);  // User 1's news feed should return a list with 1 tweet id -> [5]. return [5]
twitter.follow(1, 2);    // User 1 follows user 2.
twitter.postTweet(2, 6); // User 2 posts a new tweet (id = 6).
twitter.getNewsFeed(1);  // User 1's news feed should return a list with 2 tweet ids -> [6, 5]. Tweet id 6 should precede tweet id 5 because it is posted after tweet id 5.
twitter.unfollow(1, 2);  // User 1 unfollows user 2.
twitter.getNewsFeed(1);  // User 1's news feed should return a list with 1 tweet id -> [5], since user 1 is no longer following user 2.
```

##### Constraints:

- <code>1 <= userId, followerId, followeeId <= 500</code>
- <code>0 <= tweetId <= 10<sup>4</sup></code>
- All the tweets have unique IDs.
- At most <code>3 * 10<sup>4</sup></code> calls will be made to `postTweet`, `getNewsFeed`, `follow`, and `unfollow`.

## Solution

```
# Overall Space: O(m + n) if m is people and n is tweets
class Twitter:
    # Time: O(1)
    def __init__(self):
        self.tweets = defaultdict(list)
        self.following = defaultdict(set)
        self.t = 0

    # Time: O(1)
    def postTweet(self, userId: int, tweetId: int) -> None:
        self.tweets[userId].append((tweetId, self.t))
        self.t += 1

    # Time: O(k * m) where k is feedlen
    # Space: O(k)
    FEEDLEN = 10
    def getNewsFeed(self, userId: int) -> List[int]:
        idxs, result = {}, []
        usert = self.tweets[userId]
        idxs[userId] = len(usert) - 1
        for _ in range(self.FEEDLEN):
            i = k = idxs[userId]
            currtid, currtime = usert[i] if k > -1 else (None, -inf)
            p = userId
            for f in self.following[userId]:
                ftweets = self.tweets[f]
                k = idxs[f] if f in idxs else len(ftweets) - 1
                if k > -1 and ftweets[k][1] > currtime:
                    currtid, currtime = ftweets[k]
                    i, p = k, f
            if currtid is None:
                break
            result.append(currtid)
            idxs[p] = i - 1
            
        return result

    # Time: O(1)
    def follow(self, followerId: int, followeeId: int) -> None:
        self.following[followerId].add(followeeId)

    # Time: O(1)
    def unfollow(self, followerId: int, followeeId: int) -> None:
        if followeeId in self.following[followerId]:
            self.following[followerId].remove(followeeId)
```

## Notes
- Key thing here is timestamping and efficiently going about finding the most recent `10` tweets for a given person.