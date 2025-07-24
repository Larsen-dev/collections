--Set
local setClass = {}

export type Set<T> = {
    _elements: {[T]: true | nil},
}

local set = {}
set.__index = set

function set:isIn(element: T): boolean
    return self._elements[element] == true
end

function set:add(element: T)
    self._elements[element] = true
end

function set:remove(element: T)
    if not self._elements[element] then return end

    self._elements[element] = nil
end

function set:pop(): T
    local toReturn: T

    for element, value in pairs(self._elements) do
        if value then
            toReturn = element
            break
        end
    end

    return toReturn
end

function set:clear()
    table.clear(self._elements)
end

function set:union(setForUnion: Set<T>): Set<T>
    local unionedSet = setClass.create()

    for element, _ in pairs(self._elements) do
        unionedSet:add(element) 
    end
    for element, _ in pairs(setForUnion._elements) do
        unionedSet:add(element) 
    end

    return unionedSet
end

function set:intersaction(setForIntersaction: Set<T>): Set<T>
    local intersactedSet = setClass.create()

    for element, _ in pairs(self._elements) do
        if setForIntersaction._elements[element] then
            intersactedSet:add(element)
        end
    end

    return intersactedSet
end

function set:difference(setToFindDifference: Set<T>): Set<T>
    local setWithDifference = setClass.create()

    for element, _ in pairs(self._elements) do
        if not setToFindDifference._elements[element] then
            setWithDifference:add(element)
        end
    end

    return setWithDifference
end

setmetatable(set, {
    __index = function(_, key)
        error(string.format("%s is not valid member of set.", key))
    end,
    __newindex = function(_, key)
        error(string.format("%s is not valid member of set.", key))
    end,
})

function setClass.create<T>(): Set<T>
    local newSet = {
        _elements = {}
    }
    return setmetatable(newSet, set) :: Set<T>
end

return setClass