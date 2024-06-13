# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
import sys
sys.path.append('/home/stock/data/linux/scripts/')
#import bitmexWidget
from datetime import datetime
from subprocess import call
import threading
import os
from libqtile.config import Key, Screen, Group, Drag, Click, ScratchPad, DropDown, Match
from libqtile.command import lazy
from libqtile import layout, bar, widget
from libqtile import hook

from typing import List  # noqa: F401

def main(qtile):
    # set logging level
    qtile.cmd_debug()

mod = "mod4"
#bitmex_widget = bitmexWidget.BitmexWidget()
work_hours_widget = widget.TextBox("", bar.CALCULATED, **{'background': "#073642"});

def toscreen(qtile, group_name):
    if group_name  == qtile.current_screen.group.name:
        qtile.current_screen.set_group(qtile.current_screen.previous_group)
    else:
        for i, group in enumerate(qtile.groups):
            if group_name == group.name:
                qtile.current_screen.set_group(qtile.groups[i])
                return

def on_window_showed(qtile):
    # they fucking changed something and now when window shows there is slight chance that it 
    # doesn't have an attribute which kills whole session
    # to be safe I am commenting this
    #if qtile.current_window.get_wm_class()[1] == "brave-browser":
    #    if qtile.current_window.height < qtile.current_screen.height:
    #        qtile.current_window.cmd_resize_floating(0, 69)

    #    qtile.current_window.cmd_set_position_floating(0, -69)
    pass

def change_abstract_window_state(qtile, state, group_name=""):
    if state == 1: #specific group showed
        toscreen(qtile, group_name)
    elif state == 2: #move to specific group
        qtile.current_window.togroup(group_name)
    elif state == 3: #show next group
        qtile.current_screen.next_group(skip_empty=True)
        call(["notify-send", "toggled"])
    elif state == 4: #show previous group
        call(["notify-send", "toggled"])
        qtile.current_screen.prev_group(skip_empty=True)
    elif state == 5:
        qtile.current_window.toggle_floating()
    on_window_showed(qtile)

def brave_hide_bar(qtile):
    qtile.current_window.cmd_opacity(1)
    qtile.current_window.cmd_disable_minimize()
    #qtile.current_screen.group.current_window().set_position_floating(0, 50)
    #qtile.current_screen.group.windows[0].set_position_floating(0, 50)

def shutdown(qtile):
    #bitmex_widget.close()
    pass
#    qtile.cmd_shutdown()
#    threading.Thread(target=lambda: call(["pkill", "qtile"])).start()

work_start_time = [None]
# Integers cannot be passed as reference so passing it in a list.
def toggle_work_hours_widget(start_time, widget):
    if start_time[0] is None:
        start_time[0] = datetime.now()
        widget.background = "#268BD2"
        widget.update("Working")
    else:
        file = open("/home/stock/data/Documents/Documents/work_hours.csv", "a")
        start = datetime.timestamp(start_time[0])
        end = datetime.timestamp(datetime.now())
        # Constructing ISO 8601 time string.
        starting_time = start_time[0].strftime("%Y-%m-%dT%H:%M:%S")
        total_seconds = int(end - start)
        total_minutes = float(total_seconds) / 60
        total_hours = float(total_seconds) / 3600
        file.write(f"{starting_time};{total_seconds};{total_minutes};{total_hours}\n")
        widget.background = "#073642"
        hours, remainder = divmod(int((datetime.now() - start_time[0]).total_seconds()), 3600)
        minutes, seconds = divmod(remainder, 60)
        widget.update(f"{hours}:{minutes}:{seconds}")
        start_time[0] = None
        file.close()
    widget.draw()


# specify which program should show up in group at launch
group_matches = [
    [Match(wm_class=[
    ], role=["browser"]), ],

    [Match(wm_class=[
        "VirtualBox Machine",
        "code-oss"
    ]), ],

    [Match(wm_class=[
         #"jetbrains-clion",
         "java-lang-Thread"
         ],wm_instance_class=[
         "jetbrains-clion",
             ]
    ), ],

    [Match(wm_class=[
    ], ), ],

    [Match(wm_class=[
        "Gimp", "Gthumb", "org.kde.gwenview",
        "Ristretto", "lximage-qt", "Eom",
        "Gpicview",
    ], role=["gimp-image-window"]), ],

    [Match(wm_class=[
        "vlc", "xv/mplayer", "Clementine",
        "MPlayer", "smplayer", "mpv",
        "Gnome-mpv", "Rhythmbox", "Pragha",
        "discord",
    ]), ],

    [Match(wm_class=[
        "Steam", "Wine", "Zenity",
        "PlayOnLinux",
    ]), ],

    [Match(wm_class=[
    ]), ],
    None,
    None,
]


groups =  [
        Group('a', matches=group_matches[0], label='a: '),
        Group('s', matches=group_matches[1], label='s: '),
        Group('d', matches=group_matches[2], label='d: '),
        Group('f', matches=group_matches[3], label='f'),
        Group('x', matches=group_matches[4], label='x'),
        Group('c', matches=group_matches[5], label='c'),
        Group('u', matches=group_matches[6], label='u'),
        Group('i', matches=group_matches[7], label='i'),
        Group('o', matches=group_matches[8], label='o'),
        Group('p', matches=group_matches[9], label='p'),
        #ScratchPad("scratchpad", [
        #    DropDown("term", "urxvt", opacity=0.8),

        #    DropDown("qshell", "urxvt -hold -e bash",
        #        x=0.05, y=0.4, width=0.9, height=0.6, opacity=0.9,
        #        on_focus_lost_hide=True) ]),
        ]

keys = [
    # Layout hotkeys
    Key([mod, "control"], "h", lazy.layout.shrink_main()),
    Key([mod, "control"], "l", lazy.layout.grow_main()),
    Key([mod, "control"], "j", lazy.layout.down()),
    Key([mod, "control"], "k", lazy.layout.up()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    #Key([mod], "grave", lazy.screen.next_group(skip_empty=True)),
    #Key([mod], "Tab", lazy.screen.prev_group(skip_empty=True)),


    # Toggle between different layouts as defined below
    Key([mod], "m", lazy.prev_layout()),
    Key([mod, "shift"], "m", lazy.next_layout()),
    Key([mod], "w", lazy.window.kill()),
    Key([mod], "space", lazy.function(lambda qtile: qtile.cmd_hide_show_bar())),
    Key([mod, 'control'], "m", lazy.function(change_abstract_window_state, state=5)),
    Key([mod, 'control'], "n", lazy.window.resize_floating(0, 69)),
    Key([mod, 'shift'], "n", lazy.window.move_floating(-1, -69)),
    # Lazy functions do not capture variables so passing lambda instead.
    Key([mod, 'control'], "w", lazy.function(lambda qtile: toggle_work_hours_widget(work_start_time, work_hours_widget))),

#    Key([mod, "control"], "r", lazy.restart()),
    #Key([mod, "control"], "q", lazy.function(shutdown)),
    #Key([], 'F11', lazy.group['scratchpad'].dropdown_toggle('term')),
    #Key([], 'F12', lazy.group['scratchpad'].dropdown_toggle('qshell')),
]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        #Key([mod], i.name, lazy.group[i.name].toscreen()),
        # switch to group with ability to go to prevous group if pressed again
        #Key([mod], i.name, lazy.function(toscreen, i.name)),
        Key([mod], i.name, lazy.function(change_abstract_window_state, state=1, group_name=i.name)),

        # mod1 + shift + letter of group = switch to & move focused window to group
        #Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
        Key([mod, "shift"], i.name, lazy.function(change_abstract_window_state, state=2, group_name=i.name)),
        ])
    layout_style = {
            'margin': 0,
            'border_width': 1,
            'border_normal': '#002B36',
            #'border_focus': '#FF2AA198',
            'border_focus': '#859900',
            'single_border_width': 0,
            'single_margin': 0,

            }

    layouts = [
            layout.MonadTall(**layout_style),
            layout.Max(),
            layout.MonadWide(**layout_style),
            layout.RatioTile(**layout_style),
            layout.VerticalTile(**layout_style),
            layout.Floating(**layout_style),
            #    layout.Stack(num_stacks=2),
            #    layout.Bsp(),
            #    layout.Columns(),
            #    layout.Matrix(),
            #    layout.Tile(),
            #    layout.TreeTab(),
            #    layout.Zoomy(),
            ]

    widget_defaults = dict(
            #foreground='#93A1A1',
            #foreground='#DFD9B6',
            foreground='#DAD4B1',
            #foreground='#839496',
            font='sans',
            fontsize=12,
            padding=3,
            )
    extension_defaults = widget_defaults.copy()

keys.append(Key([mod, "control"], "space", lazy.window.toggle_floating()))
keys.append(Key([mod, "shift"], "space", lazy.layout.command_sublayout('*', 'nextarrangement')))

for key, x, y in [("Left", -10, 0), 
                  ("Right", 10, 0), 
                  ("Up", 0, -10),
                  ("Down", 0, 10)]:
    keys.append(Key([mod, "control"], key, lazy.window.move_floating(x, y)))
    keys.append(Key([mod, "shift"], key, lazy.window.resize_floating(x, y)))
    keys.append(Key([mod, "mod1"], key, lazy.window.move_to_screen_edge(key)))

bar_style = {
        'background': '#073642',
        'foreground': '#FFFFFF',
        #'foreground': '#586E75',
        #'border_width': 10,
        #'border_normal': '#FF586E75',
        #'opacity': 0.7,
        }

group_box_style = {
        #foreground='#657B83',
        'inactive': '#586e75',
        'highlight_method': 'line',
        #'this_current_screen_border': '#268BD2',
        #'this_current_screen_border': '#859900',
        #'this_current_screen_border': '#2AA198',
        'this_current_screen_border': '#2AA198',
        #'active': '#93A1A1',
        'active': '#DAD4B1',
        'rounded': False,
        'border_width': 1,
        'disable_drag': True,
        'spacing': 0,
        'highlight_color': '073642',
        #    'margin': 1,
        }

screens = [
        Screen(
            bottom=bar.Bar(
                [
                    widget.CurrentLayoutIcon(scale=0.8),
                    widget.GroupBox(**group_box_style),
                    widget.Prompt(),
                    widget.WindowName(),
                    #bitmex_widget,
                    widget.Systray(),
                    work_hours_widget,
                    widget.Clock(format='%d/%m/%Y %a %H:%M'),
                    ],
                24,
                **bar_style,
                ),
            ),
        Screen(
            bottom=bar.Bar(
                [
                    widget.CurrentLayoutIcon(scale=0.8),
                    widget.GroupBox(**group_box_style),
                    widget.Prompt(),
                    widget.WindowName(),
                    #bitmex_widget,
                    widget.Systray(),
                    work_hours_widget,
                    widget.Clock(format='%d/%m/%Y %a %H:%M'),
                    ],
                24,
                **bar_style,
                ),
            ),
        ]

# Drag floating layouts.
mouse = [
        Drag([mod], "Button1", lazy.window.set_position_floating(),
            start=lazy.window.get_position()),
        Drag([mod], "Button3", lazy.window.set_size_floating(),
            start=lazy.window.get_size()),
        Click([mod], "Button2", lazy.window.bring_to_front())
        ]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
float_rules=[
    Match(wm_class='confirm'),
    Match(wm_class='dialog'),
    Match(wm_class='download'),
    Match(wm_class='error'),
    Match(wm_class='file_progress'),
    Match(wm_class='notification'),
    Match(wm_class='splash'),
    Match(wm_class='toolbar'),
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(wm_class='brave-browser'),
    Match(wm_class='sun-awt-X11-XWindowPeer'),  # <----  pycharm popups
]

@hook.subscribe.client_new
def float_pycharm(window):
    wm_class = window.window.get_wm_class()
    wm_name = window.window.get_name()
    #s = str(wm_class) + " " + wm_name

    #if (wm_class == ("jetbrains-clion", "jetbrains-clion") and  w_name.startswith("Documentation - ")):
        #window.floating = True
    # if we have multiple windows open from tool windows then, by default every other window will 
    # go to group where tool window is, to prevent that we move it back to default group
    # I won't be working on multiple projects at the same time so this is ok
    if (wm_class[0] == "jetbrains-clion"):
        #os.popen('notify-send "' + s + '"')
        window.togroup(groups[2].name)

floating_layout_style = {
        'float_rules': float_rules,
        'border_width': 0,
        'border_normal': '#000000',
        'border_focus': '#007ACC',
        }

floating_layout = layout.Floating(**floating_layout_style)
auto_fullscreen = True
focus_on_window_activation = "smart"
#single_border_width=0

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
