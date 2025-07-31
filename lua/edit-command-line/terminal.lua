local M = {}

function M.get_current_terminal_info()
    local term_buf = vim.fn.bufnr "%"
    local term_job_id = vim.fn.getbufvar(term_buf, "&channel")

    return {
        buf = term_buf,
        job_id = term_job_id,
    }
end

function M.send(job_id, content)
    if not job_id or job_id <= 0 then
        return false, "Invalid job_id"
    end

    if not content or not content:match "%S" then
        return false, "No content to send"
    end

    vim.fn.chansend(job_id, content)
    return true, nil
end

return M
