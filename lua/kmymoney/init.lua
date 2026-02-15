local M = {}

function M.decompress()
	vim.cmd("silent '[,']w! /tmp/foo")
	os.execute("gzip -d < /tmp/foo > /tmp/bar")
	vim.cmd("'[,']d _")
	vim.cmd("setlocal nobin")
	vim.cmd("r /tmp/bar")
  vim.cmd("1 d")
  vim.bo.filetype = "xml"
end

return M
