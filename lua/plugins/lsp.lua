-- ~/.config/nvim/lua/plugins/lsp.lua
-- Используем нативный vim.lsp.config API (Neovim 0.12+)

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem = {
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    },
}

-- Общая функция для keymaps
local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr }

    -- Навигация
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

    -- Рабочее пространство
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<space>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)

    -- Действия
    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<space>f", function()
        vim.lsp.buf.format({ async = true })
    end, opts)

    -- Диагностика
    vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
end

-- Telescope LSP интеграция
vim.keymap.set("n", "tgd", function()
    require("telescope.builtin").lsp_definitions()
end, { desc = "[T]elescope [G]oto [D]efinition" })

vim.keymap.set("n", "tgr", function()
    require("telescope.builtin").lsp_references({ jump_type = "never" })
end, { desc = "[T]elescope [G]oto [R]eferences" })

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = false,
})

-- Регистрируем LSP серверы через vim.lsp.config

-- 1. gopls для Go
vim.lsp.config['gopls'] = {
    cmd = { "gopls" },
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "go" },
    root_markers = { "go.work", "go.mod", ".git" },
    settings = {
        gopls = {
            directoryFilters = {
                --				"-",
                "-library",
                "+junk/mortalturtle",
                "+xiva/core/gocommon",
                "+xiva/private_api",
                "+xiva/sms_relay",
                "+xiva/sms_feedback",
                "+library/go",
            },
            expandWorkspaceToModule = false,
            analyses = {
                unreachable = true,
                unusedparams = true,
                shadow = true,
            },
            staticcheck = true,
            gofumpt = true,
            completeUnimported = true,
            usePlaceholders = true,
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
        },
    },
}

-- 2. pylsp для Python
vim.lsp.config['pylsp'] = {
    cmd = { "pylsp" },
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    enabled = true,
                    maxLineLength = 120,
                },
                pylint = {
                    enabled = true,
                },
                autopep8 = {
                    enabled = false,
                },
                black = {
                    enabled = true,
                    line_length = 120,
                },
                mypy = { enabled = true },
            },
        },
    },
}

-- 3. clangd для C/C++
vim.lsp.config['clangd'] = {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--completion-style=detailed",
        "--all-scopes-completion",
        "--cross-file-rename",
    },
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    root_markers = { ".clangd", "compile_commands.json", "compile_flags.txt", ".git" },
}

-- 4. yamlls для YAML
vim.lsp.config['yamlls'] = {
    cmd = { "yaml-language-server", "--stdio" },
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "yaml", "yml" },
    root_markers = { ".git", ".yamllint" },
    settings = {
        yaml = {
            format = { enable = true },
            completion = true,
            hover = true,
            validate = true,
            schemaStore = {
                enable = true,
                url = "https://schemastore.org",
            },
        },
    },
}

-- 5. jsonls для JSON
vim.lsp.config['jsonls'] = {
    cmd = { "vscode-json-language-server", "--stdio" },
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "json", "jsonc" },
    root_markers = { ".jsonlint", ".git" },
    settings = {
        json = {
            format = {
                enable = true,
            },
            validate = { enable = true },
        },
    },
}

-- 6. lua_ls для Lua
vim.lsp.config['lua_ls'] = {
    cmd = { "lua-language-server" },
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = { enable = false },
            format = { enable = true },
        },
    },
}

-- 7. bashls для Bash
vim.lsp.config['bashls'] = {
    cmd = { "bash-language-server", "start" },
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "sh", "bash" },
    root_markers = { ".bashrc", ".bash_profile", ".git" },
}

-- 8. dockerls для Docker
vim.lsp.config['dockerls'] = {
    cmd = { "docker-langserver", "--stdio" },
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "dockerfile" },
    root_markers = { "Dockerfile", ".dockerignore", ".git" },
}

-- 9. sqls для SQL
vim.lsp.config['sqls'] = {
    cmd = { "sqls" },
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "sql" },
    root_markers = { ".sqls.yml", ".git" },
}

vim.lsp.enable('gopls')
vim.lsp.enable('pylsp')
vim.lsp.enable('clangd')
vim.lsp.enable('yamlls')
vim.lsp.enable('jsonls')
vim.lsp.enable('lua_ls')
vim.lsp.enable('bashls')
vim.lsp.enable('dockerls')
vim.lsp.enable('sqls')

-- Проверка статуса LSP
vim.api.nvim_create_user_command('LspStatus', function()
    local clients = vim.lsp.get_clients()
    if #clients == 0 then
        print("No active LSP clients")
    else
        print("Active LSP clients:")
        for _, client in ipairs(clients) do
            local pid_info = client.pid and tostring(client.pid) or "unknown"
            print(string.format("  - %s (pid: %s)", client.name, pid_info))
        end
    end
end, { desc = "Show active LSP clients" })

-- Дополнительная команда для отладки
vim.api.nvim_create_user_command('LspLog', function()
    vim.cmd('checkhealth vim.lsp')
    local log_path = vim.lsp.get_log_path()
    print("LSP log file: " .. log_path)
end, { desc = "Show LSP log path" })
