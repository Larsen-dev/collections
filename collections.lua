--[=[
    Free to modify.

    Structure: -->
    collections
    |- __packages
    |    |- queue.class --> create()
    |    |- stack.class --> create()
    |    |- set.class --> create()
    |- collections --> (
            queue()
            stack()
            set()
            len() or length()
        )
]=]

--Classes
local queueClass = require(script.Parent.__packages:FindFirstChild("queue.class"))
local stackClass = require(script.Parent.__packages:FindFirstChild("stack.class"))
local setClass = require(script.Parent.__packages:FindFirstChild("set.class"))

--Module
local collections = {}

--@return; Queue<T>;
function collections.queue<T>(): queueClass.Queue<T>
    return queueClass.create()
end

--@return; Stack<T>;
function collections.stack<T>(): stackClass.Stack<T>
    return stackClass.create()
end

--@return; Set<T>;
function collections.set<T>(): setClass.Set<T>
    return setClass.create()
end

--@return; number;
function collections.len(tableForMeasure: {[any]: T} | setClass.Set<T> | stackClass.Stack<T> | stackClass.Queue<T>): number
    local count: number = 0

    if type(tableForMeasure) == "table" then
        for _, _ in tableForMeasure do
            count += 1
        end
    else
        for _, _ in tableForMeasure._elements do
            count += 1
        end
    end

    return count
end

function collections.length(tableForMeasure: {[any]: T} | setClass.Set<T> | stackClass.Stack<T> | stackClass.Queue<T>): number
    return collections.len(tableForMeasure)
end

return collections