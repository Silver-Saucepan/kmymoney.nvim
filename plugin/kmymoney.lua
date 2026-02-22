vim.api.nvim_create_autocmd({ "BufReadPre" }, {
	pattern = "*.kmy",
	callback = function(args)
		require("kmymoney").set_binary_if_compressed(args.file)
	end,
})

vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
	pattern = "*.kmy",
	callback = function()
		if vim.bo.binary then
			vim.cmd("silent %!gzip -d")
			vim.bo.binary = false
			vim.bo.filetype = "xml"
      vim.b.compressed = true
		end
	end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = "*.kmy",
	callback = function(args)
    if vim.b.compressed then
			vim.bo.binary = true
			vim.cmd("silent %!gzip")
    end
	end,
})
