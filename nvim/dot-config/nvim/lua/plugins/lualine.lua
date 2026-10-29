return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    table.insert(opts.sections.lualine_x, 1, {
      function()
        return vim.bo.fileformat == "dos" and "CRLF" or "CR"
      end,
      cond = function()
        return vim.bo.fileformat ~= "unix"
      end,
      color = "DiagnosticError",
    })
  end,
}
