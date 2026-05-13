return function(add)
  add({ "Kicamon/markdown-table-mode.nvim", ft = "markdown", opts = {} })

  add({ "habamax/vim-asciidoctor", ft = { "asciidoc", "adoc" } })

  add({
    "nvim-orgmode/orgmode",
    ft = "org",
    config = function()
      require("orgmode").setup({ mappings = { disable_all = true } })
    end,
  })

  add({
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    module = "render-markdown",
    opts = {
      enabled = false,
      code = { sign = false, width = "block", right_pad = 1 },
      heading = { sign = false, icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " } },
    },
    keys = {
      { "<leader>um", function() require("render-markdown").toggle() end, desc = "Render Markdown" },
    },
  })
end
