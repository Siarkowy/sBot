--------------------------------------------------------------------------------
-- sBot (c) 2014 by Siarkowy
-- Released under the terms of GNU GPL v3 license.
--------------------------------------------------------------------------------

local mod = sBot:NewModule("Loot", sBot.mod, "AceConsole-3.0", "AceEvent-3.0")

local actions = {
    [0] = "Pass",
    [1] = "Need",
    [2] = "Greed",
}

function mod:OnInitialize()
    self.name = "sBot Loot"
    self.db = sBot.db:RegisterNamespace("Loot", { profile = { } })
    sBot.slash.args.loot = mod.slash
end

function mod:OnEnable()
    self:RegisterEvent("START_LOOT_ROLL")
end

function mod:START_LOOT_ROLL(id, time)
    local action = self.db.profile[tonumber(GetLootRollItemLink(id):match("item:(%d+)"))]
    if action then RollOnLoot(id, action) end
end

mod.slash = {
    handler = mod,
    type = "group",
    name = "Loot",
    desc = "Automatic loot rolling",
    cmdInline = false,
    guiInline = true,
    guiHidden = true,
    args = {
        need = {
            type = "input",
            name = "Need",
            desc = "Need on item",
            set = function(info, v)
                local id = tonumber(v:match("item:(%d+)") or v)
                if id then mod.db.profile[id] = 1 end
            end,
            order = 1
        },
        greed = {
            type = "input",
            name = "Greed",
            desc = "Greed on item",
            set = function(info, v)
                local id = tonumber(v:match("item:(%d+)") or v)
                if id then mod.db.profile[id] = 2 end
            end,
            order = 2
        },
        pass = {
            type = "input",
            name = "Pass",
            desc = "Pass on item",
            set = function(info, v)
                local id = tonumber(v:match("item:(%d+)") or v)
                if id then mod.db.profile[id] = 0 end
            end,
            order = 3
        },
        clear = {
            type = "input",
            name = "Clear",
            desc = "Clear roll action on item",
            set = function(info, v)
                local id = tonumber(v:match("item:(%d+)") or v)
                if id then mod.db.profile[id] = nil end
            end,
            order = 4
        },
        list = {
            type = "execute",
            name = "List",
            desc = "List roll actions",
            func = function(info)
                mod:Print("List of roll actions:")

                for id, action in pairs(mod.db.profile) do
                    DEFAULT_CHAT_FRAME:AddMessage(format("   %s on %s",
                    actions[action], select(2, GetItemInfo(id)) or UNKNOWN))
                end
            end,
            order = 5
        },
    },
    order = 15
}
