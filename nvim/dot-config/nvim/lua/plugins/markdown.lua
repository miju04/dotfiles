return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rumdl = { mason = not vim.g.nixos },
        marksman = { mason = not vim.g.nixos },
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = vim.g.nixos and {} or { "jq", "yq" } },
  },
  {
    "mfussenegger/nvim-lint",
    opts = { linters_by_ft = { markdown = {} } },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        injected = {
          options = {
            lang_to_formatters = {
              go = { "gofumpt" },
              json = { "jq" },
              python = { "ruff_format" },
              yaml = { "yq" },
            },
          },
        },
      },
      formatters_by_ft = {
        markdown = { "markdown-toc", lsp_format = "first", name = "rumdl" },
      },
    },
  },
  { "iamcco/markdown-preview.nvim", enabled = false },
  {
    "selimacerbas/mdkite.nvim",
    dependencies = { "selimacerbas/kitehost.nvim" },
    cmd = "MdKite",
    keys = {
      { "<leader>cp", "<cmd>MdKite toggle<cr>", ft = "markdown", desc = "Markdown Preview" },
    },
    opts = {},
  },
}
