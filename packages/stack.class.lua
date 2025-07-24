--Stack
local stackClass = {}

export type Stack<T> = {
    _last: number,
    _elements: {[number]: T},

    append: (self: Stack<T>, element: T) -> (),
    pop: (self: Stack<T>) -> (T),
}

local stack = {}
stack.__index = stack

function stack:append(element: T)
    table.insert(self._elements, element)
    self._last = #self._elements
end

function stack:pop(): T
    local toReturn = table.remove(self._elements, self._last)
    self._last -= 1

    return toReturn
end

function stack:clear()
    table.clear(self._elements)
end

setmetatable(stack, {
    __index = function(_, key)
        error(string.format("%s is not valid member of stack.", key))
    end,
    __newindex = function(_, key)
        error(string.format("%s is not valid member of stack.", key))
    end,
})

function stackClass.create<T>(): Stack<T>  
    local newStack = {
        _last = 0,
        _elements = {},
    }

    return setmetatable(newStack, stack) :: Stack<T>
end

return stackClass