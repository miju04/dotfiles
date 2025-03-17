return {
  {
    "mfussenegger/nvim-jdtls",
    opts = {
      root_dir = function(fname)
        return require("lspconfig").util.root_pattern(
          "pom.xml",
          "gradle.build",
          "build.gradle",
          ".git",
          "mvnw",
          "gradlew"
        )(fname) or vim.fn.getcwd()
      end,
    },
  },
}
