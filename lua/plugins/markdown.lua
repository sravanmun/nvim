return {
	-- markdown table
	{
		"Kicamon/markdown-table-mode.nvim",
		config = function()
			require("markdown-table-mode").setup()
		end,
	},

	-- asciidoc ASCIIDOC
	{
		"habamax/vim-asciidoctor",
		ft = { "asciidoc", "adoc" },
	},

	-- org
    {
      "nvim-orgmode/orgmode",
      ft = { "org" },
      config = function()
        require("orgmode").setup({
          mappings = { disable_all = true },
        })
      end,
    }
}
