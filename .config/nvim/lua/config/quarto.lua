require("quarto").setup({
    lspFeatures = {
        enabled = true,
        languages = { "r", "python", "lua" },
        completion = { enabled = true },
	},
	codeRunner = {
	    enabled = false,
		default_method = "molten", -- molten seems cool, will look into
	},
})