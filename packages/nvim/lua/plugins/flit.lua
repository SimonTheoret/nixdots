return {
    'ggandor/flit.nvim',
    dependencies = { 'ggandor/leap.nvim' },
    config = function()
        require('flit').setup({
            keys = { f = 'f', F = 'F', t = 't', T = 'T' },
            -- A string like "nv", "nvo", "o", etc.
            labeled_modes = "v",
            multiline = false, -- I do not want multiline
            -- Like `leap`s similar argument (call-specific overrides).
            -- E.g.: opts = { equivalence_classes = {} }
            opts = {}
        })
    end,
    lazy = false
    -- keys = {"f", "F", "T", "t"}
}
