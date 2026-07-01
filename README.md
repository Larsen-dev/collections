# collections

Simple collections module. Full generic-typed and based on linked list. All structures contain:
- :len()
- :isEmpty()
- :clear()
- :iter()

## Installation

```toml
collections = "larsen-dev/collections@0.1.0"
```

Or using .rbxm package from Releases page

## Usage

```lua
local collections = require(Packages.collections)

local set = collections.newSet() :: collections.set<number>
local stack = collections.newStack() :: collections.stack<number>
local queue = collections.newQueue() :: collections.queue<number>

set:add(1)
print(set:contains(1)) -- true
```
