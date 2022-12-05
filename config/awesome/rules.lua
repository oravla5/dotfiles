--      ██████╗ ██╗   ██╗██╗     ███████╗███████╗
--      ██╔══██╗██║   ██║██║     ██╔════╝██╔════╝
--      ██████╔╝██║   ██║██║     █████╗  ███████╗
--      ██╔══██╗██║   ██║██║     ██╔══╝  ╚════██║
--      ██║  ██║╚██████╔╝███████╗███████╗███████║
--      ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝╚══════╝

-- ===================================================================
-- Initialization
-- ===================================================================

local awful = require("awful")
local beautiful = require("beautiful")

-- define screen height and width
local screen_height = awful.screen.focused().geometry.height
local screen_width = awful.screen.focused().geometry.width

-- define module table
local rules = {}

-- ===================================================================
-- Rules
-- ===================================================================
--
-- return a table of client rules including provided keys / buttons
function rules.create(clientkeys, clientbuttons)
    return {
        -- All clients will match this rule
        {
            rule = {},
            properties = {
                titlebars_enabled = beautiful.titlebars_enabled,
                border_width = beautiful.border_width,
                border_color = beautiful.border_normal,
                focus = awful.client.focus.filter,
                raise = true,
                keys = clientkeys,
                buttons = clientbuttons,
                screen = awful.screen.preferred,
                placement = awful.placement.centered
            },
        },
        -- Floating clients
        {
            rule_any = {
                instance = {
                    --"Arandr",
                    --"Blueman-manager",
                    --"Gpick",
                    --"Kruler",
                    --"MessageWin",
                    --"Sxiv",
                    --"Top Browswer",
                    --"Wpa_gui",
                    --"xtightvncviewer",
                    "DTA",  -- Firefox addon DownThemAll
                    "copyq",    -- Includes session name in class
                    "pinentry", -- Password, pin entry utility
                },
                class = {
                    apps.network_manager,
                },
                name = {
                    "Event Tester",
                },
                role = {
                    "pop-up",   -- e.g. Google Chrome's (detached) Developer Tools
                }
            },
            properties = {
                floating = true
            }
        },
        -- Fullscreen clients
        {
            rule_any = {
                class = {},
            },
            properties = {
                fullscreen = true
            }
        },
        -- File chooser dialog
        {
            rule_any = {
                role = {"GtkFileChooserDialog"}},
            properties = {
                floating = true,
                width = screen_width * 0.55,
                height = screen_height * 0.65}
        },
        -- Pavucontrol & Bluetooth Devices
        {
            rule_any = {
                class = {
                    "Pavucontrol"
                },
                name = {
                    "Bluetooth Devices"
                }
            },
            properties = {
                floating = true,
                width = screen_width * 0.55,
                height = screen_height * 0.45
            }
        },
    }
end

-- return module table
return rules
