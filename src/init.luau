--!strict

-- Set
local set = {}
set._prototype = {}
set.__index = set._prototype

type setData<T> = {
	_size: number,
	_elements: { [T]: true },
}

type setPrototype<T> = {
	add: (self: set<T>, element: T) -> (),
	remove: (self: set<T>, element: T) -> (),
	contains: (self: set<T>, element: T) -> boolean,
	len: (self: set<T>) -> number,
	isEmpty: (self: set<T>) -> boolean,
	clear: (self: set<T>) -> (),
	iter: (self: set<T>) -> (({ [T]: true }, T?) -> (T?, true), { [T]: true }, nil),
	union: (self: set<T>, s: set<T>) -> set<T>,
	intersection: (self: set<T>, s: set<T>) -> set<T>,
	difference: (self: set<T>, s: set<T>) -> set<T>,
	clone: (self: set<T>) -> set<T>,
}

export type set<T> = typeof(setmetatable({} :: setData<T>, { __index = {} :: setPrototype<T> }))

--[=[
	@param element T;
	@return ;

	Adds new element to set.
]=]
function set._prototype:add<T>(element: T)
	if not self._elements[element] then
		self._elements[element] = true
		self._size += 1
	end
end

--[=[
	@param element T;
	@return ;

	Removes element from set.
]=]
function set._prototype:remove<T>(element: T)
	if self._elements[element] then
		self._elements[element] = nil
		self._size -= 1
	end
end

--[=[
	@param element T;
	@return boolean;

	Checks whether passed element is in set.
]=]
function set._prototype:contains<T>(element: T): boolean
	return self._elements[element] ~= nil
end

--[=[
	@return number;

	Returns set's length.
]=]
function set._prototype:len(): number
	return self._size
end

--[=[
	@return number;

	Checks if set is empty.
]=]
function set._prototype:isEmpty(): boolean
	return self._size == 0
end

--[=[
	@return ;

	Clears whole set.
]=]
function set._prototype:clear()
	table.clear(self._elements)
	self._size = 0
end

--[=[
	@return (({ [T]: true }, T?) -> (T?, true), { [T]: true }, nil);

	Returns function iterator.
]=]
function set._prototype:iter<T>(): (({ [T]: true }, T?) -> (T?, true), { [T]: true }, nil)
	return pairs(self._elements)
end

--[=[
	@param s set<T>;
	@return set<T>;

	Creates new set which is a union of self and passed set.
]=]
function set._prototype:union<T>(s: set<T>): set<T>
	local union = setmetatable({
		_size = self._size,
		_elements = table.clone(self._elements),
	}, set) :: set<T>

	for n, _ in s:iter() do
		union:add(n)
	end

	return union
end

--[=[
	@param s set<T>;
	@return set<T>;

	Creates new set which is a intersection of self and passed set.
]=]
function set._prototype:intersection<T>(s: set<T>): set<T>
	local intersection = setmetatable({
		_size = 0,
		_elements = {},
	}, set) :: set<T>

	for n in self:iter() do
		if s:contains(n) then
			intersection:add(n)
		end
	end

	return intersection
end

--[=[
	@param s set<T>;
	@return set<T>;

	Creates new set which is a difference of self and passed set.
]=]
function set._prototype:difference<T>(s: set<T>): set<T>
	local difference = setmetatable({
		_size = 0,
		_elements = {},
	}, set) :: set<T>

	for n, _ in self:iter() do
		if s:contains(n) then
			continue
		end
		difference:add(n)
	end

	return difference
end

--[=[
	@return set<T>;

	Clones set.
]=]
function set._prototype:clone<T>(): set<T>
	return setmetatable({
		_size = self._size,
		_elements = table.clone(self._elements),
	}, set) :: set<T>
end

-- Stack
local stack = {}
stack._prototype = {}
stack.__index = stack._prototype

type stackNode<T> = {
	_element: T,
	_previous: stackNode<T>?,
}

type stackData<T> = {
	_size: number,
	_head: stackNode<T>?,
}

type stackPrototype<T> = {
	push: (self: stack<T>, element: T) -> (),
	pop: (self: stack<T>) -> T?,
	peek: (self: stack<T>) -> T?,
	len: (self: stack<T>) -> number,
	isEmpty: (self: stack<T>) -> boolean,
	clear: (self: stack<T>) -> (),
	iter: (self: stack<T>) -> ((stack: stack<T>, node: stackNode<T>?) -> (stackNode<T>?, T?), stack<T>, nil),
	clone: (self: stack<T>) -> stack<T>,
}

export type stack<T> = typeof(setmetatable({} :: stackData<T>, { __index = {} :: stackPrototype<T> }))

--[=[
	@param element T;
	@return ;

	Pushes new element to stack.
]=]
function stack._prototype:push<T>(element: T)
	local head = self._head
	local node = { _element = element, _previous = head }

	self._head = node

	self._size += 1
end

--[=[
	@return T?;

	Pops element from stack.
]=]
function stack._prototype:pop<T>(): T?
	local head = self._head
	if not head then
		return nil
	end

	self._head = head._previous
	self._size -= 1

	return head._element
end

--[=[
	@return T?;

	Returns element which is about to leave stack, but doesn't remove it.
]=]
function stack._prototype:peek<T>(): T?
	return self._head and self._head._element or nil
end

--[=[
	@return number;

	Returns length of stack.
]=]
function stack._prototype:len(): number
	return self._size
end

--[=[
	@return boolean;

	Checks if stack is empty.
]=]
function stack._prototype:isEmpty(): boolean
	return self._size == 0
end

--[=[
	@return ;

	Clears whole stack.
]=]
function stack._prototype:clear()
	self._head = nil
	self._size = 0
end

local function stackIterator<T>(s: stack<T>, node: stackNode<T>?): (stackNode<T>?, T?)
	node = if node then node._previous else s._head

	if node then
		return node, node._element
	end

	return nil
end

--[=[
	@return ((stack: stack<T>, node: stackNode<T>?) -> (stackNode<T>?, T?), stack<T>, nil);

	Returns iterator function.
]=]
function stack._prototype:iter<T>(): ((stack: stack<T>, node: stackNode<T>?) -> (stackNode<T>?, T?), stack<T>, nil)
	return stackIterator, self, nil
end

--[=[
	@return stack<T>;

	Clones stack.
]=]
function stack._prototype:clone<T>(): stack<T>
	local clone = setmetatable({
		_size = 0,
		_head = nil,
	}, stack) :: stack<T>

	local values = {}

	for _, value in self:iter() do
		values[#values + 1] = value
	end

	for i = #values, 1, -1 do
		clone:push(values[i])
	end

	return clone
end

-- Queue
local queue = {}
queue._prototype = {}
queue.__index = queue._prototype

type queueNode<T> = {
	_element: T,
	_next: queueNode<T>?,
	_previous: queueNode<T>?,
}

type queueData<T> = {
	_size: number,
	_tail: queueNode<T>?,
	_head: queueNode<T>?,
}

type queuePrototype<T> = {
	enqueue: (self: queue<T>, element: T) -> (),
	dequeue: (self: queue<T>) -> T?,
	peek: (self: queue<T>) -> T?,
	len: (self: queue<T>) -> number,
	isEmpty: (self: queue<T>) -> boolean,
	clear: (self: queue<T>) -> (),
	iter: (self: queue<T>) -> ((queue: queue<T>, node: queueNode<T>?) -> (queueNode<T>?, T?), queue<T>, nil),
	clone: (self: queue<T>) -> queue<T>,
}

export type queue<T> = typeof(setmetatable({} :: queueData<T>, { __index = {} :: queuePrototype<T> }))

--[=[
	@param element T;
	@return ;

	Enqueues new element.
]=]
function queue._prototype:enqueue<T>(element: T)
	local head = self._head
	local tail = self._tail
	local node = { _element = element, _next = nil, _previous = head } :: queueNode<T>

	if not tail and not head then
		self._tail = node
	else
		if head then
			head._next = node
		end
	end

	self._head = node

	self._size += 1
end

--[=[
	@return T?;

	Dequeues element.
]=]
function queue._prototype:dequeue<T>(): T?
	local tail = self._tail
	if not tail then
		return nil
	end

	local newTail = tail._next
	self._tail = newTail

	if newTail then
		newTail._previous = nil
	else
		self._head = nil
	end

	self._size -= 1

	return tail._element
end

--[=[
	@return T?

	Returns element which is about to leave queue, but doesn't remove it.
]=]
function queue._prototype:peek<T>(): T?
	return self._tail and self._tail._element or nil
end

--[=[
	@return number;

	Returns length of queue.
]=]
function queue._prototype:len(): number
	return self._size
end

--[=[
	@return boolean;

	Checks if queue is empty.
]=]
function queue._prototype:isEmpty(): boolean
	return self._size == 0
end

--[=[
	@return ;

	Clears queue.
]=]
function queue._prototype:clear()
	self._head = nil
	self._tail = nil
	self._size = 0
end

local function queueIterator<T>(q: queue<T>, node: queueNode<T>?): (queueNode<T>?, T?)
	node = if node then node._next else q._tail

	if node then
		return node, node._element
	end

	return nil
end

--[=[
	@return ((queue: queue<T>, node: queueNode<T>?) -> (queueNode<T>?, T?), queue<T>, nil);

	Returns iterator function.
]=]
function queue._prototype:iter<T>(): ((queue: queue<T>, node: queueNode<T>?) -> (queueNode<T>?, T?), queue<T>, nil)
	return queueIterator, self, nil
end

--[=[
	@return queue<T>;

	Clones queue.
]=]
function queue._prototype:clone<T>(): queue<T>
	local clone = setmetatable({
		_size = 0,
		_head = nil,
		_tail = nil,
	}, queue) :: queue<T>

	for _, n in self:iter() do
		clone:enqueue(n)
	end

	return clone
end

return table.freeze({
	newSet = function<T>(): set<T>
		return setmetatable({ _size = 0, _elements = {} }, set) :: set<T>
	end,

	newStack = function<T>(): stack<T>
		return setmetatable({ _size = 0, _head = nil }, stack) :: stack<T>
	end,

	newQueue = function<T>(): queue<T>
		return setmetatable({ _size = 0, _head = nil, _tail = nil }, queue) :: queue<T>
	end,
})
