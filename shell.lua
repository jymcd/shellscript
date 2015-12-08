local fs = filesystem or require("filesystem")
local computer = computer or require("computer")
local component = component or require("component")
local event = event or require("event")

local args = {...}

local commands = {
    echo = print,
    exit = "exit",
}

local function runCommand(command,cargs)
    --print(command,cargs)
    cargs = cargs or ""
    if command == "exit" then
        for k,_ in pairs(commands) do
            if commands.k == "exit" then
                os.exit()
            end
        end
    else
        return commands[command](cargs)
    end
end

local function split(inputstr)
        if sep == nil then
                sep = "%s"
        end
        local t={} ; i=1
        for str in string.gmatch(inputstr, '([^|]+)') do
                t[i] = str
                i = i + 1
        end
        return t
end

local usage = [[USAGE:
how to layout a command
<command>|<arg>
example from file
echo|hello world
example from command line
echo|"hello world"

shell -h : shows this message
shell -c [command] : runs single command
shell -f [filename.sh] : runs all commands in a file(do not include .sh)
]]

if args[1] == "-c" then
    local rCommArgs = split(args[2])
        runCommand(rCommArgs[1],rCommArgs[2])
elseif args[1] == "-f" then
    local file = assert(io.open(args[2]..".sh","r"))
    local com = {}
    for line in file:lines() do
        table.insert (com, line);
    end
    file:close()
    for i,v in ipairs(com) do
        local rCommArgs = split(com[i])
        runCommand(rCommArgs[1],rCommArgs[2])
    end
elseif args[1] == "-h" then
    print(usage)
else
    print(usage)
end
