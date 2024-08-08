return { -- Java setup because college
	"nvim-java/nvim-java",

	config = function()
		require("java").setup({
			jdk = {
				auto_install = false,
			},
		})
	end,
}
