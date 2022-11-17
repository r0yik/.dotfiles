local wk = require("which-key")
wk.setup {
    plugins = {
        marks = false,
        registers = false,
        spelling = { enabled = false, suggestions = 20 },
        presets = {
            operators = false,
            motions = false,
            text_objects = false,
            windows = false,
            nav = false,
            z = false,
            g = false
        }
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
    },
    window = {
        border = "shadow", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 8, -- spacing between columns
        align = "left", -- align columns left, center or right
    }
}

local Terminal = require('toggleterm.terminal').Terminal
local toggle_float = function()
    local float = Terminal:new({ direction = "float" })
    return float:toggle()
end

local mappings = {
    q = { ":q<cr>", "Quit" },
    Q = { ":wq<cr>", "Save & Quit" },
    D = { ":q!<cr>", "Discard & Quit" },
    w = { ":w<cr>", "Save" },
    x = { ":bdelete<cr>", "Close" },
    c = { ":nohlsearch<cr>", "Clear hl" },
    e = { ":NvimTreeToggle<cr>", "NvimTree Toggle" },
    E = { ":e ~/.config/nvim/init.lua<cr>", "Edit NeoVim Config" },
    f = { ":Telescope find_files<cr>", "Telescope Find Files" },
    r = { ":Telescope live_grep<cr>", "Telescope Live Grep" },
    b = { ":Telescope file_browser<cr>", "Telescope File Browser"},
    t = {
        name = "Terminal",
        t = { ":ToggleTerm<cr>", "Split Below" },
        f = { toggle_float, "Floating Terminal" },
    },
    l = {
        name = "LSP",
        i = { ":LspInfo<cr>", "Connected Language Servers" },
        k = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help" },
        w = { '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', "Add Workspace Folder" },
        W = { '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', "Remove Workspace Folder" },
        l = {
            '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>',
            "List Workspace Folders"
        },
        t = { '<cmd>lua vim.lsp.buf.type_definition()<cr>', "Type Definition" },
        d = { '<cmd>lua vim.lsp.buf.definition()<cr>', "Go To Definition" },
        D = { '<cmd>lua vim.lsp.buf.declaration()<cr>', "Go To Declaration" },
        r = { '<cmd>lua vim.lsp.buf.references()<cr>', "References" },
        f = { '<cmd>lua vim.lsp.buf.format { async = true }<cr>', "Format" }
    },
    p = {
        name = "Packer",
        r = { ":PackerClean<cr>", "Remove Unused Plugins" },
        c = { ":PackerCompile profile=true<cr>", "Recompile Plugins" },
        i = { ":PackerInstall<cr>", "Install Plugins" },
        p = { ":PackerProfile<cr>", "Packer Profile" },
        s = { ":PackerSync<cr>", "Sync Plugins" },
        S = { ":PackerStatus<cr>", "Packer Status" },
        u = { ":PackerUpdate<cr>", "Update Plugins" }
    },
}

local opts = { prefix = '<leader>' }
wk.register(mappings, opts)
