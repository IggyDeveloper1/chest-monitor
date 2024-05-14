local currentLine = 1

local function writeItemInfo(monitor, itemName, itemQuantity, totalItems)
    local width, height = monitor.getSize()
    local textY = height / 2 - totalItems + currentLine;

    monitor.setTextColor(colors.white)
    monitor.setCursorPos(width / 2 - #itemName / 2, textY)
    monitor.write(itemName)

    monitor.setTextColor(colors.lightGray)
    monitor.setCursorPos(width / 2 - #itemQuantity / 2, textY + 1)
    monitor.write(itemQuantity)

    currentLine = currentLine + 3
end

function print_inventory_on_monitor(chest, monitor)
    local itemsList = chest.list()
    for _, item in pairs(itemsList) do
        local itemId = string.gsub(item.name, "minecraft:", "")
        local itemName = string.gsub(itemId, "_", " "):gsub("%f[%a].", string.upper)
        writeItemInfo(monitor, itemName, tostring(item.count), #itemsList)
    end
end

while true do
    local monitor = peripheral.find("monitor")
    local chest = peripheral.find("chest")

    monitor.clear()
    print_inventory_on_monitor(chest, monitor)

    sleep(10)
end
