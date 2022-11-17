local gears   = require("gears")
local lain    = require("lain")
local vicious = require("vicious")
local awful   = require("awful")
local wibox   = require("wibox")

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}

theme.font = "FiraCode Nerd Font 8"

theme.bg_normal   = "#0f0f0f"
theme.bg_focus    = "#0f0f0f"
theme.bg_urgent   = "#ff0000"
theme.bg_minimize = "#444444"
theme.bg_systray  = theme.bg_normal

theme.fg_normal   = "#aaaaaa"
theme.fg_focus    = "#f0f0f0"
theme.fg_urgent   = "#ffffff"
theme.fg_minimize = "#ffffff"

theme.useless_gap   = dpi(7)
theme.border_width  = dpi(2)
theme.border_normal = "#000000"
theme.border_focus  = "#535d6c"
theme.border_marked = "#91231c"

theme.fg_clock = "#6b7abc"
theme.fg_cpu = "#2666e7"
theme.fg_coretemp = "#bb0000"
theme.fg_memory = "#ff5d17"
theme.fg_fs = "#11c3dd"
theme.fg_bat = "#aaffaa"
theme.fg_uptime = "#dedf3a"
theme.fg_updates = "#d159da"
theme.fg_os = "#903237"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
theme.taglist_fg_focus = "#91231c"
-- tasklist_[bg|fg]_[focus|urgent]
theme.tasklist_fg_focus = "#f0f0f0"
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]

-- Generate taglist squares:
local taglist_square_size = dpi(5)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path .. "default/submenu.png"
theme.menu_height       = dpi(15)
theme.menu_width        = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = themes_path .. "default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = themes_path .. "default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path .. "default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path .. "default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path .. "default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path .. "default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active   = themes_path .. "default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active    = themes_path .. "default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path .. "default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path .. "default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active   = themes_path .. "default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active    = themes_path .. "default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path .. "default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path .. "default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active   = themes_path .. "default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active    = themes_path .. "default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path .. "default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path .. "default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = themes_path .. "default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = themes_path .. "default/titlebar/maximized_focus_active.png"

-- You can use your own layout icons like this:
-- theme.layout_fairh      = themes_path .. "default/layouts/fairhw.png"
-- theme.layout_fairv      = themes_path .. "default/layouts/fairvw.png"
-- theme.layout_floating   = themes_path .. "default/layouts/floatingw.png"
-- theme.layout_magnifier  = themes_path .. "default/layouts/magnifierw.png"
-- theme.layout_max        = themes_path .. "default/layouts/maxw.png"
-- theme.layout_fullscreen = themes_path .. "default/layouts/fullscreenw.png"
-- theme.layout_tilebottom = themes_path .. "default/layouts/tilebottomw.png"
-- theme.layout_tileleft   = themes_path .. "default/layouts/tileleftw.png"
-- theme.layout_tile       = themes_path .. "default/layouts/tilew.png"
-- theme.layout_tiletop    = themes_path .. "default/layouts/tiletopw.png"
-- theme.layout_spiral     = themes_path .. "default/layouts/spiralw.png"
-- theme.layout_dwindle    = themes_path .. "default/layouts/dwindlew.png"
-- theme.layout_cornernw   = themes_path .. "default/layouts/cornernww.png"
-- theme.layout_cornerne   = themes_path .. "default/layouts/cornernew.png"
-- theme.layout_cornersw   = themes_path .. "default/layouts/cornersww.png"
-- theme.layout_cornerse   = themes_path .. "default/layouts/cornersew.png"

local taglist_buttons = gears.table.join(
    awful.button({}, 1, function(t) t:view_only() end),
    awful.button({}, 3, awful.tag.viewtoggle)
)

local tasklist_buttons = gears.table.join(
    awful.button({}, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal(
                "request::activate",
                "tasklist",
                { raise = true }
            )
        end
    end),
    awful.button({}, 3, function()
        awful.menu.client_list({ theme = { width = 300 } })
    end)
)

local markup = lain.util.markup

function theme.at_screen_connect(s)
    -- Each screen has its own tag table.
    awful.tag({ "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({}, 1, function() awful.layout.inc(1) end),
        awful.button({}, 3, function() awful.layout.inc(-1) end)
    ))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Textclock
    os.setlocale(os.getenv("LANG")) -- to localize the clock
    local textclock = wibox.widget.textclock(markup(theme.fg_clock, " ") ..
        markup(theme.fg_clock, "%b %d (%a) %I:%M%p  "))
    textclock.font = theme.font

    -- Calendar
    theme.cal = lain.widget.cal({
        attach_to = { textclock },
        notification_preset = {
            font = theme.font,
            fg   = theme.fg_clock,
            bg   = theme.bg_normal
        }
    })

    -- CPU
    local cpu = lain.widget.cpu({
        settings = function()
            widget:set_markup(markup(theme.fg_cpu, "    ") ..
                markup.fontfg(theme.font, theme.fg_cpu, cpu_now.usage .. "%   "))
        end
    })

    -- CPU temp
    local temp = awful.widget.watch('bash -c "sensors | awk \'/CPU:/ { print $2 }\'"', 2, function(widget, stdout)
        widget:set_markup(markup.fontfg(theme.font, theme.fg_coretemp, " " .. stdout))
    end)

    -- Battery
    local bat = lain.widget.bat({
        settings = function()
            local perc = bat_now.perc ~= "N/A" and bat_now.perc .. "%" or bat_now.perc

            if bat_now.ac_status == 1 then
                perc = perc .. markup(theme.fg_bat, " ")
            end

            widget:set_markup(markup(theme.fg_bat, " ") ..
                markup.fontfg(theme.font, theme.fg_bat, perc .. "   "))
        end
    })

    --OS
    local os = wibox.widget.textbox()
    vicious.register(os, vicious.widgets.os, markup(theme.fg_os, " $2   "))

    -- Memory
    local memory = lain.widget.mem({
        settings = function()
            widget:set_markup(markup.fontfg(theme.font, theme.fg_memory,
                "    " .. mem_now.perc .. "% " .. mem_now.used .. "Mb   "))
        end
    })

    -- Uptime
    local uptime = wibox.widget.textbox()
    vicious.register(uptime, vicious.widgets.uptime, markup(theme.fg_uptime, " $1d $2h $3m   "), 30)

    -- Storage
    local fs = wibox.widget.textbox()
    vicious.register(fs, vicious.widgets.fs, markup(theme.fg_fs, " ${/ used_p}% (${/ used_mb}Mb/${/ size_mb}Mb)   ")
        , 60)

    -- Updates
    local updates = awful.widget.watch('bash -c "checkupdates | wc -l"', 3600, function(widget, stdout)
        widget:set_markup(markup.fontfg(theme.font, theme.fg_updates, "    " .. stdout))
    end)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            s.mylayoutbox,
            updates,
            cpu,
            temp,
            memory,
            fs,
            bat,
            uptime,
            os,
            textclock,
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
        },
    }
end

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
