local config = require "edit-command-line.config"

local M = {}

function M.calculate_window_size()
    local opts = config.get()
    local width = math.floor(vim.o.columns * opts.window.width_ratio)
    local height = math.floor(vim.o.lines * opts.window.height_ratio)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    return {
        width = width,
        height = height,
        row = row,
        col = col,
    }
end

function M.create_buffer()
    local opts = config.get()
    local buf = vim.api.nvim_create_buf(false, true)

    vim.api.nvim_buf_set_option(buf, "filetype", opts.buffer.filetype)
    vim.api.nvim_buf_set_option(buf, "buftype", opts.buffer.buftype)
    vim.api.nvim_buf_set_option(buf, "swapfile", opts.buffer.swapfile)

    return buf
end

function M.create_floating_window(buf)
    local opts = config.get()
    local size = M.calculate_window_size()

    return vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = size.width,
        height = size.height,
        row = size.row,
        col = size.col,
        border = opts.window.border,
        title = opts.window.title,
        title_pos = opts.window.title_pos,
    })
end

function M.setup_keymaps(buf, on_cancel)
    local opts = config.get()

    vim.api.nvim_buf_set_keymap(buf, "n", opts.keymaps.cancel, "<cmd>q<CR>", {
        noremap = true,
        silent = true,
    })

    if on_cancel then
        vim.api.nvim_create_autocmd("BufLeave", {
            buffer = buf,
            once = true,
            callback = on_cancel,
        })
    end
end

function M.get_buffer_content(buf)
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    return table.concat(lines, "\n")
end

return M
