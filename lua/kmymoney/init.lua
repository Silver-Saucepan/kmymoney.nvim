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

function M.gzip_write(file_path)
	local uv = vim.uv or vim.loop -- Use vim.uv for Neovim 0.10+
	local fpe = vim.fn.escape(file_path, " ")
	local temp_name = fpe .. ".bak" -- fs_rename requires temp_name to be on the same filesystem as file_path
	uv.fs_rename(fpe, temp_name)

	vim.system({ "sh", "-c", "gzip < " .. temp_name .. " > " .. fpe }, { text = true }, function(obj)
		if obj.code ~= 0 then
			print("Failed to compress file with code: " .. obj.code .. " Original file saved with .bak suffix")
    else
      uv.fs_unlink(temp_name)
		end
	end)
end

return M
