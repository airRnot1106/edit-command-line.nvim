local config = require "edit-command-line.config"
local terminal = require "edit-command-line.terminal"
local ui = require "edit-command-line.ui"
local events = require "edit-command-line.events"

local M = {}

function M.setup(opts)
    config.setup(opts)
end

function M.open()
    local term_info = terminal.get_current_terminal_info()
    local buf = ui.create_buffer()

    ui.create_floating_window(buf)
    events.setup_buf_leave_handler(buf, term_info.job_id)
    ui.setup_keymaps(buf)

    vim.cmd "startinsert"
end

return M
