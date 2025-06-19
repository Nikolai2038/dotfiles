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
-- Plugins Setup
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
  -- File Browser
  "nvim-tree/nvim-tree.lua",
  "nvim-tree/nvim-web-devicons", -- optional but recommended
  -- Theme
  "Mofiqul/vscode.nvim",
})
-- ==============================

-- ==============================
-- File Browser
-- ==============================
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

-- Close File Browser when closing last window
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if #vim.api.nvim_list_wins() == 1 then
      local bufname = vim.api.nvim_buf_get_name(0)
      if bufname:match("NvimTree_") then
        vim.cmd("quit")
      end
    end
  end,
})
-- ==============================

-- Theme
vim.cmd.colorscheme("vscode")

vim.keymap.set("n", "<A-a>", "<C-w>h")  -- focus left window
vim.keymap.set("n", "<A-w>", "<C-w>k")  -- focus upper window
vim.keymap.set("n", "<A-s>", "<C-w>j")  -- focus lower window
vim.keymap.set("n", "<A-d>", "<C-w>l")  -- focus right window

-- ==============================
-- Terminal
-- ==============================
-- Variables to keep track of terminal window and buffer
local term_win = nil
local term_buf = nil
local prev_win = nil

-- Autocmd to change Alt+3 in terminal mode
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.keymap.set("t", "<A-3>", function()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
      -- Replace function on Alt+3
      vim.defer_fn(function()
        vim.api.nvim_win_hide(term_win)
        term_win = nil

	-- Focus on the previous window
        if prev_win and vim.api.nvim_win_is_valid(prev_win) then
          vim.api.nvim_set_current_win(prev_win)
        end
      end, 10)
    end, { buffer = true, noremap = true, silent = true })
  end,
})

-- Keymap to toggle the Terminal on Alt+3 in normal mode
-- TODO: Exit NeoVim if only the Terminal and/or File Browser is opened
vim.keymap.set("n", "<A-3>", function()
  prev_win = vim.api.nvim_get_current_win()
  
  if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
    -- Terminal buffer exists, open it in a split
    vim.cmd("botright split")
    vim.cmd("resize 16")
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(win, term_buf)
    term_win = win
  else
    -- No terminal buffer, create new terminal in split
    vim.cmd("botright split")
    vim.cmd("resize 16")
    vim.cmd("term")
    term_buf = vim.api.nvim_get_current_buf()
    term_win = vim.api.nvim_get_current_win()
  end
  -- Focus the terminal window and enter insert mode
  vim.api.nvim_set_current_win(term_win)
  vim.cmd("startinsert")
end, { noremap = true, silent = true })
-- ==============================

