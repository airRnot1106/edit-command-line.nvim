vim.api.nvim_create_user_command("EditCommandLine", function()
    require("edit-command-line").open()
end, { desc = "Open EditCommandLine window" })
