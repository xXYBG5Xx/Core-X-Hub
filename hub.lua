local Hub = {}
local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/xXYBG5Xx/Core-X-Hub/main/ui.lua"))()

function Hub.Init()
    local success, err = pcall(function()
        UI.CreateMain()
    end)

    if success then
        UI.Notify("Script status", "عمل (تمت عملية الحقن بنجاح)", 4)
    else
        UI.Notify("Script status", "فشل التحميل: " .. tostring(err), 5)
    end
end

return Hub
