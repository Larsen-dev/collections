# collections
This is a realisation of simple structures used in every programming language in Roblox Studio.
There are two examples of code: .lua, .rbxm formats.

# COPYRIGHT
Collections is a realisation of simple structures from another languages such as queue, set and stack in Roblox Studio.

# Important
Based on Roblox Studio API.

It must be a total copy of simple structures, if something is incorrect connect me.

# Architecture
collections.lua
__packages:
  - queue.class.lua
  - set.class.lua
  - stack.class.lua

# 📌 Short API Documentation 📌

@class Queue<T>
  - :append(self: Queue<T>, element: T) -> ()
  - :pop(self: Queue<T>) -> ()
  - :clear(self: Queue<T>) -> ()

@class Set<T>
  - :add(self: Set<T>, element: T) -> ()
  - :remove(self: Set<T>, element: T)
  - :pop(self: Set<T>) -> (element: T)
  - :isIn(self: Set<T>, element: T) -> (boolean)
  - :clear(self: Set<T>) -> ()
  - :union(self: Set<T>, setForUnion: Set<T>) -> (set: Set<T>)
  - :intersaction(self: Set<T>, setForIntersaction: Set<T>) -> (set: Set<T>)
  - :difference(self: Set<T>, setToFindDifference: Set<T>) -> (set: Set<T>)

@class Stack<T>
  - :append(self: Stack<T>, element: T) -> ()
  - :pop(self: Stack<T>) -> ()
  - :clear(self: Stack<T>) -> ()

collections:
  - .queue<T>() -> (queue: Queue)
  - .set<T>() -> (set: Set)
  - .stack<T>() -> (stack: Stack)
  - .len(tableForMeasure: {  [any]: T} | setClass.Set<T> | stackClass.Stack<T> | stackClass.Queue<T>  ) -> ()
  - .length(tableForMeasure: {  [any]: T} | setClass.Set<T> | stackClass.Stack<T> | stackClass.Queue<T>  ) -> ()
