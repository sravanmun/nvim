return {
    "rcarriga/nvim-notify",
    opts = {
        stages = "fade",
        timeout = 3000,
    },
    keys = {
        { 
            "<leader>nn", 
            function() 
                local history = require("notify").history()
                local entries = {}
                for _, notif in ipairs(history) do
                    table.insert(entries, notif.message[1])
                end
                require("fzf-lua").fzf_exec(entries, {
                    prompt = "Notifications> ",
                })
            end, 
            desc = "Notification History" 
        },
    },
    config = function(_, opts)
        local notify = require("notify")
        notify.setup(opts)
        vim.notify = notify
    end,
}

