--------------------------------------------------------------------------------
-- sBot (c) 2014 by Siarkowy
-- Released under the terms of GNU GPL v3 license.
--------------------------------------------------------------------------------

local mod = sBot:NewModule("Resurrect", sBot.mod, "AceConsole-3.0", "AceEvent-3.0")
local enable

function mod:OnInitialize()
    self.name = "sBot Resurrect"
    sBot.slash.plugins.rezz = mod.slash
end

function mod:OnEnable()
    self:RegisterEvent("RESURRECT_REQUEST")
end

function mod:RESURRECT_REQUEST(event, rezzer)
    if not enable then return end

    self:Printf("Resurrected by %s. Disabling!", rezzer or UNKNOWN)

    AcceptResurrect()
    StaticPopup_Hide("RESURRECT")
    StaticPopup_Hide("RESURRECT_NO_SICKNESS")
    StaticPopup_Hide("RESURRECT_NO_TIMER")
end

mod.slash = {
    rezz = {
        handler = mod,
        type = "toggle",
        name = "Resurrect",
        desc = "Automatic resurrecting",
        get = function(info) return enable end,
        set = function(info, v) enable = v end,
        order = 5
    }
}
