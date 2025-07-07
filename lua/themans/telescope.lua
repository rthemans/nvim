require("telescope").setup({
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {
            },
        },
    },

	defaults = {
		path_display={"smart"}
	},
})
require("telescope").load_extension("ui-select")

