local request = http.get("https://raw.githubusercontent.com/IggyDeveloper1/chest-monitor/main/chest_monitor.lua")

if (not request) then
    error("Failed to make request")
    return;
end

local responseCode = request.getResponseCode()
if (responseCode ~= 200) then
    error("Failed to retrieve chest_monitor.lua, response code: " .. responseCode)
    return;
end

local chestMonitorContent = request.readAll()
request.close()

local function createFile(fileName, content)
    if (fs.exists(fileName)) then
        error("Process exited when trying to create file as it already exists. Please delete this file first before proceeding to prevent overwriting data. File name: " .. fileName)
    end

    local file = fs.open(fileName, "w")
    file.write(content)
    file.close()
end

createFile("chest_monitor.lua", chestMonitorContent)

local startupScript = [[
    function dofile (filename)
        local f = assert(loadfile(filename))
        return f()
    end

    dofile("chest_monitor.lua")
]]

createFile("startup.lua", startupScript)
os.reboot()
