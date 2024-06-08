local client = vim.lsp.start_client {
    name = "howtolsp",
    cmd = { "/home/euzinho/Coding/howtolsp/main" },
}

if not client then
    vim.notify "client?????"
    return
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.lsp.buf_attach_client(0, client)
    end,
})
