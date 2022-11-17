from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

from functions import Function

mod = "mod4"
alt = "mod1"
terminal = guess_terminal()

keys = [
    # Qtile
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),

    # Term
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    # Kill
    Key([mod], "c", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "c", Function.kill_all_windows_minus_current(), desc="Kill all windows except current"),
	Key([mod], "q", Function.kill_all_windows(), desc="Kill all windows"),

    # Window movement
    Key([mod], "h", lazy.group.prev_window(), desc="Move focus to previous window"),
    Key([mod], "l", lazy.group.next_window(), desc="Move focus to next window"),

    # Xmonad
    Key([mod, "shift"], "h", lazy.layout.shrink_main(), desc="Shrink main pane(Xmonad)"),
	Key([mod, "shift"], "l", lazy.layout.grow_main(), desc="Grow main pane(Xmonad)"),
    Key([mod, "control"], "Return", lazy.layout.swap_main(), desc="Swap current window to main pane(Xmonad)"),

    # Stack
    Key([mod], "s", lazy.layout.next(), desc="Move focus to another stack(Stack)"),
    Key([mod, "shift"], "n", lazy.layout.client_to_previous(), desc="Move window to previous stack side"),
	Key([mod, "shift"], "t", lazy.layout.client_to_next(), desc="Move window to next stack side"),

    # Split/Unsplit (Stack)
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),

    # Group movement
    Key([mod, "control"], "h", lazy.screen.prev_group(), desc="Move to previous group"),
    Key([mod, "control"], "l", lazy.screen.next_group(), desc="Move to next group"),

    # Cycle layout
    Key([mod, "control"], "space", lazy.next_layout(), desc="Next layout"),
    Key([mod, "control", "shift"], "space", lazy.prev_layout(), desc="Previous layout"),

    # Toggle floating
    Key([mod], "space", lazy.window.toggle_floating(), desc="Toggle floating"),

    # Toggle bar
    Key([mod, "shift"], "b", lazy.hide_show_bar("all"), desc="Toggle all screen bars"),
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
        ]
    )

layouts = [
    layout.MonadTall(),
    layout.MonadWide(),
    layout.Stack(num_stacks=2),
    layout.Floating(),
    layout.Zoomy(),
    layout.Max(),
]

widget_defaults = dict(
    font="JetBrains Mono",
    fontsize=10,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.GroupBox(),
                widget.Prompt(),
                widget.WindowName(),
                # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
                # widget.StatusNotifier(),
                widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
                widget.Systray(),
            ],
            16,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
