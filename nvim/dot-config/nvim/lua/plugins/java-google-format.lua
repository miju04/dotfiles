return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        java = { "google-java-format" },
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = vim.g.nixos and {} or { "google-java-format" } },
  },
}
