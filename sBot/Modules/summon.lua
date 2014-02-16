--------------------------------------------------------------------------------
-- sBot (c) 2014 by Siarkowy
-- Released under the terms of GNU GPL v3 license.
--------------------------------------------------------------------------------

local mod = sBot:NewModule("Summon", sBot.mod, "AceConsole-3.0", "AceEvent-3.0")
local enable

function mod:OnInitialize()
    self.name = "sBot Summon"
    sBot.slash.plugins.summ = mod.slash
end

function mod:OnEnable()
    self:RegisterEvent("CONFIRM_SUMMON")
end

function mod:CONFIRM_SUMMON()
    if not enable then return end

    self:Printf("Summoned by %s.", GetSummonConfirmSummoner() or UNKNOWN)

    ConfirmSummon()
    StaticPopup_Hide("CONFIRM_SUMMON")
end

mod.slash = {
    summ = {
        handler = mod,
        type = "toggle",
        name = "Summon",
        desc = "Automatic summoning",
        get = function() return enable end,
        set = function(info, v) enable = v end,
        order = 10
    }
}
