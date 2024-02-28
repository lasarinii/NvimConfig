local FileName = {
    provider = function ()
        local filename = vim.fn.fnamemodify((vim.api.nvim_buf_get_name(0)), ":~")
        if filename == "" then return "[No Name]" end
        return filename
    end,
}
local FileType = {
    provider = function ()
        local type = vim.bo.filetype
        if type == "netrw" then return "[?]" end
        return "[" .. vim.bo.filetype .. "]"
    end,
}
local FileFlags = {
    {
        condition = function()
            return vim.bo.modified
        end,
        provider = "[+]",
    },
    {
        condition = function()
            return not vim.bo.modifiable
        end,
        provider = "",
    },
    {
        condition = function()
            return vim.bo.modifiable and not vim.bo.modified
        end,
        provider = "[-]"
    },
}
local Ruler = {
    provider = "%7(%l/%L%) %P ",
}
local ScrollBar ={
    static = {
        sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' }
        -- Another variant, because the more choice the better.
        -- sbar = { '🭶', '🭷', '🭸', '🭹', '🭺', '🭻' }
    },
    provider = function(self)
        local curr_line = vim.api.nvim_win_get_cursor(0)[1]
        local lines = vim.api.nvim_buf_line_count(0)
        local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
        return string.rep(self.sbar[i], 2)
    end,
}
local LSP = {
    update = {'LspAttach', 'LspDetach'},
    provider = function ()
        local names = {}
        for i, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
            table.insert(names, server.name)
        end
        local res = table.concat(names, " ")
        if res == "" then return "[?]" end
        return "[" .. res .. "] "
    end
}
local Diagnostics = {

    -- condition = conditions.has_diagnostics,

    -- static = {
    --     error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
    --     warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
    --     info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
    --     hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
    -- },

    init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    end,

    update = { "DiagnosticChanged", "BufEnter" },

    {
        condition = function (self)
            if self.errors == 0 then return false else return true end
        end,
        provider = function(self)
            -- 0 is just another output, we can decide to print it or not!
            return self.errors > 0 and (self.errors .. " ")
        end,
        hl = { fg = "red" },
    },
    {
        condition = function (self)
            if self.warnings == 0 then return false else return true end
        end,
        provider = function(self)
            return self.warnings > 0 and (self.warnings .. " ")
        end,
        hl = { fg = "orange" },
    },
    {
        condition = function (self)
            if self.info == 0 then return false else return true end
        end,
        provider = function(self)
            return self.info > 0 and (self.info .. " ")
        end,
        hl = { fg = "yellow" },
    },
    {
        condition = function (self)
            if self.hints == 0 then return false else return true end
        end,
        provider = function(self)
            return self.hints > 0 and (self.hints)
        end,
        hl = { fg = "green" },
    },
    {
        provider = " "
    },
}
local Git = {
        -- • `added` - Number of added lines.
        -- • `changed` - Number of changed lines.
        -- • `removed` - Number of removed lines.
        -- • `head` - Name of current HEAD (branch or short commit hash).
        -- • `root` - Top level directory of the working tree.
        -- • `gitdir` - .git directory.
    --
    -- init = function(self)
    --     self.status_dict = vim.b.gitsigns_status_dict
    --     self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    -- end,
    --
    {   -- git branch name
        condition = function ()
            if vim.g.gitsigns_head == nil then return false else return true end
        end,
        provider = function ()
            return " " .. vim.g.gitsigns_head
        end,
        hl = { bold = true },
    },
    {
        condition = function()
            if vim.b.gitsigns_status_dict == nil then return false else return true end
        end,
        provider = function()
            local count = vim.b.gitsigns_status_dict['added'] or 0
            return count > 0 and (" +" .. count)
        end,
        hl = { fg = "green" },
    },
    {
        condition = function()
            if vim.b.gitsigns_status_dict == nil then return false else return true end
        end,
        provider = function()
            local count = vim.b.gitsigns_status_dict['removed'] or 0
            return count > 0 and (" -" .. count)
        end,
        hl = { fg = "red" },
    },
    {
        condition = function()
            if vim.b.gitsigns_status_dict == nil then return false else return true end
        end,
        provider = function()
            local count = vim.b.gitsigns_status_dict['changed'] or 0
            return count > 0 and (" ~" .. count)
        end,
        hl = { fg = "orange" },
    },
}

return {
    'rebelot/heirline.nvim',
    name = 'heirline',
    event = 'UIEnter',
    config = function ()
        require('heirline').setup({
            statusline = {
                FileName,
                { provider = " "},
                FileFlags,
                { provider = " "},
                FileType,
                { provider = "%=" },
                { provider = "%=" },
                Git,
                Diagnostics,
                LSP,
                Ruler,
                ScrollBar,
            },
        })
    end,
}

