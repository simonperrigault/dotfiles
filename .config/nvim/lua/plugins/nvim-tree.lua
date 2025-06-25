return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local api = require("nvim-tree.api")

        local function edit_or_open()
            local node = api.tree.get_node_under_cursor()

            if node.nodes ~= nil then
                -- expand or collapse folder
                api.node.open.edit()
            else
                -- open file
                api.node.open.edit()
                -- Close the tree if file was opened
                api.tree.close()
            end
        end

        -- open as vsplit on current node
        local function vsplit_preview()
            local node = api.tree.get_node_under_cursor()

            if node.nodes ~= nil then
                -- expand or collapse folder
                api.node.open.edit()
            else
                -- open file as vsplit
                api.node.open.vertical()
            end

            -- Finally refocus on tree if it was lost
            api.tree.focus()
        end


        -- On utilise <leader>e pour ouvrir/fermer l'explorateur
        vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Ouverture/fermeture de l'explorateur de fichiers" })

        -- on_attach
        local function my_on_attach(bufnr)
            local function opts(desc)
                return {desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            api.config.mappings.default_on_attach(bufnr)

            vim.keymap.set("n", "l", edit_or_open,          opts("Edit Or Open"))
            vim.keymap.set("n", "L", vsplit_preview,        opts("Vsplit Preview"))
            vim.keymap.set("n", "h", api.tree.close,        opts("Close"))
            vim.keymap.set("n", "H", api.tree.collapse_all, opts("Collapse All"))
        end

        require("nvim-tree").setup({on_attach = my_on_attach})

        -- Make :bd and :q behave as usual when tree is visible
        vim.api.nvim_create_autocmd({'BufEnter', 'QuitPre'}, {
            nested = false,
            callback = function(e)
                local tree = require('nvim-tree.api').tree

                -- Nothing to do if tree is not opened
                if not tree.is_visible() then
                    return
                end

                -- How many focusable windows do we have? (excluding e.g. incline status window)
                local winCount = 0
                for _,winId in ipairs(vim.api.nvim_list_wins()) do
                    if vim.api.nvim_win_get_config(winId).focusable then
                        winCount = winCount + 1
                    end
                end

                -- We want to quit and only one window besides tree is left
                if e.event == 'QuitPre' and winCount == 2 then
                    vim.api.nvim_cmd({cmd = 'qall'}, {})
                end

                -- :bd was probably issued an only tree window is left
                -- Behave as if tree was closed (see `:h :bd`)
                if e.event == 'BufEnter' and winCount == 1 then
                    -- Required to avoid "Vim:E444: Cannot close last window"
                    vim.defer_fn(function()
                        -- close nvim-tree: will go to the last buffer used before closing
                        tree.toggle({find_file = true, focus = true})
                        -- re-open nivm-tree
                        tree.toggle({find_file = true, focus = false})
                    end, 10)
                end
            end
        })
    end,
}

