-- Neovim configuration file

-- Show line numbers
vim.opt.number = true

-- Save cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line
    if line("'\"") > 1 and line("'\"") <= line("$") then
      vim.cmd('normal! g`"')
    end
  end,
})

-- ==============================
-- File Browser
-- ==============================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "nvim-tree/nvim-tree.lua",
  "nvim-tree/nvim-web-devicons", -- optional but recommended
})

require("nvim-tree").setup()

-- Toggle file browser
vim.keymap.set("n", "<A-1>", ":NvimTreeToggle<CR>")

-- Focus current file
vim.keymap.set("n", "<A-c>", ":NvimTreeFindFile<CR>")

-- Open File Browser on NeoVim start
require("nvim-tree").setup()
require("nvim-tree.api").tree.open()

-- Automatically focus right window, because we opened File Browser on the left
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.cmd("wincmd l")
  end,
})
-- ==============================

vim.keymap.set("n", "<A-a>", "<C-w>h")  -- focus left window
vim.keymap.set("n", "<A-w>", "<C-w>k")  -- focus upper window
vim.keymap.set("n", "<A-s>", "<C-w>j")  -- focus lower window
vim.keymap.set("n", "<A-d>", "<C-w>l")  -- focus right window

