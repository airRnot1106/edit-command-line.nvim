local config = require "edit-command-line.config"
local ui = require "edit-command-line.ui"
local terminal = require "edit-command-line.terminal"

local M = {}

function M.setup_buf_leave_handler(buf, term_job_id)
    local opts = config.get()

    vim.api.nvim_create_autocmd("BufLeave", {
        buffer = buf,
        once = true,
        callback = function()
            vim.defer_fn(function()
                if vim.api.nvim_buf_is_valid(buf) then
                    local content = ui.get_buffer_content(buf)
                    if content and content:match "%S" then
                        if term_job_id and term_job_id > 0 then
                            terminal.send(term_job_id, content)
                        end
                    end
                end
            end, opts.processing.delay_ms)
        end,
    })
end

return M
