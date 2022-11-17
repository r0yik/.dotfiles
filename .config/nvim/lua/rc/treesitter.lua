local configs = require "nvim-treesitter.configs"

configs.setup {
    ensure_installed = "all", -- one of "all" or a list of languages
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
    ignore_install = { "" }, -- List of parsers to ignore installing
    matchup = {
        enable = true, -- mandatory, false will disable the whole extension
        disable_virtual_text = true,
        -- disable = { "html" }, -- optional, list of language that will be disabled
        -- include_match_words = false
    },
    highlight = {
        -- use_languagetree = true,
        enable = true, -- false will disable the whole extension
        -- disable = { "css", "html" }, -- list of language that will be disabled
        -- disable = { "css", "markdown" }, -- list of language that will be disabled
        -- disable = { "markdown" }, -- list of language that will be disabled
        -- additional_vim_regex_highlighting = true,
    },
    autopairs = {
        enable = true,
    },
    indent = {
        enable = true
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    rainbow = {
        enable = true,
        extended_mode = false,
        colors = {
            -- "#68a0b0",
            -- "#946EaD",
            -- "#c7aA6D",
            "Gold",
            "Orchid",
            "DodgerBlue",
            -- "Cornsilk",
            -- "Salmon",
            -- "LawnGreen",
        },
        disable = { "html" },
    },
    playground = {
        enable = true,
    },
}
