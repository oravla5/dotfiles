local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

-- define module table
local top_panel = {}

-- ===================================================================
-- Bar Creation
-- ===================================================================

mytextclock = wibox.widget.textclock()
-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

--require("widgets.calendar").create,
top_panel.create = function(s)
    local margin = 3

    local function custom_shape(cr, width, height)
        gears.shape.transform(gears.shape.rounded_rect)
            :translate(margin, margin)(cr, width - 2 * margin, height - margin, 3)
    end

    local panel = awful.wibar({
        screen = s,
        position = "top",
        height = 30,
        shape = custom_shape,
    })

    panel:setup {
        {
            layout = wibox.layout.align.horizontal,
            {
                layout = wibox.layout.fixed.horizontal,
                s.mytaglist,
                s.mypromptbox,
            },
            s.mystasklist,
            {
                layout = wibox.layout.fixed.horizontal,
                mykeyboardlayout,
                mytextclock
            },
        },
        top = margin,
        left = margin,
        right = margin,
        widget = wibox.container.margin,
    }

end

return top_panel
