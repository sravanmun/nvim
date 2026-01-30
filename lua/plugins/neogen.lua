return {
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  config = function()
    require('neogen').setup({
      enabled = true,
      languages = {
        python = {
          template = {
            annotation_convention = "numpydoc"
          }
        }
      }
    })

    -- Keybinding to generate documentation
    vim.keymap.set("n", "<leader>nf", ":lua require('neogen').generate()<CR>", { desc = "Generate documentation" })
  end,
}
