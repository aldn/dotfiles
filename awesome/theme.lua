---------------------------
-- Default awesome theme --
---------------------------

theme = {}

-- {{{ Styles
theme.font       = "Cantarell 10"
theme.wallpaper  = "~/owncloud/wp/nature/02.jpg"

-- {{{ Colors

local color_select = "#0066FF"

theme.bg_normal  = "#2A2A2A"
theme.fg_normal  = "#999999"

theme.bg_focus   = color_select
theme.fg_focus   = "#EEEEEE"

theme.bg_urgent  = "#FF0000"
theme.fg_urgent  = theme.fg_normal

theme.bg_systray = theme.bg_normal
-- }}}


--{{{ Blingbling
theme.blingbling = {}
theme.blingbling.graph_color = "#FF00FF"
theme.blingbling.graph_line_color = "#FFFF00"

--}}}


-- {{{ Borders
theme.useless_gap   = 0
theme.border_width  = 3
theme.border_normal = theme.bg_normal
theme.border_focus  = color_select
theme.border_marked = "#FF6600"
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = "#3F3F3F"
theme.titlebar_bg_normal = "#3F3F3F"
-- }}}

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
--theme.taglist_bg_focus = "#CC9393"
-- }}}

-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.fg_widget        = "#FF00FF"
--theme.fg_center_widget = "#88A175"
--theme.fg_end_widget    = "#FF5656"
--theme.bg_widget        = "#494B4F"
--theme.border_widget    = "#3F3F3F"
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#CC9393"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = 15
theme.menu_width  = 100
-- }}}

-- {{{ Icons
-- {{{ Taglist
theme.taglist_squares_sel   = "/usr/share/awesome/themes/zenburn/taglist/squarefz.png"
theme.taglist_squares_unsel = "/usr/share/awesome/themes/zenburn/taglist/squarez.png"
--theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc
theme.awesome_icon           = "/usr/share/awesome/themes/zenburn/awesome-icon.png"
theme.menu_submenu_icon      = "/usr/share/awesome/themes/default/submenu.png"
-- }}}


-- {{{ Layout
theme.layout_tile       = "/usr/share/awesome/themes/zenburn/layouts/tile.png"
theme.layout_tileleft   = "/usr/share/awesome/themes/zenburn/layouts/tileleft.png"
theme.layout_tilebottom = "/usr/share/awesome/themes/zenburn/layouts/tilebottom.png"
theme.layout_tiletop    = "/usr/share/awesome/themes/zenburn/layouts/tiletop.png"
theme.layout_fairv      = "/usr/share/awesome/themes/zenburn/layouts/fairv.png"
theme.layout_fairh      = "/usr/share/awesome/themes/zenburn/layouts/fairh.png"
theme.layout_spiral     = "/usr/share/awesome/themes/zenburn/layouts/spiral.png"
theme.layout_dwindle    = "/usr/share/awesome/themes/zenburn/layouts/dwindle.png"
theme.layout_max        = "/usr/share/awesome/themes/zenburn/layouts/max.png"
theme.layout_fullscreen = "/usr/share/awesome/themes/zenburn/layouts/fullscreen.png"
theme.layout_magnifier  = "/usr/share/awesome/themes/zenburn/layouts/magnifier.png"
theme.layout_floating   = "/usr/share/awesome/themes/zenburn/layouts/floating.png"
theme.layout_cornernw   = "/usr/share/awesome/themes/zenburn/layouts/cornernw.png"
theme.layout_cornerne   = "/usr/share/awesome/themes/zenburn/layouts/cornerne.png"
theme.layout_cornersw   = "/usr/share/awesome/themes/zenburn/layouts/cornersw.png"
theme.layout_cornerse   = "/usr/share/awesome/themes/zenburn/layouts/cornerse.png"
-- }}}

-- {{{ Titlebar
theme.titlebar_close_button_focus  = "/usr/share/awesome/themes/zenburn/titlebar/close_focus.png"
theme.titlebar_close_button_normal = "/usr/share/awesome/themes/zenburn/titlebar/close_normal.png"

theme.titlebar_ontop_button_focus_active  = "/usr/share/awesome/themes/zenburn/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = "/usr/share/awesome/themes/zenburn/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = "/usr/share/awesome/themes/zenburn/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = "/usr/share/awesome/themes/zenburn/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active  = "/usr/share/awesome/themes/zenburn/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = "/usr/share/awesome/themes/zenburn/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = "/usr/share/awesome/themes/zenburn/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = "/usr/share/awesome/themes/zenburn/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active  = "/usr/share/awesome/themes/zenburn/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = "/usr/share/awesome/themes/zenburn/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = "/usr/share/awesome/themes/zenburn/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = "/usr/share/awesome/themes/zenburn/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active  = "/usr/share/awesome/themes/zenburn/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = "/usr/share/awesome/themes/zenburn/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = "/usr/share/awesome/themes/zenburn/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = "/usr/share/awesome/themes/zenburn/titlebar/maximized_normal_inactive.png"
-- }}}
-- }}}

theme.appicons = {
    ["default"]             = "/home/aldn/.config/awesome/theme/appicons/app-generic.png",
    ["terminal"]            = "/home/aldn/.config/awesome/theme/appicons/terminal.png",
    ["gvim"]                = "/usr/share/pixmaps/gvim.png",
    ["gcolor2"]             = "/home/aldn/.config/awesome/theme/appicons/gcolor2.png",
    ["pcmanfm"]             = "/usr/share/icons/Adwaita/32x32/places/folder.png",
    ["chromium"]            = "/usr/share/icons/hicolor/32x32/apps/chromium.png",
    ["gimp"]                = "/usr/share/icons/hicolor/32x32/apps/gimp.png",
    ["midori"]              = "/usr/share/icons/hicolor/32x32/apps/midori.png",
    ["mpv"]                 = "/usr/share/icons/hicolor/32x32/apps/mpv.png",
    ["virt-manager"]        = "/usr/share/icons/hicolor/32x32/apps/virt-manager.png",
    ["pwsafe"]              = "/usr/share/icons/hicolor/48x48/apps/pwsafe.png",
    ["remmina"]             = "/usr/share/icons/hicolor/32x32/apps/remmina.png",
    ["rawtherapee"]         = "/usr/share/icons/hicolor/32x32/apps/rawtherapee.png",
    ["darktable"]           = "/usr/share/icons/hicolor/32x32/apps/darktable.png",
    ["blender"]             = "/usr/share/icons/hicolor/32x32/apps/blender.png",
    ["rhythmbox"]           = "/usr/share/icons/hicolor/32x32/apps/rhythmbox.png",
    ["libreoffice-writer"]  = "/usr/share/icons/hicolor/32x32/apps/libreoffice-writer.png",
    ["libreoffice-calc"]    = "/usr/share/icons/hicolor/32x32/apps/libreoffice-calc.png",
    ["sketchup"]            = "/home/aldn/.local/share/icons/hicolor/32x32/apps/673B_SketchUp.0.png",
}


return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
