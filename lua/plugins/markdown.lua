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
    },

    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { 
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons" 
        },
        ft = "markdown",
        opts = {
            enabled = false,  -- Disabled by default
            -- Your custom options here
            file_types = { "markdown" },
            code = {
                sign = false,
                width = "block",
                right_pad = 1,
            },
            heading = {
                sign = false,
                icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
            },
        },
        keys = {
            {
                "<leader>tm",
                function()
                    require("render-markdown").toggle()
                end,
                desc = "Toggle Render Markdown",
            },
        },
    }

}
