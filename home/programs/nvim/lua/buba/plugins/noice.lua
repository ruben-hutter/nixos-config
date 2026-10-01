return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        presets = {
            bottom_search = false,
            command_palette = false,
            long_message_to_split = true,
            inc_rename = false,
            lsp_doc_border = false,
        },
        routes = {
            {
                view = "notify",
                filter = { event = "msg_showmode" },
            },
            {
                # Nvim 0.12 deprecation spam from plugins pinned for 0.11
                # (nvim-colorizer tbl_flatten, archived nvim-treesitter
                # master vim.validate). Filtered only as notifications;
                # :checkhealth vim.deprecated still lists them.
                filter = {
                    event = "notif",
                    warning = true,
                    find = "is deprecated",
                },
                opts = { skip = true },
            },
        },
    },
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    }
}
