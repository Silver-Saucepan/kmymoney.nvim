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

function M.gzip_write(file_path)
	local uv = vim.uv or vim.loop -- Use vim.uv for Neovim 0.10+
	-- fs_rename requires temp_name to be on the same filesystem as file_path
	local temp_path = file_path .. ".bak"
	local fpe = vim.fn.escape(file_path, " \\")
	local tpe = vim.fn.escape(temp_path, " \\")
	local success, err = uv.fs_rename(fpe, tpe)
	if success then
		vim.system({ "sh", "-c", "gzip < " .. tpe .. " > " .. fpe }, { text = true }, function(obj)
			if obj.code ~= 0 then
				print("Failed to compress file with code: " .. obj.code)
        uv.fs_rename(tpe, fpe)
      else
        uv.fs_unlink(tpe)
			end
		end)
  else
    print("Failed to compress file, could not create temporary file: " .. err)
	end
end

return M
