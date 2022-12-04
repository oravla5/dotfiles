--      ██╗  ██╗███████╗██╗   ██╗███████╗
--      ██║ ██╔╝██╔════╝╚██╗ ██╔╝██╔════╝
--      █████╔╝ █████╗   ╚████╔╝ ███████╗
--      ██╔═██╗ ██╔══╝    ╚██╔╝  ╚════██║
--      ██║  ██╗███████╗   ██║   ███████║
--      ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝


-- ===================================================================
-- Initialization
-- ===================================================================

 
local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")
local dpi = beautiful.xresources.apply_dpi

-- Define mod keys
local modkey = "Mod4"
local altkey = "Mod1"

-- define module table
local keys = {}

-- ===================================================================
-- Movement Functions (Called by some keybinds)
-- ===================================================================


-- Move given client to given direction
local function move_client(c, direction)
    -- If client is floating, move to the edge
    if c.floating or (awful.layout.get(mouse.screen) == awful.layout.suit.floating) then
        local workarea = awful.screen.focused().workarea

        if direction == "up" then
            c:geometry({nil, y = workarea.y + beautiful.useless_gap * 2, nil, nil})
        elseif direction == "down" then
            c:geometry({nil, y = workarea.height + workarea.y - c:geometry().height - beautiful.useless_gap * 2 - beautiful.border_width * 2, nil, nil})
        elseif direction == "left" then
            c:geometry({x = workarea.x + beautiful.useless_gap * 2, nil, nil, nil})
        elseif direction == "right" then
            c:geometry({x = workarea.width + workarea.x - c:geometry().width - beautiful.useless_gap * 2 - beautiful.border_width * 2, nil, nil, nil})
        end
    -- Otherwise swap the client in the tiled layout
    elseif awful.layout.get(mouse.screen) == awful.layout.suit.max then
        if direction == "up" or direction == "left" then
            awful.client.swap.byidx(-1, c)
        elseif direction == "down" or direction == "right" then
            awful.client.swap.byidx(1, c)
        end
    else
        awful.client.swap.bydirection(direction, c, nil)
    end
end

-- Resize client in given direction
local floating_resize_amount = dpi(20)
local tiling_resize_factor = 0.01

local function resize_client(c, direction)
   if awful.layout.get(mouse.screen) == awful.layout.suit.floating or (c and c.floating) then
      if direction == "up" then
         c:relative_move(0, 0, 0, -floating_resize_amount)
      elseif direction == "down" then
         c:relative_move(0, 0, 0, floating_resize_amount)
      elseif direction == "left" then
         c:relative_move(0, 0, -floating_resize_amount, 0)
      elseif direction == "right" then
         c:relative_move(0, 0, floating_resize_amount, 0)
      end
   else
      if direction == "up" then
         awful.client.incwfact(-tiling_resize_factor)
      elseif direction == "down" then
         awful.client.incwfact(tiling_resize_factor)
      elseif direction == "left" then
         awful.tag.incmwfact(-tiling_resize_factor)
      elseif direction == "right" then
         awful.tag.incmwfact(tiling_resize_factor)
      end
   end
end


-- raise focused client
local function raise_client()
   if client.focus then
      client.focus:raise()
   end
end

-- ===================================================================
-- Mouse bindings
-- ===================================================================

-- Mouse buttons on the desktop
keys.desktopbuttons = gears.table.join(
   -- left click on desktop to hide notification
   awful.button({}, 1,
      function ()
         naughty.destroy_all_notifications()
      end
   )
)

-- Mouse buttons on the client
keys.clientbuttons = gears.table.join(
   -- Raise client
   awful.button({}, 1,
      function(c)
         client.focus = c
         c:raise()
      end
   ),

   -- Move and Resize Client
   awful.button({modkey}, 1, awful.mouse.client.move),
   awful.button({modkey}, 3, awful.mouse.client.resize)
)

-- ===================================================================
-- Desktop Key bindings
-- ===================================================================


keys.globalkeys = gears.table.join(
    -- =========================================
    -- SPAWN APPLICATION KEY BINDINGS
    -- =========================================

    -- Spawn terminal
    awful.key({modkey}, "Return",
        function()
            awful.spawn(apps.terminal)
        end,
        {description = "open a terminal", group = "launcher"}
    ),

    -- Spawn browswer window
    awful.key({ modkey }, "b",
        function()
            awful.spawn(apps.web_browser)
        end,
        { description = "Launch web browser", "launcher" }
    ),

    -- Launch rofi
    awful.key({modkey}, "d",
        function()
          awful.spawn(apps.launcher)
        end,
        { description = "application launcher", group = "launcher" }
    ),

    -- =========================================
    -- RELOAD / QUIT AWESOME
    -- =========================================
    awful.key({modkey}, "/",
        hotkeys_popup.show_help,
        { description = "Show help", group = "awesome" }
    ),

    -- Reload Awesome
    awful.key({modkey, "Shift"}, "r",
        awesome.restart,
        { description = "Reload awesome", group = "awesome" }
    ),

    -- Quit Awesome
    awful.key({modkey}, "Escape",
        function()
            -- emit signal to show the exit screen
            awesome.emit_signal("show_exit_screen")
        end,
        { description = "toggle exit screen", group = "awesome" }
    ),

    awful.key({}, "XF86PowerOff",
        function()
            -- emit signal to show the exit screen
            awesome.emit_signal("show_exit_screen")
        end,
        { description = "toggle exit screen", group = "awesome" }
    ),

    -- =========================================
    -- CLIENT FOCUSING
    -- =========================================

    -- Focus client by direction (hjkl keys)
    awful.key({modkey}, "j",
        function()
            awful.client.focus.bydirection("down")
            raise_client()
        end,
        { description = "Focus down", group = "client" }
    ),
    awful.key({modkey}, "k",
        function()
            awful.client.focus.bydirection("up")
            raise_client()
        end,
        { description = "Focus up", group = "client" }
    ),
    awful.key({modkey}, "h",
        function()
            awful.client.focus.bydirection("left")
            raise_client()
        end,
        { description = "Focus left", group = "client" }
    ),
    awful.key({modkey}, "l",
        function()
            awful.client.focus.bydirection("right")
            raise_client()
        end,
        { description = "Focus right", group = "client" }
    ),

    -- Focus client by direction (arrow keys)
    awful.key({modkey}, "Down",
        function()
            awful.client.focus.bydirection("down")
            raise_client()
        end,
        { description = "Focus down", group = "client" }
    ),
    awful.key({modkey}, "Up",
        function()
            awful.client.focus.bydirection("up")
            raise_client()
        end,
        { description = "Focus up", group = "client" }
    ),
    awful.key({modkey}, "Left",
        function()
            awful.client.focus.bydirection("left")
            raise_client()
        end,
        { description = "Focus left", group = "client" }
    ),
    awful.key({modkey}, "Right",
        function()
            awful.client.focus.bydirection("right")
            raise_client()
        end,
        { description = "Focus right", group = "client" }
    ),

    -- =========================================
    -- SCREEN FOCUSING
    -- =========================================

    -- Focus screen by index (cycle through screens)
    awful.key({modkey}, "s",
        function()
            awful.screen.focus_relative(1)
        end,
        { description = "Focus on next screen", group = "screen" }
    ),

    -- =========================================
    -- CLIENT RESIZING
    -- =========================================

    -- Resize client (hjkl keys)
    awful.key({modkey, "Control"}, "Down",
        function(c)
            resize_client(client.focus, "down")
        end,
        { description = "Resize down", group = "client" }
    ),
    awful.key({modkey, "Control"}, "Up",
        function(c)
            resize_client(client.focus, "up")
        end,
        { description = "Resize up", group = "client" }
    ),
    awful.key({modkey, "Control"}, "Left",
        function(c)
            resize_client(client.focus, "left")
        end,
        { description = "Resize left", group = "client" }
    ),
    awful.key({modkey, "Control"}, "j",
        function(c)
            resize_client(client.focus, "down")
        end,
        { description = "Resize down", group = "client" }
    ),
    awful.key({modkey, "Control"}, "k",
        function(c)
            resize_client(client.focus, "up")
        end,
        { description = "Resize up", group = "client" }
    ),
    awful.key({modkey, "Control"}, "h",
        function(c)
            resize_client(client.focus, "left")
        end,
        { description = "Resize left", group = "client" }
    ),
    awful.key({modkey, "Control"}, "l",
        function(c)
            resize_client(client.focus, "right")
        end,
        { description = "Resize right", group = "client" }
    ),

    -- =========================================
    -- GAP CONTROL
    -- =========================================

    -- Gap control
    awful.key({modkey, "Shift"}, "minus",
        function()
            awful.tag.incgap(5, nil)
        end,
        { description = "increment gaps size for the current tag", group = "gaps" }
    ),

    awful.key({modkey}, "minus",
        function()
            awful.tag.incgap(-5, nil)
        end,
        { description = "decrement gap size for the current tag", group = "gaps" }
    ),

    -- =========================================
    -- LAYOUT SELECTION
    -- =========================================

    -- select next layout
    awful.key({modkey}, "space",
        function()
            awful.layout.inc(1)
        end,
        { description = "select next", group = "layout" }
    ),

    -- select previous layout
    awful.key({modkey, "Shift"}, "space",
        function()
            awful.layout.inc(-1)
        end,
        { description = "select previous", group = "layout" }
    )
)

-- ===================================================================
-- Client Key bindings
-- ===================================================================

keys.clientkeys = gears.table.join(
    -- Move to edge or swap by direction (arrow keys)
    awful.key({modkey, "Shift"}, "Down",
        function(c)
            move_client(c, "down")
        end
    ),
    awful.key({modkey, "Shift"}, "Up",
        function(c)
            move_client(c, "up")
        end
    ),
    awful.key({modkey, "Shift"}, "Left",
        function(c)
            move_client(c, "left")
        end
    ),
    awful.key({modkey, "Shift"}, "Right",
        function(c)
            move_client(c, "right")
        end
    ),
    -- Move to edge or swap by direction (hjkl keys)
    awful.key({modkey, "Shift"}, "j",
        function(c)
             move_client(c, "down")
        end
    ),
    awful.key({modkey, "Shift"}, "k",
        function(c)
            move_client(c, "up")
        end
    ),
    awful.key({modkey, "Shift"}, "h",
        function(c)
            move_client(c, "left")
        end
    ),
    awful.key({modkey, "Shift"}, "l",
        function(c)
            move_client(c, "right")
        end
    ),
    -- toggle fullscreen
    awful.key({ modkey }, "f",
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        { description = "Toggle fullscreen", group = "client" }
    ),

    -- close client
    awful.key({ modkey }, "q",
        function(c)
            c:kill()
        end,
        { description = "Close", group = "client" }
    ),

    -- Minimize
    awful.key({modkey}, "n",
        function(c)
            c.minimized = true
        end,
        { description = "minimize", group = "client" }
    ),

    -- Maximize
    awful.key({modkey}, "m",
        function(c)
            c.maximized = not c.maximized
            c:raise()
        end,
        { description = "(un)maximize", group = "client" }
    )
)

-- Bind all key numbers to tags
for i = 1, 9 do
    keys.globalkeys = gears.table.join(keys.globalkeys,
        -- Switch to tag
        awful.key({modkey}, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            { description = "view tag #"..i, group = "tag" }
        ),
        -- Move client to tag
        awful.key({modkey, "Shift"}, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            { description = "move focused client to tag #"..i, group = "tag" }
        )
    )
end

return keys



