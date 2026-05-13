-- Colorschemes are eager but inert: they only register :colorscheme commands.
-- Listed individually so vim.pack tracks each one.
return function(add)
  for _, src in ipairs({
    "catppuccin/nvim",
    "Th3Whit3Wolf/space-nvim",
    "ellisonleao/gruvbox.nvim",
    "sainnhe/everforest",
    "maxmx03/solarized.nvim",
    "phha/zenburn.nvim",
    "NTBBloodbath/doom-one.nvim",
    "rebelot/kanagawa.nvim",
    "shaunsingh/nord.nvim",
    "deparr/tairiki.nvim",
    "Mofiqul/adwaita.nvim",
  }) do
    add({ src })
  end
end
