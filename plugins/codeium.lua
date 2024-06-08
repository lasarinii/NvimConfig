return {
    'Exafunction/codeium.vim',
    name = 'codeium',
    event = 'BufEnter',
    config = function ()
        vim.g.codeium_no_map_tab = true
    end,
}
