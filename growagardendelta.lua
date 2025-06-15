local Players = game:GetService("Players")

-- Wait for LocalPlayer to exist
local player
repeat
    player = Players.LocalPlayer
    task.wait()
until player

-- Function to get executor name
local function getExecutorName()
    if identifyexecutor then
        return identifyexecutor()
    elseif getexecutorname then
        return getexecutorname()
    end
    return "Unknown"
end

-- Check if using Delta executor
local executorName = getExecutorName():lower()

if executorName:find("delta") then
    player:Kick("Delta Executor Is Not Supported, We are currently working on this now, Use other executor")
    return  -- Stop script execution
end