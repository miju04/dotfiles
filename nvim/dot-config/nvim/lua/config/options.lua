-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.swapfile = false
vim.opt.spelllang = { "en_us", "de" }
vim.opt.winborder = "rounded"

vim.o.list = true
vim.o.listchars = "tab:» ,lead:•,trail:•"

vim.o.clipboard = ""

vim.treesitter.language.register("yaml", "yml")

-- On NixOS, tools come from Nix; elsewhere Mason installs them.
vim.g.nixos = vim.uv.fs_stat("/etc/NIXOS") ~= nil

if vim.fn.has("wsl") == 1 and vim.fn.executable("win32yank.exe") == 1 then
  vim.g.clipboard = {
    name = "win32yank-wsl",
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
      ["+"] = "win32yank.exe -o --lf",
      ["*"] = "win32yank.exe -o --lf",
    },
    cache_enabled = 0,
  }
end
