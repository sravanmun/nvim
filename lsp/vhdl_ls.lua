-- vhdl_ls binary currently lives in the mason install dir.
-- After dropping mason you can either:
--   * `cargo install vhdl_ls` and switch cmd to { "vhdl_ls" }
--   * download a release from https://github.com/VHDL-LS/rust_hdl
return {
    cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/vhdl_ls") },
    filetypes = { "vhdl" },
    root_markers = { "vhdl_ls.toml", ".git" },
}
