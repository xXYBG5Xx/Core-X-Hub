-- الرابط الأساسي للمستودع الخاص بك (استخدمنا هنا روابط Raw مباشرة لملفاتك)
local baseUrl = "https://raw.githubusercontent.com/xXYBG5Xx/RedFox-Zero-Hub/main/"

-- 1. تحميل ملف الأوامر والوظائف وتجهيزه في الذاكرة
_G.RedFoxCommands = loadstring(game:HttpGet(baseUrl .. "commands.lua"))()

-- 2. تشغيل ملف الواجهة (UI) واظهاره على الشاشة
loadstring(game:HttpGet(baseUrl .. "ui.lua"))()
