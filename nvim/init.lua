-- plugins lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

vim.env.PATH = vim.env.PATH .. ':/home/brace/go/bin'

-- Installing plugins
require("lazy").setup({
    { "ellisonleao/gruvbox.nvim", priority = 1000 },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "neovim/nvim-lspconfig" },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope.nvim", tag = "0.1.4" },
    { "nvim-tree/nvim-tree.lua" },
    { "nvim-lualine/lualine.nvim" },
    { "lewis6991/gitsigns.nvim" },
    {"nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" }},
    { "elkowar/yuck.vim", ft = "yuck" }
})


-- Enable Gruvbox
vim.o.background = "dark"
require("gruvbox").setup({})
vim.cmd.colorscheme("gruvbox")

-- Treesitter (highlight C++, Java, Python)
require("nvim-treesitter.configs").setup {
    ensure_installed = {"rust", "go", "cpp", "java", "python", "lua", "yuck", "scss", "html", "css"},
    highlight = { enable = true }
}

-- LSP (autocorrection)
local lspconfig = require("lspconfig")
local cmp = require("cmp")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.pyright.setup { capabilities = capabilities } -- Python
lspconfig.clangd.setup { capabilities = capabilities } -- C++
lspconfig.jdtls.setup { capabilities = capabilities } -- Java
lspconfig.cssls.setup {
  capabilities = capabilities,
  filetypes = { "css", "scss", "less" }
}
-- Rust
lspconfig.rust_analyzer.setup {
    capabilities = capabilities,
    settings = {
        ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            checkOnSave = {
                command = "clippy"
            },
        },
    }
}


-- Go (Golang)
lspconfig.gopls.setup {
    capabilities = capabilities,
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
                shadow = true,
            },
            staticcheck = true,
        },
    },
}
-- nvim-cmp 
cmp.setup({
    mapping = {
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
    },
    sources = { 
        { name = "nvim_lsp" },
        { name = "buffer" },
    }
})

-- nvim-tree (file manager)
require("nvim-tree").setup()

-- Gitsigns (Git integration)
require("gitsigns").setup()



local null_ls = require("null-ls")

-- null-ls (linters and formatters)
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.goimports,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.rustfmt
    }
})

-- lualine (status line)
require("lualine").setup {
    options = { theme = "gruvbox" }
}

-- Ease of use
vim.o.number = true        -- show line numbers
vim.o.relativenumber = true -- relative line numbering
vim.o.cursorline = true    -- highlight cursor line
vim.o.tabstop = 4          -- Tab size - 4 spaces
vim.o.shiftwidth = 4       -- Shift width - 4 spaces
vim.o.expandtab = true     -- change tabs to spaces
vim.o.smartindent = true   -- Auto indent

-- Hot keys
vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-p>", ":Telescope find_files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-f>", ":Telescope live_grep<CR>", { noremap = true, silent = true })

if vim.fn.executable("wl-copy") == 1 and vim.fn.executable("wl-paste") == 1 then
    vim.g.clipboard = {
        name = "wl-clipboard",
        copy = {
            ["+"] = "wl-copy",
            ["*"] = "wl-copy",
        },
        paste = {
            ["+"] = "wl-paste",
            ["*"] = "wl-paste",
        },
        cache_enabled = 0,
    }
end

