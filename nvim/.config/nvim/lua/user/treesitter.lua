local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

configs.setup {
    ensure_installed = "all",
    sync_install = false,
    ignore_install = { "" },
    autopairs = {
        enable = true,
    },
    autotag = {
        enable = true,
    },
    tree_docs = {
        enable = true
    },
    highlight = {
        enable = true,
        disable = { "" },
        -- additional_vim_regex_highlighting = true,
    },
    indent = { enable = false, disable = { "yaml" } },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
} -- END OF TREESITTER
