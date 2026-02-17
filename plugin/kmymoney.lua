if vim.fn.has("nvim-0.7.0") ~= 1 then
	vim.api.nvim_echo({ "kmymoney.nvim requires at least nvim-0.7.0" }, true, { err = true })
end

vim.api.nvim_create_autocmd({ "BufReadPre", "FileReadPre" }, {
	pattern = "*.kmy",
	callback = function(args)
		require("kmymoney").set_binary_if_compressed(args.file)
	end,
})

vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
	pattern = "*.kmy",
	callback = function()
		if vim.bo.binary then
			vim.cmd("silent '[,']!gzip -d")
			vim.bo.binary = false
			vim.bo.filetype = "xml"
		end
	end,
})
