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
      vim.b.compressed = true
		end
	end,
})

vim.api.nvim_create_autocmd({ "BufWritePost", "FileWritePost" }, {
	pattern = "*.kmy",
	callback = function(args)
    if vim.b.compressed then
      require("kmymoney").gzip_write(args.file)
    end
	end,
})
