local M = {}

function M.is_compressed(file_path)
	local file = assert(io.open(file_path, "rb"))
	local magic_number = file:read(2)
	file:close()

	return magic_number == "\x1f\x8b"
end

function M.set_binary_if_compressed(file_path)
	if M.is_compressed(file_path) then
		vim.bo.binary = true
	end
end

return M
