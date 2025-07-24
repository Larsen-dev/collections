--Queue
local queueClass = {}

export type Queue<T> = {
    _elements: {[number]: T},

    append: (self: Queue<T>, element: T) -> (),
    popLeft: (self: Queue<T>) -> (T),
}

local queue = setmetatable({}, {})
queue.__index = queue

function queue:append(element: T)
    table.insert(self._elements, element)
end

function queue:pop(): T
    return table.remove(self._elements, 1)
end

function queue:clear()
    table.clear(self._elements)
end

setmetatable(queue, {
    __index = function(_, key)
        error(string.format("%s is not valid member of queue.", key))
    end,
    __newindex = function(_, key)
        error(string.format("%s is not valid member of queue.", key))
    end,
})

function queueClass.create<T>(): Queue<T>
    local newQueue = {
        _elements = {},
    }

    return setmetatable(newQueue, queue) :: Queue<T>
end

return queueClass