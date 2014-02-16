--------------------------------------------------------------------------------
-- sBot (c) 2014 by Siarkowy
-- Released under the terms of GNU GPL v3 license.
--------------------------------------------------------------------------------

SBOT = "sBot"

sBot = LibStub("AceAddon-3.0"):NewAddon(
    {
        author = GetAddOnMetadata(SBOT, "Author"),
        version = GetAddOnMetadata(SBOT, "Version"),
        slash = { args = {}, plugins = {} }, -- slash command handlers
        mod = {}, -- module prototype
    },

    SBOT,

    -- embeds:
    "AceConsole-3.0",
    "AceEvent-3.0"
)

function sBot:Printf(...) self:Print(format(...)) end

function sBot:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("sBotDB", { profile = {} }, DEFAULT)
    self.slash.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
    self.slash.args.profile.guiHidden = true
    self.slash.args.profile.guiInline = true

    LibStub("AceConfig-3.0"):RegisterOptionsTable("sBot", self.slash)
    LibStub("AceConfig-3.0"):RegisterOptionsTable("sBot Profile", self.slash.args.profile)

    self.options = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("sBot", "sBot")
    self:RegisterChatCommand("sbot", "OnSlashCommand")

    for name, mod in self:IterateModules() do
        if not mod.plugin then
            LibStub("AceConfig-3.0"):RegisterOptionsTable(mod.name, mod.slash)
            mod.options = LibStub("AceConfigDialog-3.0"):AddToBlizOptions(mod.name, mod.moduleName, "sBot")
        end
    end

    LibStub("AceConfigDialog-3.0"):AddToBlizOptions("sBot Profile", "Profile", "sBot")
    self:Printf("Version %s loaded.", GetAddOnMetadata("sBot", "Version"))
end

function sBot:OnSlashCommand(input)
    -- if not input or input:trim() == "" then
        -- InterfaceOptionsFrame_OpenToFrame(self.options)
    -- else
        LibStub("AceConfigCmd-3.0").HandleCommand(self, "sbot", "sBot", input)
    -- end
end

local mod = sBot.mod

mod.Print = sBot.Print
mod.Printf = sBot.Printf
