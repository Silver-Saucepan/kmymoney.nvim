if vim.fn.has("nvim-0.7.0") ~= 1 then
	vim.api.nvim_err_writeln("kmymoney.nvim requires at least nvim-0.7.0")
end

vim.api.nvim_create_autocmd({ "BufReadPre", "FileReadPre" }, {
	pattern = "*.kmy",
	callback = function(args)
		require("kmymoney").set_binary_if_compressed(args.file)
	end,
})

vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
	pattern = "*.kmy",
	callback = function(args)
		require("kmymoney").decompress(args.file)
	end,
})
