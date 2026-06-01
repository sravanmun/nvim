return {
    cmd = { "texlab" },
    filetypes = { "tex", "plaintex", "bib" },
    root_markers = {
        ".latexmkrc", ".texlabroot", "texlabroot",
        "Tectonic.toml", ".git",
    },
    settings = {
        texlab = {
            build = {
                executable = "latexmk",
                args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
                onSave = false,
                forwardSearchAfter = false,
            },
            forwardSearch = {
                executable = "open",
                args = { "-a", "Skim", "%p" },
            },
            chktex = {
                onOpenAndSave = true,
                onEdit = false,
            },
            diagnosticsDelay = 300,
        },
    },
}
