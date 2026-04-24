# Codeforces Swift API Client

A clean, production-grade Swift framework wrapping the [Codeforces API](https://codeforces.com/apiHelp/).

## Features

- **Complete API coverage** — all 16 endpoints implemented
- **Async/await** — modern Swift concurrency
- **Type-safe models** — `Codable`, `Equatable`, `Sendable` structs for all API objects
- **Authorization** — SHA-512 signed requests for endpoints requiring API keys
- **Auto-signing** — when credentials are provided, all requests are automatically authenticated

## Installation

### Swift Package Manager (Recommended)

Add the dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/alonso284/CodeforcesSwiftSDK.git", from: "1.0.0"),
]
```

Then add `"Codeforces"` to your target's dependencies:

```swift
.target(name: "YourApp", dependencies: ["Codeforces"]),
```

Or in Xcode: **File → Add Package Dependencies…** and enter the repository URL.

### Xcode Project

Add the `Codeforces.xcodeproj` to your Xcode workspace, or include the `Codeforces/` directory as a framework target dependency.

## Quick Start

```swift
import Codeforces

// Public (unauthenticated) client
let client = CodeforcesAPI()

// Authenticated client (required for user.friends and some contest endpoints)
let client = CodeforcesAPI(key: "your-api-key", secret: "your-api-secret")
```

### Examples

```swift
// Get user info
let users = try await client.userInfo(handles: ["tourist", "Petr"])
print(users[0].rating)  // 3800

// Get contest list
let contests = try await client.contestList()

// Get problemset filtered by tags
let problemset = try await client.problemsetProblems(tags: ["dp", "graphs"])

// Get user's rating history
let history = try await client.userRating(handle: "tourist")

// Get friends (requires authorization)
let friends = try await client.userFriends()

// Get contest standings
let standings = try await client.contestStandings(contestId: 100001, from: 1, count: 10)
```

## API Methods

| Method | Function | Auth Required |
|--------|----------|:---:|
| `blogEntry.comments` | `blogEntryComments(blogEntryId:)` | No |
| `blogEntry.view` | `blogEntryView(blogEntryId:)` | No |
| `contest.hacks` | `contestHacks(contestId:asManager:)` | asManager |
| `contest.list` | `contestList(gym:)` | No |
| `contest.ratingChanges` | `contestRatingChanges(contestId:)` | No |
| `contest.standings` | `contestStandings(contestId:asManager:from:count:handles:room:showUnofficial:)` | Optional |
| `contest.status` | `contestStatus(contestId:asManager:handle:from:count:)` | asManager |
| `problemset.problems` | `problemsetProblems(tags:problemsetName:)` | No |
| `problemset.recentStatus` | `problemsetRecentStatus(count:problemsetName:)` | No |
| `recentActions` | `recentActions(maxCount:)` | No |
| `user.blogEntries` | `userBlogEntries(handle:)` | No |
| `user.friends` | `userFriends(onlyOnline:)` | **Yes** |
| `user.info` | `userInfo(handles:)` | No |
| `user.ratedList` | `userRatedList(activeOnly:includeRetired:)` | No |
| `user.rating` | `userRating(handle:)` | No |
| `user.status` | `userStatus(handle:from:count:)` | No |

## API Objects

All objects are Swift `struct`s conforming to `Codable`, `Equatable`, and `Sendable`.

| Object | Struct |
|--------|--------|
| User | `CFUser` |
| BlogEntry | `CFBlogEntry` |
| Comment | `CFComment` |
| Contest | `CFContest` |
| Party | `CFParty` |
| Member | `CFMember` |
| Problem | `CFProblem` |
| ProblemStatistics | `CFProblemStatistics` |
| Submission | `CFSubmission` |
| Hack | `CFHack` |
| RanklistRow | `CFRanklistRow` |
| ProblemResult | `CFProblemResult` |
| RatingChange | `CFRatingChange` |
| RecentAction | `CFRecentAction` |

## Project Structure

```
Codeforces/
├── Codeforces.swift              # Client class, auth, request execution
├── Objects/                      # Model structs
│   ├── User.swift
│   ├── BlogEntry.swift
│   ├── Comment.swift
│   ├── Contest.swift
│   ├── Party.swift
│   ├── Member.swift
│   ├── Problem.swift
│   ├── ProblemStatistics.swift
│   ├── Submission.swift
│   ├── Hack.swift
│   ├── RanklistRow.swift
│   ├── ProblemResult.swift
│   ├── RatingChange.swift
│   └── RecentAction.swift
└── Methods/                      # API method extensions
    ├── BlogEntryMethods.swift
    ├── ContestMethods.swift
    ├── ProblemsetMethods.swift
    ├── RecentActionsMethods.swift
    └── UserMethods.swift

CodeforcesTests/
├── Objects/                      # JSON decoding tests
└── Methods/                      # Live API integration tests
```

## Authorization

The Codeforces API uses SHA-512 based request signing:

1. Generate a random 6-digit number
2. Sort query parameters alphabetically
3. Compute `SHA512(rand/methodName?sortedParams#apiSecret)`
4. Append the hash to the random number as `apiSig`

This is handled automatically by the client when credentials are provided.

## Requirements

- Swift 5.9+
- macOS 13+ / iOS 16+
- CryptoKit (included in Apple platforms)

## License

MIT
