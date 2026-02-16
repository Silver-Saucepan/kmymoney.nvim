local M = {}

function M.is_compressed(file_path)
	local file = io.open(file_path, "rb")
	if not file then
		print("Could  not open file: " .. file_path)
		return
	end

	local magic_number = file:read(2)
	file:close()

	return magic_number == "\x1f\x8b"
end

function M.set_binary_if_compressed(file_path)
  if M.is_compressed(file_path) then
    vim.bo.binary = true
  end
end

function M.decompress(file_path)
	if M.is_compressed(file_path) then
		vim.cmd("silent '[,']!gzip -d")
    vim.bo.binary = false
    vim.bo.filetype = "xml"
	end
end

return M
