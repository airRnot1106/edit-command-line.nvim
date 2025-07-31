local M = {}

M.defaults = {
    window = {
        width_ratio = 0.8,
        height_ratio = 0.6,
        border = "rounded",
        title = "Edit Command Line",
        title_pos = "center",
    },
    buffer = {
        filetype = "sh",
        buftype = "nofile",
        swapfile = false,
    },
    processing = {
        delay_ms = 50,
    },
}

M.options = {}

function M.setup(opts)
    M.options = vim.tbl_deep_extend("force", M.defaults, opts or {})
end

function M.get()
    if vim.tbl_isempty(M.options) then
        M.setup()
    end
    return M.options
end

return M
