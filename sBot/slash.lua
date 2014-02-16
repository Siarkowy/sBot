--------------------------------------------------------------------------------
-- sBot (c) 2014 by Siarkowy
-- Released under the terms of GNU GPL v3 license.
--------------------------------------------------------------------------------

local sBot = sBot

sBot.slash = {
    handler = sBot,
    type = "group",
    name = "sBot",
    args = {},
    plugins = {
        core = {
            header = {
                type = "header",
                name = "Modules",
                cmdHidden = true,
                order = 0,
            }
        }
    }
}
