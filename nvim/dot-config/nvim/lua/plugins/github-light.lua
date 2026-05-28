-- Light theme for screenshots / Word document inserts.
return {
  {
    "projekt0n/github-nvim-theme",
    priority = 1000,
    opts = {
      options = {
        transparent = false,
        hide_end_of_buffer = true,
        hide_nc_statusline = true,
        styles = {
          comments = "italic",
          keywords = "bold",
        },
      },
    },
    config = function(_, opts)
      require("github-theme").setup(opts)
    end,
  },
}
