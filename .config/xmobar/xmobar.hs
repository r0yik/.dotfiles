Config { 

   -- appearance
     font = "xft:IBM Plex Mono:size=10,Hack Nerd Font:size=10"
   , bgColor = "#0f0f0f"
   , fgColor = "#dddddd"
   , position = Top

   -- layout
   , sepChar =  "%"   -- delineator between plugin names and straight text
   , alignSep = "}{"  -- separator between left-right alignment
   , template = " %StdinReader% }{ %multicpu%    %memory%    %diskIcon% %disku%    %updateIcon% %updates%    %default:Master%    %battery%    %dateIcon% %date%  %trayerpad%"

   -- general behavior
   , lowerOnStart =     True    -- send to bottom of window stack on start
   , hideOnStart =      False   -- start with window unmapped (hidden)
   , allDesktops =      True    -- show on all desktops
   , overrideRedirect = True    -- set the Override Redirect flag (Xlib)
   , pickBroadest =     False   -- choose widest display (multi-monitor)
   , persistent =       True    -- enable/disable hiding (True = disabled)
   , iconRoot =         ".xmonad/xpm/"  -- default: "."

   -- plugins
   --   Numbers can be automatically colored according to their value. xmobar
   --   decides color based on a three-tier/two-cutoff system, controlled by
   --   command options:
   --     --Low sets the low cutoff
   --     --High sets the high cutoff
   --
   --     --low sets the color below --Low cutoff
   --     --normal sets the color between --Low and --High cutoffs
   --     --High sets the color above --High cutoff
   --
   --   The --template option controls how the plugin is displayed. Text
   --   color can be set by enclosing in <fc></fc> tags. For more details
   --   see http://projects.haskell.org/xmobar/#system-monitor-plugins.
   , commands = [ 
        -- cpu activity monitor
        Run MultiCpu         [ "--template" , " <total0>%"
                             , "--Low"      , "50"         -- units: %
                             , "--High"     , "85"         -- units: %
                             , "--low"      , "#dddddd"
                             , "--normal"   , "darkorange"
                             , "--high"     , "red"
                             ] 20

        -- cpu core temperature monitor
        , Run CoreTemp       [ "--template" , " <core0>|<core1>°C"
                             , "--Low"      , "70"        -- units: °C
                             , "--High"     , "80"        -- units: °C
                             , "--low"      , "#dddddd"
                             , "--normal"   , "darkorange"
                             , "--high"     , "red"
                             ] 50
                          
        -- memory usage monitor
        , Run Memory         [ "--template" , " <usedratio>%"
                             , "--Low"      , "20"        -- units: %
                             , "--High"     , "90"        -- units: %
                             , "--low"      , "#dddddd"
                             , "--normal"   , "darkorange"
                             , "--high"     , "red"
                             ] 20

        -- volume
        , Run Volume         "default" "Master"
                             [ "--template" , "墳 <volume>%"
                             ] 10

        -- battery monitor
        , Run Battery        [ "--template" , " <acstatus>"
                             , "--Low"      , "10"        -- units: %
                             , "--High"     , "80"        -- units: %
                             , "--low"      , "red"
                             , "--normal"   , "darkorange"
                             , "--high"     , "#dddddd"

                             , "--" -- battery specific options
                                       -- discharging status
                                       , "-o"	, "<left>%(<timeleft>)"
                                       -- AC "on" status
                                       , "-O"	, "<left>% <fc=#dddddd></fc>"
                                       -- charged status
                                       , "-i"	, "<fc=#dddddd>FULL</fc>"
                             ] 50

        -- disk usage
        , Run Com            "echo" [""] "diskIcon" 0
        , Run DiskU          [("/", "<used>/<size>")] [] 600

        -- time and date indicator 
        , Run Com            "echo" [""] "dateIcon" 0
        , Run Date           "<fc=#dddddd>%F (%a) %T</fc>" "date" 10

        -- checkupdates
        , Run Com            "echo" [""] "updateIcon" 0
        , Run Com            "sh" ["-c", "checkupdates | wc -l"] "updates" 3600

        -- workspace, current layout, title
        , Run StdinReader

        -- Script that dynamically adjusts xmobar padding depending on number of trayer icons.
        , Run Com ".config/xmobar/trayer-padding-icon.sh" [] "trayerpad" 20

    ]
}

