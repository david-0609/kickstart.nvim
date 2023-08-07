local M = {}

-- Custom On Attach function
M.on_attach = function(client, bufnr)

    -- Mappings.
    vim.keymap.set("n", "<space>a", vim.lsp.buf.code_action)
    vim.keymap.set("n", "<space>i", vim.lsp.buf.implementation)
    vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)
    vim.keymap.set("n", "<space>gr", vim.lsp.buf.references)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename)
    vim.keymap.set("n", "<space>f", function() vim.lsp.buf.format({ async = true }) end)
    vim.keymap.set("n", "<space>d", function() vim.lsp.buf.definition({ reuse_win = true }) end)
    vim.keymap.set("n", "<space>D", function() vim.lsp.buf.declaration({ reuse_win = true }) end)

    -- Use rust-tools.nvim's hover if we're editing rust, else fallback to the default hover handler
    local filetype = vim.bo.filetype
    if vim.tbl_contains({ "rust" }, filetype) then
        vim.keymap.set("n", "K", "<cmd>lua require'rust-tools'.hover_actions.hover_actions()<CR>")
    else
        vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
    end

    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
        augroup lsp_document_highlight
        autocmd!
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        hi LspReferenceRead  cterm=bold ctermbg=red guibg=#4b1b89
        hi LspReferenceWrite cterm=bold ctermbg=red guibg=#4b1b89
        hi LspReferenceText  cterm=bold ctermbg=red guibg=#4b1b89
        augroup END
    ]],
            false
        )
    end

    if client.server_capabilities["documentSymbolProvider"] then require("nvim-navic").attach(client, bufnr) end

    -- Customizing how diagnostics are displayed
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = {
            prefix = "■", -- Could be '■', '▎', 'x', '●'
            signs = true,
            underline = true,
            update_in_insert = true,
        },
    })
end

M.capabilities = require("cmp_nvim_lsp").default_capabilities()
M.capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

return M
