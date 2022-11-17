local gears   = require("gears")
local lain    = require("lain")
local awful   = require("awful")
local wibox   = require("wibox")

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}

theme.font = "Mononoki Nerd Font 10"

theme.bg_normal   = "#0f0f0f"
theme.bg_focus    = "#0f0f0f"
theme.bg_urgent   = "#ff0000"
theme.bg_minimize = "#0f0f0f"
theme.bg_systray  = theme.bg_normal

theme.fg_normal   = "#aaaaaa"
theme.fg_focus    = "#f0f0f0"
theme.fg_urgent   = "#ffffff"
theme.fg_minimize = "#777777"

theme.useless_gap   = dpi(2)
theme.border_width  = dpi(2)
theme.border_normal = "#000000"
theme.border_focus  = "#535d6c"
theme.border_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
theme.taglist_fg_empty = "#555555"
theme.taglist_fg_occupied = "#bbbbbb"
theme.taglist_fg_focus = "#ffffff"
-- tasklist_[bg|fg]_[focus|urgent]
theme.tasklist_fg_focus = "#f0f0f0"
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]

-- Generate taglist squares:
local taglist_square_size = dpi(6)
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

theme.layout_txt_tile       = " [T]  "
theme.layout_txt_tileleft   = " [Tl]  "
theme.layout_txt_tilebottom = " [Tb]  "
theme.layout_txt_tiletop    = " [Tt]  "
theme.layout_txt_fairv      = " [Fv]  "
theme.layout_txt_fairh      = " [Fh]  "
theme.layout_txt_spiral     = " [S]  "
theme.layout_txt_dwindle    = " [D]  "
theme.layout_txt_max        = " [Max]  "
theme.layout_txt_fullscreen = " [FS]  "
theme.layout_txt_magnifier  = " [M]  "
theme.layout_txt_floating   = " [F]  "

-- lain
theme.layout_txt_termfair    = " [TF]  "
theme.layout_txt_centerfair  = " [CF]  "
theme.layout_txt_cascade     = " [C]  "
theme.layout_txt_cascadetile = " [Ct]  "
theme.layout_txt_centerwork  = " [Cw]  "
theme.layout_txt_centerworkh = " [Cwh]  "


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

local function update_txt_layoutbox(s)
    -- Writes a string representation of the current layout in a textbox widget
    local txt_l = theme["layout_txt_" .. awful.layout.getname(awful.layout.get(s))] or ""
    s.mytxtlayoutbox:set_text(txt_l)
end

function theme.at_screen_connect(s)
    -- Each screen has its own tag table.
    awful.tag({ " 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 " }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mytxtlayoutbox = wibox.widget.textbox(theme["layout_txt_" .. awful.layout.getname(awful.layout.get(s))])

    awful.tag.attached_connect_signal(s, "property::selected", function() update_txt_layoutbox(s) end)
    awful.tag.attached_connect_signal(s, "property::layout", function() update_txt_layoutbox(s) end)
    s.mytxtlayoutbox:buttons(gears.table.join(
        awful.button({}, 1, function() awful.layout.inc(1) end),
        awful.button({}, 2, function() awful.layout.set(awful.layout.layouts[1]) end),
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
    local textclock = wibox.widget.textclock(markup(theme.fg_focus, "%Y %b %d (%a) %I:%M%p      "))
    textclock.font = theme.font

    -- Calendar
    theme.cal = lain.widget.cal({
        attach_to = { textclock },
        notification_preset = {
            font = theme.font,
            fg   = theme.fg_focus,
            bg   = theme.bg_normal
        }
    })

    -- Battery
    local bat = lain.widget.bat({
        settings = function()
            local perc = bat_now.perc ~= "N/A" and bat_now.perc .. " %" or bat_now.perc

            if bat_now.ac_status == 1 then
                perc = perc .. markup(theme.fg_focus, " ")
            end

            widget:set_markup(markup(theme.fg_focus, "  ") ..
                markup.fontfg(theme.font, theme.fg_focus, perc .. "      "))
        end
    })

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mytxtlayoutbox,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            bat,
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

awful.spawn.with_shell("killall -q conky")
awful.spawn.with_shell("sleep 2 && conky -c $HOME/.config/awesome/minimal/conkyrc")

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
