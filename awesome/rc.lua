-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
--local hotkeys_popup = require("awful.hotkeys_popup.widget")
local lain = require("lain")
local vicious = require("vicious")
local blingbling = require("blingbling")

naughty.config.defaults.position = "bottom_right"

function awprint(msg)
    naughty.notify({text = msg})
end

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init("~/.config/awesome/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = "gvim"
editor_cmd = editor
screenshot_cmd = "scrot '%Y-%m-%d-%T_$wx$h_scrot.png' -e 'mv $f ~/pictures/screenshots/'"


-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"



-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    --awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.magnifier,

}
-- }}}

-- {{{ Helper functions

-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Tags
function create_tags()
    local tags = {}
    local t = awful.layout.suit.tile.left
    local tt = awful.layout.suit.tile.top
    local f = awful.layout.suit.floating
    local m = awful.layout.suit.max
    local tag_data = {
        {"code"    , tt },
        {"internet", t },
        {"game"    , f },
        {"cad"     , t },
        {"music"   , t },
        {"photo"   , t },
        {"video"   , t },
        {"vm"      , t },
        {"console" , t },
    }
    local tag_names = {}
    local tag_layouts = {}
    local i = 1
    for k,v in pairs(tag_data) do
        table.insert(tag_names,tostring(i) .. ":" .. v[1]) -- prepends tag index to the name
        table.insert(tag_layouts,v[2])
        i = i + 1
    end

    for s = 1, screen.count() do
        -- Each screen has its own tag table.
        tags[s] = awful.tag(tag_names, s, tag_layouts)
    end

    return tags,tag_names
end


tags,tag_names = create_tags()

-- find a tag object by full or partial tag name
function find_tag_by_name(name)
    for i = 1, #tag_names do
        if string.find(tag_names[i], name) ~= nil then
            return tags[1][i]
        end
    end
    return nil
end

-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
menu_awesome = {
--   { "hotkeys", function() return false, hotkeys_popup.show_help end},
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

menu_power = {
   { "Sleep", "systemctl suspend" },
   { "Hibernate", "systemctl hibernate" },
   { "Reboot", "systemctl reboot" },
   { "Power Off", "systemctl poweroff" },
}

menu_main = {
   { "Power", menu_power },
   { "Awesome", menu_awesome, beautiful.awesome_icon },
}


mymainmenu = awful.menu({ items = menu_main })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}



-- Number of available package updates
local pkgwidgetbox = wibox.layout.fixed.horizontal()
local pkgwidgetlabel = wibox.widget.textbox("Upd: ")
pkgwidgetbox:add(pkgwidgetlabel)
pkgwidget = wibox.widget.textbox()
vicious.register(pkgwidget, vicious.widgets.pkg, "$1", 1800, "Arch")
pkgwidgetbox:add(pkgwidget)

-- CPU
vicious.cache(vicious.widgets.cpu) -- this line is important!
local cpuwidgetbox = wibox.layout.fixed.horizontal()
local cpuwidgetlabel = wibox.widget.textbox("CPU")
cpuwidgetbox:add(cpuwidgetlabel)
local cpuwidget = blingbling.line_graph()
cpuwidget:set_width(100)
vicious.register(cpuwidget, vicious.widgets.cpu, "$1",1)
cpuwidgetbox:add(cpuwidget)
-- add cores label
local cpucoreslabel = wibox.widget.textbox("Cores")
cpuwidgetbox:add(cpucoreslabel)
-- add cores graphs
for i=1,(#vicious.widgets.cpu() - 1) do
    local core=blingbling.line_graph()
    core:set_width(24)
    vicious.register(core, vicious.widgets.cpu, "$"..(i+1).."", 1)
    cpuwidgetbox:add(core)
end


-- Memory
local memwidgetbox = wibox.layout.fixed.horizontal()
local memwidget = blingbling.line_graph()
memwidget:set_width(30)
vicious.register(memwidget, vicious.widgets.mem, "$1", 13)
local memwidgetlabel = wibox.widget.textbox("RAM")
memwidgetbox:add(memwidgetlabel)
memwidgetbox:add(memwidget)

-- Swap
local swapwidgetbox = wibox.layout.fixed.horizontal()
local swapwidget = blingbling.line_graph()
swapwidget:set_width(30)
--swapwidget:set_graph_background_color("#494B4F")
--swapwidget:set_graph_color(beautiful.border_focus)
vicious.register(swapwidget, vicious.widgets.mem, "$5", 13)
local swapwidgetlabel = wibox.widget.textbox("SWP")
swapwidgetbox:add(swapwidgetlabel)
swapwidgetbox:add(swapwidget)


-- Volume
local volumemasterwidget = blingbling.volume({height = 18, width = 40, bar =true, show_text = true, label ="$percent%", pulseaudio = true})
volumemasterwidget:update_master()
volumemasterwidget:set_master_control()

-- Keyboard map indicator and switcher
local keyboardlayoutwidget = wibox.widget.textbox("?XKB?")

-- Net
local netwidget = blingbling.net({interface = "wlp5s0", show_text = true})
netwidget:set_ippopup()

-- Clock
local textclockwidget = awful.widget.textclock("%H:%M")
-- Calendar upon mouse hovering over clock
lain.widgets.calendar:attach(textclockwidget, {position = "bottom_right"})

-- Separator
local separatorwidget = wibox.widget.textbox(" ")


-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                )

--[[
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c.first_tag)
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function(c)
                                              c:kill()
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))
]]--



function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

-- Application Launchers
function make_launcher(name, cmd)
    icon_path = file_exists(beautiful.appicons[name]) and beautiful.appicons[name] or beautiful.appicons["default"]
    return awful.widget.launcher({name = name, image = icon_path, command = cmd and cmd or name})
end
applicationlauncherwidgets =  {
    make_launcher("terminal", "urxvt"),
    make_launcher("pcmanfm"),
    make_launcher("gvim"),
    make_launcher("chromium"),
    make_launcher("midori"),
    make_launcher("mpv"),
    make_launcher("gcolor2"),
    make_launcher("virt-manager"),
    make_launcher("remmina"),
    make_launcher("gimp"),
    make_launcher("rawtherapee"),
    make_launcher("darktable"),
    make_launcher("blender"),
    make_launcher("rhythmbox"),
    make_launcher("libreoffice-writer", "libreoffice --writer"),
    make_launcher("libreoffice-calc", "libreoffice --calc"),
    make_launcher("sketchup", "sh -c ~/sketchup.sh"),
}


for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    --mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "bottom", screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])
    left_layout:add(separatorwidget)
    for k,v in pairs(applicationlauncherwidgets) do left_layout:add(v) end

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    right_layout:add(cpuwidgetbox)
    right_layout:add(separatorwidget)
    right_layout:add(memwidgetbox)
    right_layout:add(separatorwidget)
    right_layout:add(swapwidgetbox)
    right_layout:add(separatorwidget)
    right_layout:add(netwidget)
    right_layout:add(separatorwidget)
    right_layout:add(volumemasterwidget)
    right_layout:add(separatorwidget)
    right_layout:add(keyboardlayoutwidget)
    right_layout:add(separatorwidget)
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(separatorwidget)
    right_layout:add(pkgwidgetbox)
    right_layout:add(separatorwidget)
    right_layout:add(textclockwidget)
    right_layout:add(separatorwidget)
    right_layout:add(mylayoutbox[s])

    -- Now bring it all together
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    --layout:set_middle(textclockwidget)
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),
    awful.key({ modkey,           }, "j", function () awful.client.focus.byidx( 1) end),
    awful.key({ modkey,           }, "k", function () awful.client.focus.byidx(-1) end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey,           }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),
    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end),
    awful.key({ modkey, "Control" }, "n",
              function ()
                  c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end),

    -- Prompt
    awful.key({ modkey },            "d",     function() awful.util.spawn_with_shell("j4-dmenu-desktop") end),
    --awful.key({ "Mod1" },             "F2",     function () mypromptbox[awful.screen.focused()]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[awful.screen.focused()].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end),
    -- Save screenshot
    awful.key({}, "Print", function() awful.spawn(screenshot_cmd) end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end)
)


-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end


function print_client_tag(c)
    local tags = c:tags()
    local tag1 = tags[1]
    local num_clients = #tag1:clients()
    naughty.notify( { text = "client " .. c.class .. " on the same tag with clients: " .. tostring(num_clients) })
end


clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 2, function(c) c:kill() end),
    --awful.button({ modkey }, 2, print_client_tag),
    awful.button({ modkey }, 3, awful.mouse.client.resize)
    )

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     size_hints_honor = false
                 }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
          "Arandr",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Wpa_gui",
          "pinentry",
          "veromix",
          "xtightvncviewer",
          "Qmmp",
          "Pwsafe",
          "Steam"
       },

        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    { rule = { class = "Gvim" },            properties = { tag = find_tag_by_name("code") } },
    { rule = { class = "chromium" },        properties = { tag = find_tag_by_name("internet") } },
    { rule = { class = "Virt-manager" },    properties = { tag = find_tag_by_name("vm") } },
    { rule = { class = "Steam" },           properties = { tag = find_tag_by_name("game") } },
--  { rule = { class = "Uzbl-tabbed" },     properties = { tag = find_tag_by_name("video") } },
    { rule = { class = "Gimp" },            properties = { tag = find_tag_by_name("photo") } },
    { rule = { class = "XnViewMP" },        properties = { tag = find_tag_by_name("photo") } },
--  { rule = { class = "mpv" },             properties = { tag = find_tag_by_name("video") } },
    { rule = { instance = "SketchUp.exe",
               class = "Wine" },            properties = { tag = find_tag_by_name("cad") } },
}

-- Decoration/border will be skipped from the floating windows of these classes:
no_decoration_classes ={
    ["Steam"] = true
}
-- }}}

-- {{{ Signals
--[[
function add_title_bars(c)
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
        )

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c):set_widget(layout)
    end
end


function set_contains(set, value)
    return set[value] == true
end

function update_floating_client(c)
    --naughty.notify({text = tostring(c.class) .. tostring(set_contains( no_decoration_classes,c.class))})
    is_floating = awful.client.floating.get(c)
    if is_floating and not set_contains(no_decoration_classes, c.class) then
        awful.titlebar.show(c)
        --c.border_width = beautiful.border_width
    else
        awful.titlebar.hide(c)
        --c.border_width = 0
    end
end
]]--

client.connect_signal("manage", function (c)
    if not awesome.startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they do not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    elseif not c.size_hints.user_position and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end

    --add_title_bars(c)
    --update_floating_client(c)
    --awful.titlebar.hide(c)
end)


-- Enable sloppy focus
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)


client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Add title bars when window becomes floating / remove when tiled again
-- client.connect_signal("property::floating", update_floating_client)



--client.connect_signal("property::maximized_vertical", function(c) naughty.notify({text = "maximized vertical " .. c.class }) end)
--client.connect_signal("property::maximized_horizontal", function(c) naughty.notify({text = "maximized horizontal " .. c.class }) end)

-- Remove border from maximized windows
function update_border_if_single(c)
    local tags = c:tags()
    local tag1 = tags[1]
    if tag1 then
        local num_clients = #tag1:clients()
        if num_clients < 2 and not awful.client.floating.get(c)  then
            c.border_width = 0
            --naughty.notify( { text = "removed border from " .. c.class })
        else
            c.border_width = beautiful.border_width
            --naughty.notify( { text = "restored border of " .. c.class })
        end
    end
end

client.connect_signal("manage", update_border_if_single)
client.connect_signal("focus", update_border_if_single)
client.connect_signal("unfocus", update_border_if_single)
-- }}}

function run_once(cmd)
    findme = cmd
    firstspace = cmd:find(" ")
    if firstspace then
        findme = cmd:sub(0, firstspace-1)
    end
    awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || exec " .. cmd .. "")
end


-- {{{ Startup programs
run_once("compton --config /dev/null --backend glx --paint-on-overlay --glx-no-stencil --vsync opengl-swc --unredir-if-possible --no-fading-openclose")
run_once("setxkbmap -layout \"us,ru\" -option \"grp:alt_shift_toggle\"")
--run_once("xrandr --output eDP1 --primary")
run_once("xset dpms 600")
run_once("xrdb -m ~/.Xresources")
run_once("xset +fp /usr/share/fonts/local")
run_once("xiccd")
run_once("nm-applet")
run_once("blueberry-tray")
run_once("pasystray")
run_once("transmission-qt -m")
run_once("chromium")
--run_once("owncloud")
--run_once("virt-manager")
--run_once("uzbl-tabbed")
--run_once("gvim")
--run_once("steam")
-- }}}



naughty.notify( { text = "Awesome " .. awesome.version .. awesome.release })


-- vim:ts=4:sts=4:sw=4:expandtab
